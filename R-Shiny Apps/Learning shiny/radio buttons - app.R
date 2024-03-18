library(shiny)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate
animals")

ui <- fluidPage(
  checkboxGroupInput("animal", "What animals do you like?",
                     animals)
)

server <- function(input, output, session
){}

shinyApp(ui, server)
