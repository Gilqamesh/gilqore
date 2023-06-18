#include "test_framework/test_framework.h"

#include "io/file/file_writer/file_writer.h"

#include "io/file/file.h"
#include "libc/libc.h"

int main() {
    struct file_writer writer;
    struct file file;

    const char* filename = "123fdsauji_dsa9324j";
    if (file__exists(filename)) {
        TEST_FRAMEWORK_ASSERT(file__delete(filename));
    }
    TEST_FRAMEWORK_ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE));

    u32 file_writer_buffer_size = KILOBYTES(1);
    void* file_writer_buffer = libc__malloc(file_writer_buffer_size);
    TEST_FRAMEWORK_ASSERT(
        file_writer__create(
            &writer,
            memory_slice__create(file_writer_buffer, file_writer_buffer_size)
        )
    );

    const char* module_name = "window";
    u32 u = 64328234;
    s32 s = -1234544;
    r32 f = 34543.343234f;
    r64 lf = 324483279085764.342034272934823046082347;
    file_writer__write_format(
        &writer,
        &file,
        "#include \"def.h\""
        "\n"
        "enum %s_error_code {\n"
        "    %s_start\n"
        "};\n"
        "\n"
        "PUBLIC_API void fn();\n"
        "%u\n"
        "%d\n"
        "%f\n"
        "%lf\n",
        module_name,
        module_name,
        u,
        s,
        f,
        lf
    );

    file_writer__destroy(&writer);
    file__close(&file);
}
