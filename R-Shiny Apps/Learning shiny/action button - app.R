library(shiny)

ui <- fluidPage(
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail"))
)

server <- function(input, output, session
){}

shinyApp(ui, server)
