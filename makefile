
# good C language warning defaults for GCC
#
# The -Werror= options are already enabled as warnings - they are
# treated as errors to underscore their severity
#
# also useful:
#   -flto since it enables -Wlto-type-mismatch
#
CFLAGSW_GCC = -Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wmissing-prototypes -Wfloat-equal \
    -Wwrite-strings -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Werror=multichar -Werror=sizeof-pointer-memaccess \
    -fstrict-aliasing

# with C++, -Wwrite-strings is enabled by default
CXXFLAGSW_GCC = -Wall -Wextra \
    -Wno-unused-local-typedefs \
    -Wno-parentheses -Wno-missing-braces \
    -Wfloat-equal \
    -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Werror=multichar -Werror=sizeof-pointer-memaccess \
    -fstrict-aliasing


CFLAGS   += $(CFLAGSW_GCC)
CXXFLAGS += $(CXXFLAGSW_GCC)
