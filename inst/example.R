options(logdec.engine = "cli")
logdec::output()

#>> Hello from {.pkg logdec}!
Sys.sleep(3)
#>> @info {.strong logdec} allows you to create output messages {cli::col_blue(\"directly\")} from comments!
Sys.sleep(3)
#>> @info All you need to do is install {.strong logdec}, then call {.fn logdec::output} at the top of your R file.
Sys.sleep(3)
#>> @info You can even use glue to pass variables to your comments! Here's some random value from {.fn rnorm}: {.val {rnorm(1)}}
Sys.sleep(3)
#>> @warning However, there are {cli::col_yellow(\"some limitations\")}, such as with console and package development use.
Sys.sleep(3)
#>> @success There are ways to work around this though, such as with the {.code %>>%} operator though!
Sys.sleep(3)
#>> Make your code output a bit easier to manage, with {.pkg logdec}! {cli::col_red(cli::symbol$heart)}