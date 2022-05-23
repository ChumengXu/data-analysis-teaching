context('testing data integrity')

test_that('data columns and rows are correct', {
  expect_equal(ncol(mtcars), 12)
  expect_equal(nrow(mtcars), 32)
})
