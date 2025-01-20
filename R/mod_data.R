#' data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_data_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h4("This is a module."),
    tableOutput(ns("data"))
  )
}

#' data Server Functions
#'
#' @noRd
mod_data_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$data <- renderTable({
      head(data)
    })
  })
}

## To be copied in the UI
# mod_data_ui("data_1")

## To be copied in the server
# mod_data_server("data_1")
