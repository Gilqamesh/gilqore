#ifndef ISPC
# error "This file must be compiled with the ispc compiler"
#endif

export void ispc__get_version(uniform int * uniform major, uniform int * uniform minor) {
    *major = ISPC_MAJOR_VERSION;
    *minor = ISPC_MINOR_VERSION;
}
