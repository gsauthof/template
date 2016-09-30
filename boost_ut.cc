// nowadays, the C++ catch library is a good (or even better) alternative:
//
// - a generic CHECK() macro that is able to deal with most unary/binary
//   expressions
// - tags instead of a hierarchy (hierarchy is tedious to restructure, may
//   grow somewhat overcomplicated)
// - good compile speed
// - ...
//
// cf. https://github.com/philsquared/Catch

#include <boost/test/unit_test.hpp>

#include <own/foo.hh>

using namespace std;

// suites are merged, can also be shared with other translation units
BOOST_AUTO_TEST_SUITE(XXX_global_name)

  BOOST_AUTO_TEST_SUITE(XXXsection)

    BOOST_AUTO_TEST_SUITE(XXXsubsection)

      BOOST_AUTO_TEST_CASE(basic)
      {
        //BOOST_CHECK_EQUAL()
        //BOOST_CHECK_GT() // GE, LE, LT, NE ...
        //BOOST_CHECK_BITWISE_EQUAL()
        //BOOST_CHECK()
        //...
        //BOOST_REQUIRE_EQUAL()
        //BOOST_REQUIRE()
        //BOOST_CHECK_THROW() // NO_THROW
        //BOOST_CHECK_EQUAL_COLLECTION() // COLLECTIONS() is the old name?
        //...
      }

    BOOST_AUTO_TEST_SUITE_END()

  BOOST_AUTO_TEST_SUITE_END()

BOOST_AUTO_TEST_SUITE_END()
