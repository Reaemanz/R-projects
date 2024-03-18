library(shiny)

ui <- fluidPage(
  selectInput(
    "state", "What's your favourite state?", state.name,
    multiple = TRUE
  )
)

server <- function(input, output, session
){}

shinyApp(ui, server)
