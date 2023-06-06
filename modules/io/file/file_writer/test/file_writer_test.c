#include "io/file/file_writer/file_writer.h"

#include "io/file/file.h"

int main() {
    struct file_writer writer;
    struct file file;

    const char* filename = "123fdsauji_dsa9324j";
    if (file__exists(filename)) {
        ASSERT(file__delete(filename) == true);
    }
    ASSERT(file__open(&file, filename, FILE_ACCESS_MODE_WRITE, FILE_CREATION_MODE_CREATE) == true);
    ASSERT(file_writer__create(&writer) == true);

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
        "GIL_API void fn();\n"
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
