## This script launches the shinysse Shiny web app
## and is compatible with rsconnect::deployApp()
library(shinysse)
## make resources available globally from non standard location
addResourcePath("www", system.file("www", package = "shinysse"))
shinyApp(ui = app_ui, server = app_server)
