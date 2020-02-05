getSidebar <- function(){
  library(shinydashboard)
  side <- sidebarMenu(
    menuItem("Intro", tabName = mod$intro, icon = icon("dashboard")),
    menuItem("SSE Basic", tabName = mod$sse_basic, icon = icon("user-alt")),
    menuItem("SSE Plus", tabName = mod$sse_plus, icon = icon("user-plus"))
  )
  return(side)
}
