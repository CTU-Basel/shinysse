#' Shinydashboard two-color custom mint header
#'
#' @param header_title string containing a header title
#' @return shiny.tag list with a custom header
#' @export
#'
get_header_mint <- function(header_title){
  header <- dashboardHeader(
    title = header_title,
    tags$li(class = "dropdown"))
  ## custom adapt by adding aditional components
  header$children[[4]] <- header$children[[2]]
  header$children[[4]]$children[[1]] <- header$children[[2]]
  header$children[[4]]$children[[2]] <- header$children[[2]]
  header$children[[4]]$children[[2]]$children[[1]] <- header$children[[2]]
  header$children[[4]]$name <- "div"
  header$children[[4]]$attribs$class <- "custom-head"
  ## first mint header row
  header$children[[4]]$children[[1]]$name <- "aside"
  header$children[[4]]$children[[1]]$attribs$class <- "uni"
  header$children[[4]]$children[[1]]$children <- NULL
  ## second mint header row
  header$children[[4]]$children[[2]]$name <- "aside"
  header$children[[4]]$children[[2]]$attribs$class <- "dep"
  header$children[[4]]$children[[2]]$children <- NULL
  return(header)
}
