// choose Automatic or custom
//
// and link against:
// ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}

// ## Automatic main


#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MAIN
#define BOOST_TEST_MODULE myname

#include <boost/test/unit_test.hpp>


// ## Custom Initialization

/*

#include <boost/test/included/unit_test.hpp>

#include "foo.hh"
#include "bar.hh"

// test-suites are combined with other automatically generated ones
boost::unit_test::test_suite *init_unit_test_suite(int argc, char **argv)
{
  boost::unit_test::framework::master_test_suite().add(create_foo_suite());
  boost::unit_test::framework::master_test_suite().add(create_bar_suite());
  return nullptr;
}

// and in another translation unit:

boost::unit_test::test_suite *create_foo_suite()
{
  auto mysuite = BOOST_TEST_SUITE("mysuite");

  auto mysubsuite = BOOST_TEST_SUITE("mysubsuite");
  mysubsuite->add(BOOST_PARAM_TEST_CASE(&test_case_fn,
        filenames.begin(), filenames.end()));

  mysuite->add(mysubsuite);
  return mysuite;
}


*/
