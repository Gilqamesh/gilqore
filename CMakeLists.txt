#---------------------------------------------------------------------------------------------------
# gilqore
enf_file_glob_recurse(gilqore_SOURCES_C   "gilqore/modules/*.c")
enf_file_glob_recurse(gilqore_HEADERS
	"gilqore/modules/*.h"
)
add_library(gilqore
	${gilqore_SOURCES_C}
	${gilqore_HEADERS}
)