# nolint start
#' @title Extraction/Output Operator
#' @description Extract a message to output
#' @details
#' This operator provides a programmatic use for logdec outside
#' the context of comments. However, it should be noted that this
#' operator is essentially a wrapper around the engine-specific
#' function call, i.e. cat(), cli::cli_alert_*(), etc.
#' @param lhs Either a message type identifier
#'            like "@info" or an entire message.
#' @param rhs Optional if operator is used with function syntax
#' @examples
#' # Conventional Use:
#' "@info" %>>% "Output some form of informational message"
#' "" %>>% "This will also work, but is a bit odd"
#'
#' # Functional Use:
#' `%>>%`("@success Successfully outputted this!")
#' `%>>%`("@success", "Outputted again!")
#'
#' # Additional Use:
#' options(logdec.engine = "cli")
#' "@info" %>>% "You can change the logdec engine with {.fn {options()}}"
#' "@info" %>>% "As seen above, you can also use {.pkg glue} syntax too!"
#'
#' some_value <- rnorm(1)
#' "@success" %>>% "Since you can use glue, you can pass variables {some_value}."
#'
#' @seealso `output`
#' @export
`%>>%` <- function(lhs, rhs) {
    out    <- if (missing(rhs)) lhs else paste(lhs, rhs)
    ld_tag <- parse_tag(out, engine = .check_engine())
    eval(parse(text = ld_tag))
}
# nolint end