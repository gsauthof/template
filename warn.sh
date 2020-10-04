# for sourcing from a shell
#
# those variables are picked up by build systems like cmake

# cf. makefile
CFLAGSW="-Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wmissing-prototypes -Wfloat-equal \
    -Wwrite-strings -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Werror=multichar -Werror=sizeof-pointer-memaccess -Werror=return-type \
    -fstrict-aliasing"
export CFLAGSW

CXXFLAGSW="-Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wno-unused-local-typedefs \
    -Wfloat-equal \
    -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Wnon-virtual-dtor -Wmissing-declarations \
    -Werror=multichar -Werror=sizeof-pointer-memaccess -Werror=return-type \
    -Werror=delete-non-virtual-dtor \
    -fstrict-aliasing"
export CXXFLAGSW
