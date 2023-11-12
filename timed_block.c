typedef struct timed_blocks {
    uint64_t blocks[64];
    uint32_t calls[64];
    char* block_names[64];
} timed_blocks_t;

void timed_blocks__print(timed_blocks_t* self, uint32_t number_of_iters) {
    printf("--== Timed blocks ==--\n");
    if (self->blocks[_INS_SIZE] == 0) {
        return ;
    }

    for (uint32_t i = 0; i < sizeof(self->blocks) / sizeof(self->blocks[0]); ++i) {
        if (self->blocks[i] != 0) {
            printf(
                "Block %-20s n of times called: %5lu total time taken: %10.3lfcy time taken each: %10.3lfcy %30s: %6.3lf%%\n",
                self->block_names[i],
                self->calls[i] / number_of_iters,
                (double) self->blocks[i] / (double) number_of_iters,
                (double) self->blocks[i] / (double) self->calls[i],
                "average time taken: ", 100.0 * (double) self->blocks[i] / (double) self->blocks[_INS_SIZE]
            );
        }
    }
}

#if defined(PROFILING)
# define TIMED_BLOCK(x, timed_blocks_p, timed_block_enum) do { \
        uint64_t time_start = __rdtsc(); \
        x; \
        uint64_t time_end = __rdtsc(); \
        (timed_blocks_p)->blocks[(timed_block_enum)] += time_end - time_start; \
        (timed_blocks_p)->block_names[(timed_block_enum)] = #timed_block_enum; \
        (timed_blocks_p)->calls[(timed_block_enum)]++; \
    } while (false)
#else
# define TIMED_BLOCK(x, timed_blocks_p, timed_block_enum) x
#endif