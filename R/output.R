#' @title Use logdec
#' @examples
#' \dontrun{
#' # To start using logdec:
#' logdec::output()
#' # Make sure to call this function in the `::` syntax,
#' # otherwise it might not work!
#'
#' # Then, add special comments, like so:
#' #>> This is a simple logdec message
#' #>> @info This is a informational logdec message
#' #>> @success This is a successful logdec message!
#' #>> @warning beware! this is a warning
#' #>> @danger The path ahead is DANGEROUS! :)
#'
#' # logdec has `glue` support as well,
#' my_name <- "Justin"
#' #>> Hello, {my_name}!
#'
#' # logdec has support for various "engines", which
#' # provide the functionality for your output. By
#' # default, logdec will use `base` commands, but
#' # you can use `cli` or `logger` functions as well!
#' options(logdec.engine = "cli")
#' #>> @info This is a {.fn cli::cli_alert_info} message
#' }
#'
#' @details
#' ## `logdec::output` limitations
#' `logdec::output` can only be called from a standalone
#' R file. This is because, *currently*, logdec recreates your
#' R file in your temporary directory with the logdec comments replaced
#' by the corresponding function calls (i.e. `cat`, `cli_alert`, etc.).
#'
#' This means that console/interactive/package use is not possible.
#' To mitigate this, logdec offers an extraction operator (`%>>%`) that
#' will work both interactively and in package development.
#' However, see the `details` on the extraction operator's page,
#' as it is essentially a wrapper for other package functions.
#'
#' @seealso `%>>%`
#'
#' @importFrom whereami thisfile
#' @export
output <- function() {
    engine  <- .check_engine()
    csf     <- .check_csf()
    code    <- gsub("logdec::output\\(\\)", "", readLines(csf, warn = FALSE))
    ld_tags <- grepl("#>>", code)
    blocks  <- vapply(
        code[ld_tags],
        parse_tag,
        FUN.VALUE = c(val = character(1)),
        engine    = engine,
        USE.NAMES = FALSE
    )

    code[ld_tags] <- blocks
    exec_script   <- tempfile(pattern = "LOGDEC", fileext = ".R")

    writeLines(code, exec_script)
    tryCatch(source(exec_script), finally = unlink(exec_script))

    invokeRestart("abort")
}