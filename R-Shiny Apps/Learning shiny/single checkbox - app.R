library(shiny)

ui <- fluidPage(
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?")
)

server <- function(input, output, session
){}

shinyApp(ui, server)
