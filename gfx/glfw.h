#ifndef GLFW_H
# define GLFW_H

# include <GLFW/glfw3.h>
# include <stdbool.h>
# include <stdint.h>

bool glfw__init();
void glfw__destroy();
// @brief polls all pending events and inputs, which in turn calls all callbacks associated with every window
void glfw__poll_events();
// @brief blocks thread and waits for at least one incoming event
void glfw__wait_events();

typedef GLFWmonitor* monitor_t;

monitor_t* monitor__get_monitors(uint32_t* number_of_monitors);

void monitor__get_screen_size(monitor_t self, uint32_t* w, uint32_t* h);
// @brief get monitor's workable area that is not occupied by global menu/task bars
void monitor__get_work_area(monitor_t self, int32_t* x, int32_t* y, uint32_t* w, uint32_t* h);

// @brief virtual buttons
// todo: customize shortcut
typedef enum button {
    BUTTON_0, BUTTON_1, BUTTON_2, BUTTON_3, BUTTON_4, BUTTON_5, BUTTON_6, BUTTON_7, BUTTON_8, BUTTON_9,
    BUTTON_A, BUTTON_B, BUTTON_C, BUTTON_D, BUTTON_E, BUTTON_F, BUTTON_G, BUTTON_H, BUTTON_I, BUTTON_J, BUTTON_K, BUTTON_L, BUTTON_M,
    BUTTON_N, BUTTON_O, BUTTON_P, BUTTON_Q, BUTTON_R, BUTTON_S, BUTTON_T, BUTTON_U, BUTTON_V, BUTTON_W, BUTTON_X, BUTTON_Y, BUTTON_Z,
    BUTTON_LEFT, BUTTON_UP, BUTTON_RIGHT, BUTTON_DOWN,
    BUTTON_CAPS_LOCK,
    BUTTON_SHIFT,
    BUTTON_WINDOW_CLOSE /* default: esc, alt+f4 */,
    BUTTON_WINDOW_MINIMIZE,
    BUTTON_WINDOW_MAXIMIZE,
    BUTTON_WINDOW_WINDOWED,
    BUTTON_WINDOW_FULL_SCREEN /* alt + enter */,
    _BUTTON_SIZE
} button_t;
const char* button__to_str(button_t button);

typedef struct window* window_t;

typedef struct button_state {
    uint32_t n_of_transitions;
    uint32_t n_of_repeats;
    void     (*action_on_key_down_fn)(window_t);
    bool     ended_down;
    // todo: add shortcut state
} button_state_t;

struct window {
    GLFWwindow* glfw_window;
    monitor_t monitor;

    const char* title;

    // windowed state
    // content (without window frame) area top left corner position and dimensions
    int32_t  x;
    int32_t  y;
    uint32_t w;
    uint32_t h;

    bool           received_button_input;
    button_state_t buttons[_BUTTON_SIZE];
};

window_t window__create(monitor_t monitor, const char* title, uint32_t width, uint32_t height);
void window__destroy(window_t self);

void window__set_default_button_actions(window_t self, bool value);

void window__set_monitor(window_t self, monitor_t monitor);

void window__set_title(window_t self, const char* title);
const char* window__get_title(window_t self);

void window__set_current_window(window_t self);
window_t window__get_current_window();

void window__swap_buffers(window_t self);

void window__set_icon(window_t self, uint8_t* pixels, uint32_t w, uint32_t h);

void window__set_content_area_size(window_t self, uint32_t width, uint32_t height);
void window__get_content_area_size(window_t self, uint32_t* width, uint32_t* height);
// @brief includes window frame
void window__get_window_size(window_t self, uint32_t* width, uint32_t* height);
void window__get_window_frame_size(window_t self, int32_t* left, int32_t* top, int32_t* right, int32_t* bottom);

// @brief sets top left corner position in screen coordinates of the content area
void window__set_content_area_pos(window_t self, int32_t x, int32_t y);
void window__get_content_area_pos(window_t self, int32_t* x, int32_t* y);
// @brief includes window frame
void window__set_window_pos(window_t self, int32_t x, int32_t y);
// @brief includes window frame
void window__get_window_pos(window_t self, int32_t* x, int32_t* y);

typedef enum window_state {
    WINDOW_STATE_MINIMIZED,
    WINDOW_STATE_MAXIMIZED,
    WINDOW_STATE_WINDOWED,
    WINDOW_STATE_FULL_SCREEN
} window_state_t;

void window__set_state(window_t self, window_state_t state);
window_state_t window__get_state(window_t self);

void window__set_hidden(window_t self, bool value);
bool window__get_hidden(window_t self);

void window__set_focus(window_t self);
bool window__get_focus(window_t self);

void window__set_should_close(window_t self, bool value);
bool window__get_should_close(window_t self);

void window__request_attention(window_t self);

// @param opacity [0, 1], where 0 is fully transparent, and 1 is fully opaque
void window__set_window_opacity(window_t self, float opacity);
float window__get_window_opacity(window_t self);

// @brief set content area size limits
// @note supply 0 for any of the parameters if do not care
void window__set_size_limit(
    window_t self,
    uint32_t min_width, uint32_t min_height,
    uint32_t max_width, uint32_t max_height
);

// @note set either to 0 to disable enforcing aspect ratio
void window__set_aspect_ratio(window_t self, uint32_t num, uint32_t den);

void window__clear_button_state(window_t self);
bool window__received_button_input(window_t self);
// @brief current state of button
bool window__button_is_down(window_t self, button_t button);
uint32_t window__button_n_of_repeats(window_t self, button_t button);
// @brief number of press/release transitions
uint32_t window__button_n_of_transitions(window_t self, button_t button);

#endif // GLFW_H
