## set options
options(
  repos = c(CLOUD = "http://cloud.r-project.org/"),
  max.print = 100,
  scipen = 4L,
  width = 80L,
  encoding = "UTF-8",
  nwarnings = 10L,
  useFancyQuotes = FALSE,
  stringsAsFactors = FALSE
)

## fix LC_MESSAGES issue
invisible(Sys.setlocale("LC_MESSAGES", "C"))

## override quit function so save defaults to "no"
quit <- function(save = "no", status = 0, runLast = TRUE) {
  .Internal(quit(save, status, runLast))
}

## override quit
unlockBinding("quit", .BaseNamespaceEnv)
assign("quit", quit, envir = baseenv())
lockBinding("quit", .BaseNamespaceEnv)

## override q
unlockBinding("q", .BaseNamespaceEnv)
assign("q", quit, envir = baseenv())
lockBinding("q", .BaseNamespaceEnv)

## clear
rm(quit)

## on start
.First <- function() {
  if (requireNamespace("tfse", quietly = TRUE)) {
    tfse::lib(tfse)
  }
}

## on exit
.Last <- function()  {
  message("\n")
}
