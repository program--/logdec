# nolint start
#' @importFrom glue glue
#' @keywords internal
.check_engine <- function() {
    engine <- getOption("logdec.engine", default = "base")

    if (!engine %in% list_engines()) {
        engines <- paste0("`", list_engines(), "`", collapse = ", ")

        .stop_glue("The engine `{engine}` is not supported.\n",
                   "Please use one of the following engines: {engines}")
    }

    if (engine != "base") {
        if (!requireNamespace(engine, quietly = TRUE)) {
            .stop_glue("This engine requires the `{engine}` package.")
        }
    }

    engine
}
# nolint end

#' @importFrom whereami thisfile
#' @keywords internal
.check_csf <- function() {
    csf <- whereami::thisfile()

    if (is.null(csf)) {
        .stop_glue("logdec::output() cannot be used in an interactive console.")
    }

    csf
}

#' @importFrom glue glue
#' @keywords internal
.stop_glue <- function(...) {
    stop(glue::glue(...), call. = FALSE)
}