#' @title Parse logdec comment tag
#' @param block A logdec comment tag as a `character`
#' @param engine The logdec engine to use, passed to `get_engine_fn`.
#' @return An unparsed string for an engine-specific function
#' @seealso `get_engine_fn`
#' @keywords internal
parse_tag <- function(block, engine) {
    opts   <- c("danger", "warning", "success", "info")
    suffix <- opts[sapply(paste0("@", opts), grepl, x = block)]
    suffix <- if (identical(suffix, character(0))) "" else paste0("_", suffix)
    out    <- trimws(gsub("(#>>)|(@(\\w+))", "", block))
    if (length(suffix) > 1) suffix <- suffix[1]
    get_engine_fn(engine, suffix, out)
}


#' @title Get engine-specific function string
#' @param engine logdec engine to use, i.e. `cli`
#' @param suffix Suffix of engine function, or an empty character
#' @param out The user-inputted output
#' @return An unparsed string for an engine-specific function
#' @seealso `parse_tag`
#' @keywords internal
get_engine_fn <- function(engine, suffix, out) {
    if (engine == "cli") {
        paste0("cli::cli_alert", suffix, "(\"", out, "\")")
    } else if (engine == "logger") {
        suffix <- switch(
            suffix,
            "_danger"  = "_error",
            "_warning" = "_warn",
            "_success" = "_success",
            "_info"
        )

        paste0("logger::log", suffix, "(\"", out, "\")")
    } else {
        if (!identical(suffix, "")) {
            suffix <- toupper(substr(suffix, 2, nchar(suffix)))
            paste0("cat(glue::glue(\"",
                   suffix, ": ",
                   out, "\"), file = stderr(), sep = \"\\n\")")
        } else {
            paste0(
                "cat(glue::glue(\"",
                out,
                "\"), file = stderr(), sep = \"\\n\")"
            )
        }
    }
}