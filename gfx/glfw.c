#include "glfw.h"

#include "debug.h"

#include <stdlib.h>
#include <string.h>

static void glfw__error_callback(int code, const char* description);
static void glfw__monitor_callback(GLFWmonitor* monitor, int event);
static void window__should_close_callback(GLFWwindow* glfw_window);
static void window__pos_changed_callback(GLFWwindow* glfw_window, int x, int y);
static void window__size_changed_callback(GLFWwindow* glfw_window, int width, int height);
static window_t window__from_glfw_window(GLFWwindow* glfw_window);
static void wiondow__framebuffer_resize_callback(GLFWwindow* glfw_window, int width, int height);
static void window__content_scale_callback(GLFWwindow* glfw_window, float xscale, float yscale);
static void window__minimized_callback(GLFWwindow* glfw_window, int minimized);
static void window__maximized_callback(GLFWwindow* glfw_window, int maximized);
static void window__focus_callback(GLFWwindow* glfw_window, int focused);
static void window__key_callback(GLFWwindow* glfw_window, int key, int scancode, int action, int mods);
static void window__add_default_button_actions(window_t self);
static void window__button_default_action_window_close(window_t self);
static void window__button_default_action_window_minimize(window_t self);
static void window__button_default_action_window_maximize(window_t self);
static void window__button_default_action_window_windowed(window_t self);
static void window__button_default_action_window_full_screen(window_t self);

static void window__button_default_action_window_close(window_t self) {
    window__set_should_close(self, true);
}

static void window__button_default_action_window_minimize(window_t self) {
    window__set_state(self, WINDOW_STATE_MINIMIZED);
}

static void window__button_default_action_window_maximize(window_t self) {
    window__set_state(self, WINDOW_STATE_MAXIMIZED);
}

static void window__button_default_action_window_windowed(window_t self) {
    window__set_state(self, WINDOW_STATE_WINDOWED);
}

static void window__button_default_action_window_full_screen(window_t self) {
    window__set_state(self, WINDOW_STATE_FULL_SCREEN);
}

static void glfw__error_callback(int code, const char* description) {
    debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_ERROR, "code: [%d], description: [%s]", code, description);
}

static void glfw__monitor_callback(GLFWmonitor* monitor, int event) {
    if (event == GLFW_CONNECTED) {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "monitor %p has connected", monitor);
    } else if (GLFW_DISCONNECTED) {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "monitor %p has disconnected", monitor);
    }
}

static void window__should_close_callback(GLFWwindow* glfw_window) {
    window_t window = window__from_glfw_window(glfw_window);
    window__set_should_close(window, true);
}

static void window__pos_changed_callback(GLFWwindow* glfw_window, int x, int y) {
    window_t window = window__from_glfw_window(glfw_window);
    if (window__get_state(window) == WINDOW_STATE_WINDOWED) {
        window__get_content_area_pos(window, &x, &y);
        window->x = x;
        window->y = y;
    }
    debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window content area's position changed to: %d %d", x, y);
}

static void window__size_changed_callback(GLFWwindow* glfw_window, int width, int height) {
    window_t window = window__from_glfw_window(glfw_window);
    if (window__get_state(window) == WINDOW_STATE_WINDOWED) {
        window__get_content_area_size(window, (uint32_t*) &width, (uint32_t*) &height);
        window->w = width;
        window->h = height;
    }
    debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window content area's size changed to: %u %u", width, height);
}

static window_t window__from_glfw_window(GLFWwindow* glfw_window) {
    window_t window = (window_t) glfwGetWindowUserPointer(glfw_window);
    ASSERT(window);

    return window;
}

static void wiondow__framebuffer_resize_callback(GLFWwindow* glfw_window, int width, int height) {
    (void) glfw_window;

    debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "framebuffer dimensions changed to: %dpx %dpx", width, height);
    glViewport(0, 0, width, height);
}

static void window__content_scale_callback(GLFWwindow* glfw_window, float xscale, float yscale) {
    (void) glfw_window;

    debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "new content scale: %f %f", xscale, yscale);
}

static void window__minimized_callback(GLFWwindow* glfw_window, int minimized) {
    (void) glfw_window;

    if (minimized) {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window is minimized");
    } else {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window is restored");
    }
}

static void window__maximized_callback(GLFWwindow* glfw_window, int maximized) {
    (void) glfw_window;

    if (maximized) {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window is maximized");
    } else {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window is restored");
    }
}

