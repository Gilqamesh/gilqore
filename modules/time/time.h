#ifndef TIME_H
# define TIME_H

# include "time_defs.h"

struct time;

# if defined(WINDOWS)
#  include "platform_specific/windows/time_platform_specific_defs.h"
# elif defined(LINUX)
#  include "platform_specific/linux/time_platform_specific_defs.h"
# elif defined(MAC)
#  include "platform_specific/mac/time_platform_specific_defs.h"
# endif

// @returns current time with a granularity of at least 1s
PUBLIC_API struct time time__get(void);

// @returns <0, 0 or >0 if t1 is found, respectively, to be less than, equal to or be greater than t2
PUBLIC_API s64 time__cmp(struct time t1, struct time t2);

#endif
