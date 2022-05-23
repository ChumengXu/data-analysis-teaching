library(testthat)

# run tests for a single file
test_file("./course_examples/unit_testing/test_that_example.R", reporter = default_reporter())

# different output for tests (this may be helpful for specific types of CI servers like Jenkins)
test_file("./course_examples/unit_testing/test_that_example.R", reporter = JunitReporter)