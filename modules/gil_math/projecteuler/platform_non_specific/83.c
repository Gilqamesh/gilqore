#include "gil_math/projecteuler/projecteuler.h"

#include "libc/libc.h"
#include "io/file/file.h"
#include "io/file/file_reader/file_reader.h"
#include "io/file/file_writer/file_writer.h"
#include "memory/segment_allocator/segment_allocator.h"
#include "gil_math/compare/compare.h"
#include "data_structures/heap/heap.h"

static void write_matrix(file_writer_t* file_writer, file_t* file, int** matrix, const int rows, const int cols) {
    for (s32 row = 0; row < rows; ++row) {
        for (s32 col = 0; col < cols; ++col) {
            file_writer__write_format(file_writer, file, "%lu ", matrix[row][col]);
        }
        file_writer__write_format(file_writer, file, "\n");
    }
}

typedef struct heap_node {
    int row;
    int col;
} heap_node_t;

static int** g_distance_matrix = NULL;

s32 heap_node_comparator(const void* node_a, const void* node_b) {
    const heap_node_t* heap_node_a = (const heap_node_t*)node_a;
    const heap_node_t* heap_node_b = (const heap_node_t*)node_b;
    return g_distance_matrix[heap_node_a->row][heap_node_a->col] < g_distance_matrix[heap_node_b->row][heap_node_b->col] ? -1 :
        g_distance_matrix[heap_node_a->row][heap_node_a->col] == g_distance_matrix[heap_node_b->row][heap_node_b->col] ? 0 : 1;
}

static u64 solve_83(int** matrix, int** visited_matrix, int** distance_matrix, heap_node_t* heap_nodes, const int rows, const int cols) {
    // 1. mark all nodes as unvisited, assign tentative distance to infinity except for starting node
    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col) {
            visited_matrix[row][col] = 0;
            distance_matrix[row][col] = S32_MAX;
        }
    }
    g_distance_matrix = distance_matrix;
    heap_t heap;
    ASSERT(heap__create(&heap, memory_slice__create(heap_nodes, rows * cols * sizeof(*heap_nodes)), sizeof(heap_node_t), 0, &heap_node_comparator));
    // initial distance for starting node
    distance_matrix[0][0] = matrix[0][0];
    heap_node_t initial_node = {
        .row = 0,
        .col = 0
    };
    heap__push(&heap, &initial_node);
    while (heap__size(&heap) > 0) {
        heap_node_t cur_node;
        heap__pop(&heap, &cur_node);
        int row = cur_node.row;
        int col = cur_node.col;

        // 2. consider all unvisited neighbours of current node, and calculate their tentative distance from current node
        const int cur_dist = distance_matrix[row][col];
        ASSERT(cur_dist != S32_MAX);
        if (row > 0 && !visited_matrix[row - 1][col]) {
            int tentative_dist = cur_dist + matrix[row - 1][col];
            if (tentative_dist < distance_matrix[row - 1][col]) {
                distance_matrix[row - 1][col] = tentative_dist;
                cur_node.row = row - 1;
                cur_node.col = col;
                heap__push(&heap, &cur_node);
            }
        }
        if (row < rows - 1 && !visited_matrix[row + 1][col]) {
            int tentative_dist = cur_dist + matrix[row + 1][col];
            if (tentative_dist < distance_matrix[row + 1][col]) {
                distance_matrix[row + 1][col] = tentative_dist;
                cur_node.row = row + 1;
                cur_node.col = col;
                heap__push(&heap, &cur_node);
            }
        }
        if (col > 0 && !visited_matrix[row][col - 1]) {
            int tentative_dist = cur_dist + matrix[row][col - 1];
            if (tentative_dist < distance_matrix[row][col - 1]) {
                distance_matrix[row][col - 1] = tentative_dist;
                cur_node.row = row;
                cur_node.col = col - 1;
                heap__push(&heap, &cur_node);
            }
        }
        if (col < cols - 1 && !visited_matrix[row][col + 1]) {
            int tentative_dist = cur_dist + matrix[row][col + 1];
            if (tentative_dist < distance_matrix[row][col + 1]) {
                distance_matrix[row][col + 1] = tentative_dist;
                cur_node.row = row;
                cur_node.col = col + 1;
                heap__push(&heap, &cur_node);
            }
        }
        visited_matrix[row][col] = 1;
    }

    return distance_matrix[rows - 1][cols - 1];
}

