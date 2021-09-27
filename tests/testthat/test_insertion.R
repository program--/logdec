testthat::test_that(
    "`%<<%` outputs with `base` engine", {
        local_test_insertion("base")
    }
)

testthat::test_that(
    "`%<<%` outputs with `cli` engine", {
        local_test_insertion("cli")
    }
)

testthat::test_that(
    "`%<<%` outputs with `logger` engine", {
        local_test_insertion("logger")
    }
)