static void window__focus_callback(GLFWwindow* glfw_window, int focused) {
    (void) glfw_window;
    
    if (focused) {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window has gained input focus");
    } else {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window has lost input focus");
    }
}

static void window__key_callback(GLFWwindow* glfw_window, int key, int scancode, int action, int mods) {
    (void) scancode;
    (void) mods;

    window_t window = window__from_glfw_window(glfw_window);
    button_t button = _BUTTON_SIZE;

    const bool is_key_down          = action == GLFW_PRESS || action == GLFW_REPEAT;
    const bool is_shift_down        = mods & GLFW_MOD_SHIFT;
    const bool is_ctrl_down         = mods & GLFW_MOD_CONTROL;
    const bool is_alt_down          = mods & GLFW_MOD_ALT;
    const bool is_super_down        = mods & GLFW_MOD_SUPER;
    const bool is_caps_lock_enabled = mods & GLFW_MOD_CAPS_LOCK;
    const bool is_num_lock_enabled  = mods & GLFW_MOD_NUM_LOCK;
    (void) is_shift_down;
    (void) is_ctrl_down;
    (void) is_super_down;
    (void) is_caps_lock_enabled;
    (void) is_num_lock_enabled;

    // map single key to button
    switch (key) {
    case GLFW_KEY_0: button = BUTTON_0; break ; case GLFW_KEY_1: button = BUTTON_1; break ; case GLFW_KEY_2: button = BUTTON_2; break ; case GLFW_KEY_3: button = BUTTON_3; break ; case GLFW_KEY_4: button = BUTTON_4; break ; case GLFW_KEY_5: button = BUTTON_5; break ; case GLFW_KEY_6: button = BUTTON_6; break ; case GLFW_KEY_7: button = BUTTON_7; break ; case GLFW_KEY_8: button = BUTTON_8; break ; case GLFW_KEY_9: button = BUTTON_9; break ;
    case GLFW_KEY_A: button = BUTTON_A; break ; case GLFW_KEY_B: button = BUTTON_B; break ; case GLFW_KEY_C: button = BUTTON_C; break ; case GLFW_KEY_D: button = BUTTON_D; break ; case GLFW_KEY_E: button = BUTTON_E; break ; case GLFW_KEY_F: button = BUTTON_F; break ; case GLFW_KEY_G: button = BUTTON_G; break ; case GLFW_KEY_H: button = BUTTON_H; break ; case GLFW_KEY_I: button = BUTTON_I; break ; case GLFW_KEY_J: button = BUTTON_J; break ; case GLFW_KEY_K: button = BUTTON_K; break ; case GLFW_KEY_L: button = BUTTON_L; break ; case GLFW_KEY_M: button = BUTTON_M; break ;
    case GLFW_KEY_N: button = BUTTON_N; break ; case GLFW_KEY_O: button = BUTTON_O; break ; case GLFW_KEY_P: button = BUTTON_P; break ; case GLFW_KEY_Q: button = BUTTON_Q; break ; case GLFW_KEY_R: button = BUTTON_R; break ; case GLFW_KEY_S: button = BUTTON_S; break ; case GLFW_KEY_T: button = BUTTON_T; break ; case GLFW_KEY_U: button = BUTTON_U; break ; case GLFW_KEY_V: button = BUTTON_V; break ; case GLFW_KEY_W: button = BUTTON_W; break ; case GLFW_KEY_X: button = BUTTON_X; break ; case GLFW_KEY_Y: button = BUTTON_Y; break ; case GLFW_KEY_Z: button = BUTTON_Z; break ;
    case GLFW_KEY_LEFT: button = BUTTON_LEFT; break ; case GLFW_KEY_UP: button = BUTTON_UP; break ; case GLFW_KEY_RIGHT: button = BUTTON_RIGHT; break ; case GLFW_KEY_DOWN: button = BUTTON_DOWN; break ;
    case GLFW_KEY_CAPS_LOCK: button = BUTTON_CAPS_LOCK; break ; case GLFW_KEY_LEFT_SHIFT: button = BUTTON_SHIFT; break ; case GLFW_KEY_RIGHT_SHIFT: button = BUTTON_SHIFT; break ;
    case GLFW_KEY_ESCAPE: {
        button = BUTTON_WINDOW_CLOSE;
    } break ;
    case GLFW_KEY_F4: {
        if (is_alt_down) {
            button = BUTTON_WINDOW_CLOSE;
        }
    } break ;
    case GLFW_KEY_ENTER: {
        if (is_alt_down) {
            if (window__get_state(window) != WINDOW_STATE_FULL_SCREEN) {
                button = BUTTON_WINDOW_FULL_SCREEN;
            } else {
                button = BUTTON_WINDOW_WINDOWED;
            }
        }
    } break ;
    }

    if (button == _BUTTON_SIZE) {
        return ;
    }

    button_state_t* button_state = &window->buttons[button];

    if (is_key_down && button_state->action_on_key_down_fn) {
        button_state->action_on_key_down_fn(window);
    }

    const bool was_down = button_state->ended_down;
    if (
        (action == GLFW_PRESS && !was_down) ||
        (action == GLFW_RELEASE && was_down)
    ) {
        window->received_button_input = true;
        ++button_state->n_of_transitions;
        debug__write_and_flush(
            DEBUG_MODULE_GLFW, DEBUG_INFO,
            "button transition [%s]: %s -> %s",
            button__to_str(button),
            was_down ? "pressed" : "released",
            action == GLFW_PRESS ? "pressed" : "released"
        );
    }
    button_state->ended_down = is_key_down;
    if (action == GLFW_REPEAT) {
        window->received_button_input = true;
        ++button_state->n_of_repeats;
    }
}

