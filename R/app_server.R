#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  config <- jsonlite::read_json("inst/app-config.json")
  data <- read.csv(config$general$data_path)
  purrr::map(config$pages, function(x) {
    if (!is.null(x$server)) {
      getFunction(x$server)(id = "data_1", data = data)
    }
  })
}
