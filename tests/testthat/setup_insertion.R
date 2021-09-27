# nolint start
local_test_insertion <- function(engine) {
    skip_if(!requireNamespace(engine, quietly = TRUE))
    original_engine <- getOption("logdec.engine")
    options(logdec.engine = engine)

    testthat::expect_snapshot_output(logdec::`%>>%`("x"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@info x"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@success x"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@warning x"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@danger x"))
    testthat::expect_snapshot_output(logdec::`%>>%`("{rnorm('1')}"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@info {rnorm('1')}"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@success {rnorm('1')}"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@warning {rnorm('1')}"))
    testthat::expect_snapshot_output(logdec::`%>>%`("@danger {rnorm('1')}"))
    testthat::expect_snapshot_output("" %>>% "x")
    testthat::expect_snapshot_output("@info" %>>% "x")
    testthat::expect_snapshot_output("@success" %>>% "x")
    testthat::expect_snapshot_output("@warning" %>>% "x")
    testthat::expect_snapshot_output("@danger" %>>% "x")
    testthat::expect_snapshot_output("" %>>% "{rnorm('1')}")
    testthat::expect_snapshot_output("@info" %>>% "{rnorm('1')}")
    testthat::expect_snapshot_output("@success" %>>% "{rnorm('1')}")
    testthat::expect_snapshot_output("@warning" %>>% "{rnorm('1')}")
    testthat::expect_snapshot_output("@danger" %>>% "{rnorm('1')}")

    options(logdec.engine = original_engine)
}
# nolint end