bool glfw__init() {
    glfwSetErrorCallback(&glfw__error_callback);

    debug__write("version string: %s", glfwGetVersionString());
    debug__write("compiled version: %d.%d.%d", GLFW_VERSION_MAJOR, GLFW_VERSION_MINOR, GLFW_VERSION_REVISION);

    int major = 0;
    int minor = 0;
    int rev   = 0;
    glfwGetVersion(&major, &minor, &rev);
    debug__write("runtime version: %d.%d.%d", major, minor, rev);

    // glfwInitHint();
    if (glfwInit() == GLFW_FALSE) {
        return false;
    }

    glfwSetMonitorCallback(&glfw__monitor_callback);

    uint32_t number_of_monitors;
    monitor_t* monitors = monitor__get_monitors(&number_of_monitors);
    debug__write("number of connected monitors: %u", number_of_monitors);
    // todo: turn this into column-based format
    for (uint32_t monitor_index = 0; monitor_index < number_of_monitors; ++monitor_index) {
        monitor_t monitor = monitors[monitor_index];
        int32_t width_mm;
        int32_t height_mm;
        glfwGetMonitorPhysicalSize(monitor, &width_mm, &height_mm);
        debug__write("  %u: %s - physical size: %ux%u [mm]", monitor_index, glfwGetMonitorName(monitor), width_mm, height_mm);
    }

    debug__flush(DEBUG_MODULE_GLFW, DEBUG_INFO);

    return true;
}

void glfw__destroy() {
    glfwTerminate();
}

void glfw__poll_events() {
    glfwPollEvents();
}

void glfw__wait_events() {
    glfwWaitEvents();
}

monitor_t* monitor__get_monitors(uint32_t* number_of_monitors) {
    return (monitor_t*) glfwGetMonitors((int32_t*) number_of_monitors);
}

void monitor__get_screen_size(monitor_t self, uint32_t* w, uint32_t* h) {
    const GLFWvidmode* mode = glfwGetVideoMode(self);
    *w = mode->width;
    *h = mode->height;
}

void monitor__get_work_area(monitor_t self, int32_t* x, int32_t* y, uint32_t* w, uint32_t* h) {
    glfwGetMonitorWorkarea(self, x, y, (int32_t*) w, (int32_t*) h);
}

