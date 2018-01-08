# for sourcing from a shell
#
# those variables are picked up by build systems like cmake

# cf. makefile
CFLAGS="-Wall -Wextra -Wno-missing-field-initializers \
    -Wno-parentheses -Wno-missing-braces \
    -Wmissing-prototypes -Wfloat-equal \
    -Wwrite-strings -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Werror=multichar -Werror=sizeof-pointer-memaccess -Werror=return-type \
    -fstrict-aliasing"
export CFLAGS

CXXFLAGS="-Wall -Wextra \
    -Wno-unused-local-typedefs \
    -Wno-parentheses -Wno-missing-braces \
    -Wfloat-equal \
    -Wpointer-arith -Wcast-align \
    -Wnull-dereference \
    -Wnon-virtual-dtor \
    -Werror=multichar -Werror=sizeof-pointer-memaccess -Werror=return-type \
    -Wmissing-declarations \
    -fstrict-aliasing"
export CXXFLAGS
