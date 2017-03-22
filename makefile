
# good C language warning defaults for GCC
CFLAGSW_GCC = -Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wmissing-prototypes -Wfloat-equal \
    -fstrict-aliasing

CXXFLAGSW_GCC = -Wall -Wextra \
    -Wno-unused-local-typedefs \
    -Wno-parentheses -Wno-missing-braces \
    -fstrict-aliasing