const char* button__to_str(button_t button) {
    switch (button) {
    case BUTTON_0: return "0"; case BUTTON_1: return "1"; case BUTTON_2: return "2"; case BUTTON_3: return "3"; case BUTTON_4: return "4"; case BUTTON_5: return "5"; case BUTTON_6: return "6"; case BUTTON_7: return "7"; case BUTTON_8: return "8"; case BUTTON_9: return "9";
    case BUTTON_A: return "A"; case BUTTON_B: return "B"; case BUTTON_C: return "C"; case BUTTON_D: return "D"; case BUTTON_E: return "E"; case BUTTON_F: return "F"; case BUTTON_G: return "G"; case BUTTON_H: return "H"; case BUTTON_I: return "I"; case BUTTON_J: return "J"; case BUTTON_K: return "K"; case BUTTON_L: return "L"; case BUTTON_M: return "M";
    case BUTTON_N: return "N"; case BUTTON_O: return "O"; case BUTTON_P: return "P"; case BUTTON_Q: return "Q"; case BUTTON_R: return "R"; case BUTTON_S: return "S"; case BUTTON_T: return "T"; case BUTTON_U: return "U"; case BUTTON_V: return "V"; case BUTTON_W: return "W"; case BUTTON_X: return "X"; case BUTTON_Y: return "Y"; case BUTTON_Z: return "Z";
    case BUTTON_LEFT: return "LEFT"; case BUTTON_UP: return "UP"; case BUTTON_RIGHT: return "RIGHT"; case BUTTON_DOWN: return "DOWN";
    case BUTTON_CAPS_LOCK: return "CAPS_LOCK"; case BUTTON_SHIFT: return "SHIFT";
    case BUTTON_WINDOW_CLOSE: return "WINDOW_CLOSE";
    case BUTTON_WINDOW_MINIMIZE: return "WINDOW_MINIMIZE";
    case BUTTON_WINDOW_MAXIMIZE: return "WINDOW_MAXIMIZE";
    case BUTTON_WINDOW_WINDOWED: return "WINDOW_WINDOWED";
    case BUTTON_WINDOW_FULL_SCREEN: return "WINDOW_FULL_SCREEN";
    default: ASSERT(false);
    }
    return 0;
}

static void char_callback(GLFWwindow* window, uint32_t utf32) {
    (void) window;
    (void) utf32;

    // printf("%c", utf32);
    // fflush(stdout);
}

static void window__add_default_button_actions(window_t window) {
    window->buttons[BUTTON_WINDOW_CLOSE].action_on_key_down_fn = &window__button_default_action_window_close;
    window->buttons[BUTTON_WINDOW_MINIMIZE].action_on_key_down_fn = &window__button_default_action_window_minimize;
    window->buttons[BUTTON_WINDOW_MAXIMIZE].action_on_key_down_fn = &window__button_default_action_window_maximize;
    window->buttons[BUTTON_WINDOW_WINDOWED].action_on_key_down_fn = &window__button_default_action_window_windowed;
    window->buttons[BUTTON_WINDOW_FULL_SCREEN].action_on_key_down_fn = &window__button_default_action_window_full_screen;
}

window_t window__create(monitor_t monitor, const char* title, uint32_t width, uint32_t height) {
    window_t result = calloc(1, sizeof(*result));

    // for faster window creation and application switching, choose the closest video mode available (relative to monitor)
    const GLFWvidmode* mode = glfwGetVideoMode(monitor);
    glfwWindowHint(GLFW_RED_BITS, mode->redBits);
    glfwWindowHint(GLFW_GREEN_BITS, mode->greenBits);
    glfwWindowHint(GLFW_BLUE_BITS, mode->blueBits);
    glfwWindowHint(GLFW_REFRESH_RATE, mode->refreshRate);
    glfwWindowHint(GLFW_DECORATED, GLFW_TRUE);
    glfwWindowHint(GLFW_DOUBLEBUFFER, GLFW_TRUE);
    glfwWindowHint(GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE);
    glfwWindowHint(GLFW_AUTO_ICONIFY, GLFW_FALSE);
    result->glfw_window = glfwCreateWindow(width, height, title, NULL, NULL);
    result->title = title;
    result->monitor = monitor;

    window__set_hidden(result, true);
    {
        window__add_default_button_actions(result);

        glfwSetWindowUserPointer(result->glfw_window, result);
        glfwSetWindowPosCallback(result->glfw_window, &window__pos_changed_callback);
        glfwSetWindowSizeCallback(result->glfw_window, &window__size_changed_callback);
        glfwSetWindowCloseCallback(result->glfw_window, &window__should_close_callback);
        glfwSetFramebufferSizeCallback(result->glfw_window, &wiondow__framebuffer_resize_callback);
        glfwSetWindowContentScaleCallback(result->glfw_window, &window__content_scale_callback);
        glfwSetWindowIconifyCallback(result->glfw_window, &window__minimized_callback);
        glfwSetWindowMaximizeCallback(result->glfw_window, &window__maximized_callback);
        glfwSetWindowFocusCallback(result->glfw_window, &window__focus_callback);

        glfwSetKeyCallback(result->glfw_window, &window__key_callback);
        glfwSetCharCallback(result->glfw_window, &char_callback);

        window__get_content_area_size(result, &result->w, &result->h);
        window__get_content_area_pos(result, &result->x, &result->y);
    }
    window__set_hidden(result, false);

    return result;
}

