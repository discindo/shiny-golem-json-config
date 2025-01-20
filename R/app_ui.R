#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  config <- jsonlite::read_json("inst/app-config.json")
  pages <- purrr::map(
    config$pages, function(x) {
      if (!is.null(x$template)) {
        return(bslib::nav_panel(
          title = x$title,
          shiny::htmlTemplate(x$template)
        ))
      } else if (!is.null(x$ui)) {
        return(bslib::nav_panel(
          title = x$title,
          getFunction(x$ui)(id = "data_1")
        ))
      } else {
        return(bslib::nav_panel(
          title = x$title,
          x$title
        ))
      }
    }
  )
  shiny::tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    shiny::div(
      class = "container",
      bslib::page_navbar(
        theme = bslib::bs_theme(
          bootswatch = "litera",
          base_font = bslib::font_google("Lato")
        ),
        inverse = FALSE,
        underline = FALSE,
        title = shiny::a(
          href = config$meta$homepage,
          target = "_blank",
          shiny::img(src = config$meta$logo, height = "70px")
        ),
        header = shiny::div(
          class = "p-5 text-center",
          shiny::h4(config$general$title),
          shiny::h6(config$general$subtitle)
        ),
        bslib::nav_spacer(),
        rlang::splice(unname(pages))
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "golem.config"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