bool test_83(const char* matrix_file_path, const char* write_out_path, memory_slice_t memory_slice) {
    if (!seg__init(memory_slice)) {
        return false;
    }

    // 1. allocate for the matrix
    const int rows = 80;
    const int cols = 80;
    seg_t matrix_seg = seg__malloc(memory_slice, rows * sizeof(int*));
    seg_t aux_matrix_seg = seg__malloc(memory_slice, rows * sizeof(int*));
    seg_t aux2_matrix_seg = seg__malloc(memory_slice, rows * sizeof(int*));
    seg_t aux3_matrix_seg = seg__malloc(memory_slice, rows * cols * sizeof(heap_node_t));
    int** matrix = seg__seg_to_data(matrix_seg);
    int** aux_matrix = seg__seg_to_data(aux_matrix_seg);
    int** aux2_matrix = seg__seg_to_data(aux2_matrix_seg);
    heap_node_t* aux3_matrix = seg__seg_to_data(aux3_matrix_seg);
    for (int row = 0; row < rows; ++row) {
        seg_t row_seg = seg__malloc(memory_slice, cols * sizeof(int));
        seg_t row_aux_seg = seg__malloc(memory_slice, cols * sizeof(int));
        seg_t row_aux2_seg = seg__malloc(memory_slice, cols * sizeof(int));
        matrix[row] = seg__seg_to_data(row_seg);
        aux_matrix[row] = seg__seg_to_data(row_aux_seg);
        aux2_matrix[row] = seg__seg_to_data(row_aux2_seg);
    }

    // 2. read into the matrix from the file
    file_t file;
    if (!file__open(&file, matrix_file_path, FILE_ACCESS_MODE_READ, FILE_CREATION_MODE_OPEN)) {
        return false;
    }

    // 3. create the file reader to parse the matrix file
    size_t file_reader_memory_size = KILOBYTES(1);
    seg_t file_reader_memory_seg = seg__malloc(memory_slice, file_reader_memory_size);
    void* file_reader_memory = seg__seg_to_data(file_reader_memory_seg);
    file_reader_t file_reader;
    if (!file_reader__create(&file_reader, file, memory_slice__create(file_reader_memory, file_reader_memory_size))) {
        return false;
    }

    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col) {
            if (!file_reader__read_s32(&file_reader, &matrix[row][col])) {
                return false;
            }
            if (col < cols - 1) {
                char c;
                if (file_reader__read_one(&file_reader, &c, sizeof(c)) != sizeof(c) || c != ',') {
                    return false;
                }
            }
        }

        if (row < rows - 1) {
            char c;
            if (file_reader__read_one(&file_reader, &c, sizeof(c)) != sizeof(c) || c != '\n') {
                return false;
            }
        }
    }

    // 4. close file
    file__close(&file);
    
    // 5. solve problem 83
    const u64 result_83 = solve_83(matrix, aux_matrix, aux2_matrix, aux3_matrix, rows, cols);

    // 6. write the matrix and the solution out
    size_t file_writer_size = BYTES(32);
    seg_t file_writer_seg = seg__malloc(memory_slice, file_writer_size);
    void* file_writer_data = seg__seg_to_data(file_writer_seg);
    file_writer_t file_writer;
    if (!file_writer__create(&file_writer, memory_slice__create(file_writer_data, file_writer_size))) {
        return false;
    }
    if (!file__open(&file, write_out_path, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE)) {
        return false;
    }
    write_matrix(&file_writer, &file, matrix, rows, cols);
    file_writer__write_format(&file_writer, &file, "\n");
    write_matrix(&file_writer, &file, aux_matrix, rows, cols);
    file_writer__write_format(&file_writer, &file, "\n");
    write_matrix(&file_writer, &file, aux2_matrix, rows, cols);
    file_writer__write_format(&file_writer, &file, "\n");
    file_writer__write_format(&file_writer, &file, "%lu", result_83);

    file__close(&file);

    return true;
}