void window__destroy(window_t self) {
    glfwDestroyWindow(self->glfw_window);
}

void window__set_default_button_actions(window_t self, bool value) {
    if (value) {
        window__add_default_button_actions(self);
    }
    ASSERT(false && "todo: implement");
}

void window__set_monitor(window_t self, monitor_t monitor) {
    self->monitor = monitor;
}

void window__set_title(window_t self, const char* title) {
    self->title = title;
    glfwSetWindowTitle(self->glfw_window, self->title);
}

const char* window__get_title(window_t self) {
    return self->title;
}

void window__set_current_window(window_t self) {
    glfwMakeContextCurrent(self->glfw_window);
    glfwSwapInterval(1);
}

window_t window__get_current_window() {
    GLFWwindow* glfw_window = glfwGetCurrentContext();
    return window__from_glfw_window(glfw_window);
}

void window__swap_buffers(window_t self) {
    glfwSwapBuffers(self->glfw_window);
}

void window__set_icon(window_t self, uint8_t* pixels, uint32_t w, uint32_t h) {
    GLFWimage image = {
        .pixels = pixels,
        .width = w,
        .height = h
    };
    glfwSetWindowIcon(self->glfw_window, 1, &image);
}

void window__set_content_area_size(window_t self, uint32_t width, uint32_t height) {
    glfwSetWindowSize(self->glfw_window, width, height);
}

void window__get_content_area_size(window_t self, uint32_t* width, uint32_t* height) {
    glfwGetWindowSize(self->glfw_window, (int32_t*) width, (int32_t*) height);
}

void window__get_window_size(window_t self, uint32_t* width, uint32_t* height) {
    window__get_content_area_size(self, width, height);
    int32_t left, top, right, bottom;
    window__get_window_frame_size(self, &left, &top, &right, &bottom);
    *width += left + right;
    *height += top + bottom;
}

void window__get_window_frame_size(window_t self, int32_t* left, int32_t* top, int32_t* right, int32_t* bottom) {
    glfwGetWindowFrameSize(self->glfw_window, left, top, right, bottom);
}

void window__set_content_area_pos(window_t self, int32_t x, int32_t y) {
    glfwSetWindowPos(self->glfw_window, x, y);
}

void window__get_content_area_pos(window_t self, int32_t* x, int32_t* y) {
    glfwGetWindowPos(self->glfw_window, x, y);
}

void window__set_window_pos(window_t self, int32_t x, int32_t y) {
    int32_t left, top, right, bottom;
    window__get_window_frame_size(self, &left, &top, &right, &bottom);
    window__set_content_area_pos(self, x + left, y + top);
}

void window__get_window_pos(window_t self, int32_t* x, int32_t* y) {
    int32_t left, top, right, bottom;
    window__get_window_frame_size(self, &left, &top, &right, &bottom);
    window__get_content_area_pos(self, x, y);
    *x -= left;
    *y -= top;
}

void window__set_state(window_t self, window_state_t state) {
    const bool was_hidden = window__get_hidden(self);
    if (!was_hidden) {
        window__set_hidden(self, true);
    }

    switch (state) {
    case WINDOW_STATE_MINIMIZED: {
        glfwIconifyWindow(self->glfw_window);
    } break ;
    case WINDOW_STATE_MAXIMIZED: {
        glfwMaximizeWindow(self->glfw_window);
    } break ;
    case WINDOW_STATE_WINDOWED: {
        window_state_t current_state = window__get_state(self);
        if (
            current_state == WINDOW_STATE_MINIMIZED ||
            current_state == WINDOW_STATE_MAXIMIZED
        ) {
            glfwRestoreWindow(self->glfw_window);
        }

        glfwSetWindowMonitor(
            self->glfw_window,
            NULL,
            self->x, self->y,
            self->w, self->h,
            GLFW_DONT_CARE
        );
    } break ;
    case WINDOW_STATE_FULL_SCREEN: {
        window_state_t current_state = window__get_state(self);
        if (
            current_state == WINDOW_STATE_MINIMIZED ||
            current_state == WINDOW_STATE_MAXIMIZED
        ) {
            glfwRestoreWindow(self->glfw_window);
        }

        const GLFWvidmode* mode = glfwGetVideoMode(self->monitor);
        glfwSetWindowMonitor(
            self->glfw_window,
            self->monitor,
            0, 0,
            mode->width, mode->height,
            mode->refreshRate
        );
    } break ;
    default: ASSERT(false);
    }

    if (!was_hidden) {
        window__set_hidden(self, false);
    }
}

