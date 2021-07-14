test_that("worker_fct1 performs as expected", {
  out = worker_fct1(5)
  expect_true(is.data.frame(out))
  expect_equal(nrow(out), 1)
})

test_that("master_fct1 performs as expected", {
  out = master_fct1(5)
  expect_true(is.list(out))
  expect_equal(length(out), 5)
})

test_that("worker_fct2 performs as expected", {
  out = worker_fct2(5)
  expect_true(is.data.frame(out))
  expect_equal(nrow(out), 1)
})

test_that("master_fct2 performs as expected", {
  out = master_fct2(5)
  expect_true(is.list(out))
  expect_equal(length(out), 5)
})
