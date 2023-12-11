#include "app.h"

#include "debug.h"

#define STB_IMAGE_IMPLEMENTATION
#include "third_party/stb/stb_image.h"

#include <string.h>
#include <unistd.h>
#include <time.h>

static void app__process_events(app_t* self) {
    const char* first_col_name = "Frame";
    const char* second_col_name = "Button               ";
    const char* third_col_name = "Transitions";
    const char* forth_col_name = "Repeats";
    const char* fifth_col_name = "State    ";
    const uint32_t first_col_len = strlen(first_col_name);
    const uint32_t second_col_len = strlen(second_col_name);
    const uint32_t third_col_len = strlen(third_col_name);
    const uint32_t forth_col_len = strlen(forth_col_name);
    const uint32_t fifth_col_len = strlen(fifth_col_name);
    const uint32_t col_pad = 4;

    if (window__received_button_input(self->window)) {
        debug__write(
            "%-*.*s%*c"
            "%-*.*s%*c"
            "%-*.*s%*c"
            "%-*.*s%*c"
            "%-*.*s",
            first_col_len, first_col_len, first_col_name, col_pad, ' ',
            second_col_len, second_col_len, second_col_name, col_pad, ' ',
            third_col_len, third_col_len, third_col_name, col_pad, ' ',
            forth_col_len, forth_col_len, forth_col_name, col_pad, ' ',
            fifth_col_len, fifth_col_len, fifth_col_name
        );
        for (uint32_t i = 0; i < sizeof(self->window->buttons) / sizeof(self->window->buttons[0]); ++i) {
            uint32_t n_of_transitions = window__button_n_of_transitions(self->window, i);
            uint32_t n_of_repeats = window__button_n_of_repeats(self->window, i);
            if (n_of_transitions > 0 || n_of_repeats > 0) {
                debug__write(
                    "%-*u%*c"
                    "%-*.*s%*c"
                    "%-*u%*c"
                    "%-*u%*c"
                    "%-.*s",
                    first_col_len, self->frame_count, col_pad, ' ',
                    second_col_len, second_col_len, button__to_str(i), col_pad, ' ',
                    third_col_len, n_of_transitions, col_pad, ' ',
                    forth_col_len, n_of_repeats, col_pad, ' ',
                    fifth_col_len, window__button_is_down(self->window, i) ? "Pressed" : "Released"
                );
            }
        }
        debug__flush(DEBUG_MODULE_APP, DEBUG_INFO);
    }
}

bool app__create(app_t* self, int argc, char* argv[]) {
    (void) argc;
    (void) argv;

    memset(self, 0, sizeof(*self));

    int number_of_channels_per_pixel;
    self->window_icon.data = stbi_load("assets/icon.png", (int32_t*) &self->window_icon.w, (int32_t*) &self->window_icon.h, &number_of_channels_per_pixel, 0);
    if (!self->window_icon.data) {
        return false;
    }

    if (!glfw__init()) {
        return false;
    }

    uint32_t number_of_monitors;
    monitor_t* monitors = monitor__get_monitors(&number_of_monitors);
    if (number_of_monitors == 0) {
        glfw__destroy();
        return false;
    }

    self->monitor = monitors[0];
    self->window = window__create(self->monitor, "Title", 100, 300);
    if (!self->window) {
        glfw__destroy();
        return false;
    }

    window__set_icon(self->window, self->window_icon.data, self->window_icon.w, self->window_icon.h);

    return true;
}

void app__destroy(app_t* self) {
    window__destroy(self->window);
    glfw__destroy();

    if (self->window_icon.data) {
        stbi_image_free(self->window_icon.data);
    }
}

void app__run(app_t* self) {
    window__set_current_window(self->window);

    const uint32_t min_w = 100;
    const uint32_t min_h = 100;
    const uint32_t max_w = 1000;
    const uint32_t max_h = 1000;
    window__set_size_limit(self->window, min_w, min_h, max_w, max_h);
    window__set_content_area_size(self->window, max_w / 2, max_h / 2);
    // window__set_fullscreen(self->window, true);

    window__set_window_opacity(self->window, 0.89);

    const double target_fps = 30.0;
    while (!window__get_should_close(self->window)) {
        struct timespec time_start;
        clock_gettime(CLOCK_REALTIME, &time_start);

        window__clear_button_state(self->window);
        glfw__poll_events();
        app__process_events(self);

        window__swap_buffers(self->window);

        struct timespec time_end;
        clock_gettime(CLOCK_REALTIME, &time_end);

        while (target_fps * (double) (time_end.tv_sec * 1000000000 + time_end.tv_nsec - time_start.tv_sec * 1000000000 - time_start.tv_nsec) < 1000000000.0) {
            usleep(0);
            clock_gettime(CLOCK_REALTIME, &time_end);
        }

        ++self->frame_count;
    }
}