window_state_t window__get_state(window_t self) {
    if (glfwGetWindowAttrib(self->glfw_window, GLFW_ICONIFIED)) {
        return WINDOW_STATE_MINIMIZED;
    }
    if (glfwGetWindowAttrib(self->glfw_window, GLFW_MAXIMIZED)) {
        return WINDOW_STATE_MAXIMIZED;
    }
    if (glfwGetWindowMonitor(self->glfw_window)) {
        return WINDOW_STATE_FULL_SCREEN;
    }

    return WINDOW_STATE_WINDOWED;

    // what about hidden state?
}

void window__set_hidden(window_t self, bool value) {
    if (value) {
        glfwHideWindow(self->glfw_window);
    } else {
        glfwShowWindow(self->glfw_window);
    }
}

bool window__get_hidden(window_t self) {
    return glfwGetWindowAttrib(self->glfw_window, GLFW_VISIBLE);
}

void window__set_focus(window_t self) {
    glfwFocusWindow(self->glfw_window);
}

bool window__get_focus(window_t self) {
    return glfwGetWindowAttrib(self->glfw_window, GLFW_FOCUSED);
}

void window__set_should_close(window_t self, bool value) {
    glfwSetWindowShouldClose(self->glfw_window, value);
}

bool window__get_should_close(window_t self) {
    return glfwWindowShouldClose(self->glfw_window);
}

void window__request_attention(window_t self) {
    glfwRequestWindowAttention(self->glfw_window);
}

void window__set_window_opacity(window_t self, float opacity) {
    ASSERT(opacity >= 0.0f && opacity <= 1.0f);

    glfwSetWindowOpacity(self->glfw_window, opacity);
}

float window__get_window_opacity(window_t self) {
    return glfwGetWindowOpacity(self->glfw_window);
}

void window__set_size_limit(
    window_t self,
    uint32_t min_width, uint32_t min_height,
    uint32_t max_width, uint32_t max_height
) {
    glfwSetWindowSizeLimits(
        self->glfw_window,
        min_width == 0 ? GLFW_DONT_CARE : (int32_t) min_width, min_height == 0 ? GLFW_DONT_CARE : (int32_t) min_height,
        max_width == 0 ? GLFW_DONT_CARE : (int32_t) max_width, max_height == 0 ? GLFW_DONT_CARE : (int32_t) max_height
    );
}

void window__set_aspect_ratio(window_t self, uint32_t num, uint32_t den) {
    if (num == 0 || den == 0) {
        num = GLFW_DONT_CARE;
        den = GLFW_DONT_CARE;
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window aspect disabled");
    } else {
        debug__write_and_flush(DEBUG_MODULE_GLFW, DEBUG_INFO, "window aspect ratio changed to: %u %u", num, den);
    }
    glfwSetWindowAspectRatio(self->glfw_window, num, den);
}

void window__clear_button_state(window_t self) {
    for (uint32_t button_index = 0; button_index < sizeof(self->buttons) / sizeof(self->buttons[0]); ++button_index) {
        self->buttons[button_index].n_of_repeats     = 0;
        self->buttons[button_index].n_of_transitions = 0;
    }
    self->received_button_input = false;
}

bool window__received_button_input(window_t self) {
    return self->received_button_input;
}

bool window__button_is_down(window_t self, button_t button) {
    ASSERT(button < _BUTTON_SIZE);
    return self->buttons[button].ended_down;
}

uint32_t window__button_n_of_repeats(window_t self, button_t button) {
    ASSERT(button < _BUTTON_SIZE);
    return self->buttons[button].n_of_repeats;
}

uint32_t window__button_n_of_transitions(window_t self, button_t button) {
    ASSERT(button < _BUTTON_SIZE);
    return self->buttons[button].n_of_transitions;
}
