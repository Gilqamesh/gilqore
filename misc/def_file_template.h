#ifndef ${module_defs_h}
# define ${module_defs_h}

# include ${parent_module_name_defs}

enum ${module_error_codes}_error_code {
    ${module_error_code_start}_ERROR_CODE_START,
${rest_of_the_error_codes}
};

#endif
