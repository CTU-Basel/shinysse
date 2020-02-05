# define header
header_unibas <- function(header_label){
  header <- dashboardHeader(
    title = header_label,
    tags$li(class = "dropdown"))

  header$children[[4]] <- header$children[[2]]
  header$children[[4]]$children[[1]] <- header$children[[2]]
  header$children[[4]]$children[[2]] <- header$children[[2]]
  header$children[[4]]$children[[2]]$children[[1]] <- header$children[[2]]
  header$children[[4]]$name <- "div"
  header$children[[4]]$attribs$class <- "custom-head"
  # uni basel header row
  header$children[[4]]$children[[1]]$name <- "aside"
  header$children[[4]]$children[[1]]$attribs$class <- "unibas"
  header$children[[4]]$children[[1]]$children <- NULL
  # dkf/faculty header row
  header$children[[4]]$children[[2]]$name <- "aside"
  header$children[[4]]$children[[2]]$attribs$class <- "dkf"
  header$children[[4]]$children[[2]]$children <- NULL
  return(header)
}
