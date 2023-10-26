#include "gil_math/projecteuler/projecteuler.h"

#include "gil_math/random/random.h"
#include "memory/segment_allocator/segment_allocator.h"
#include "libc/libc.h"
#include "data_structures/heap/heap.h"

typedef struct monopoly_node {
    u32 index;
    u32 landed_on;
} monopoly_node_t;

static u32 cc(u32 original_index) {
    static s32 cc_cards[16];
    static bool is_init = false;
    static u32 index = 0;
    if (is_init == false) {
        is_init = true;
        for (u32 i = 0; i < ARRAY_SIZE(cc_cards); ++i) {
            cc_cards[i] = -1;
        }
        cc_cards[0] = 0; // go to GO
        cc_cards[1] = 10; // go to JAIL
    }
    s32 result = cc_cards[index++];
    if (index == ARRAY_SIZE(cc_cards)) {
        index = 0;
    }
    if (result == -1) {
        return original_index;
    } else {
        return (u32) result;
    }
}

static u32 ch(u32 original_index) {
    static s32 ch_cards[16];
    static bool is_init = false;
    static u32 index = 0;
    if (is_init == false) {
        is_init = true;
        for (u32 i = 0; i < ARRAY_SIZE(ch_cards); ++i) {
            ch_cards[i] = -1;
        }
        ch_cards[0] = 0; // go to GO
        ch_cards[1] = 10; // go to JAIL
        ch_cards[2] = 11; // go to C1 (11)
        ch_cards[3] = 24; // go to E3 (24)
        ch_cards[4] = 39; // go to H2 (39)
        ch_cards[5] = 5; // go to R1  (5)
        ch_cards[6] = -2; // go to next R (7->15, 22->25, 36->5)
        ch_cards[7] = -2; // go to next R (7->15, 22->25, 36->5)
        ch_cards[8] = -3; // go to next U (7->12, 22->28, 36->12)
        ch_cards[9] = -4; // go back 3 squares
    }
    s32 result = ch_cards[index++];
    if (index == ARRAY_SIZE(ch_cards)) {
        index = 0;
    }
    if (result == -1) {
        return original_index;
    } else if (result == -2) {
        // go to next R
        if (original_index == 7) return 15;
        if (original_index == 22) return 25;
        if (original_index == 36) return 5;
        ASSERT(false);
        return 0;
    } else if (result == -3) {
        // go to next U
        if (original_index == 7) return 12;
        if (original_index == 22) return 28;
        if (original_index == 36) return 12;
        ASSERT(false);
        return 0;
    } else if (result == -4) {
        // go back 3 squares
        return (original_index + 37) % 40;
    } else {
        return (u32) result;
    }
}

static u32 dispatch(u32 index) {
    switch (index) {
        case 2:
        case 17:
        case 33: {
            return cc(index);
        } break ;
        case 7:
        case 22:
        case 36: {
            index = ch(index);
            if (index == 33) {
                return cc(index);
            } else {
                return index;
            }
        } break ;
        case 30: {
            // go to JAIL
            return 10;
        } break ;
        default: return index;
    }

    ASSERT(false);
    return 0;
}

static u32 roll(random_t* random_gen, monopoly_node_t* nodes, const u32 board_size, u32 cur_node_index, const u32 die_sides, u32* number_of_consecutive_doubles) {
    const u32 roll_a = random__u64_closed(random_gen, 1, die_sides);
    const u32 roll_b = random__u64_closed(random_gen, 1, die_sides);
    if (roll_a == roll_b) {
        ++*number_of_consecutive_doubles;
    } else {
        *number_of_consecutive_doubles = 0;
    }

    if (*number_of_consecutive_doubles == 3) {
        cur_node_index = 10; // JAIL
        *number_of_consecutive_doubles = 0;
    } else {
        cur_node_index = dispatch((cur_node_index + roll_a + roll_b) % board_size);
    }
    ++nodes[cur_node_index].landed_on;

    return cur_node_index;
}

static void print_node(monopoly_node_t* node, const u32 number_of_rolls) {
    libc__printf("[%u: %.5lf%%]", node->index, 100.0 * (r64) node->landed_on / (r64) number_of_rolls);
}

static void print(monopoly_node_t* nodes, const u32 board_size, const u32 number_of_rolls) {
    for (u32 node_index = 0; node_index < board_size; ++node_index) {
        print_node(&nodes[node_index], number_of_rolls);
        libc__printf(" ");
    }
    libc__printf("\n");
}

static s32 monopoly_node_comparator(const void* node_a, const void* node_b) {
    const monopoly_node_t* monopoly_node_a = (const monopoly_node_t*)node_a;
    const monopoly_node_t* monopoly_node_b = (const monopoly_node_t*)node_b;

    return monopoly_node_a->landed_on > monopoly_node_b->landed_on ? -1 : monopoly_node_a->landed_on == monopoly_node_b->landed_on ? 0 : 1;
}

bool test_84(memory_slice_t memory_slice) {
    if (!seg__init(memory_slice)) {
        return false;
    }

    const u32 board_size = 40;
    seg_t nodes_seg = seg__malloc(memory_slice, board_size * sizeof(monopoly_node_t));
    monopoly_node_t* nodes = (monopoly_node_t*)seg__seg_to_data(nodes_seg);
    for (u32 node_index = 0; node_index < 40; ++node_index) {
        nodes[node_index].index = node_index;
        nodes[node_index].landed_on = 0;
    }

    random_t random_gen;
    random__init(&random_gen, 42);

    const u32 number_of_rolls = 100000000;
    u32 current_index = 0;
    u32 number_of_consecutive_doubles = 0;
    for (u32 roll_count = 0; roll_count < number_of_rolls; ++roll_count) {
        current_index = roll(&random_gen, nodes, board_size, current_index, 4, &number_of_consecutive_doubles);
        // if (roll_count % 1000000 == 0) {
        //     print(nodes, board_size, roll_count);
        // }
    }
    print(nodes, board_size, number_of_rolls);
    libc__printf("Number of rolls: %u\n", number_of_rolls);

    heap_t heap;
    ASSERT(heap__create(&heap, memory_slice__create(nodes, board_size * sizeof(monopoly_node_t)), sizeof(monopoly_node_t), board_size, &monopoly_node_comparator));
    monopoly_node_t node_a;
    monopoly_node_t node_b;
    monopoly_node_t node_c;
    heap__pop(&heap, &node_a);
    heap__pop(&heap, &node_b);
    heap__pop(&heap, &node_c);
    libc__printf("Top 3 nodes:\n");
    print_node(&node_a, number_of_rolls);
    libc__printf("\n");
    print_node(&node_b, number_of_rolls);
    libc__printf("\n");
    print_node(&node_c, number_of_rolls);
    libc__printf("\n");

    return true;
}
