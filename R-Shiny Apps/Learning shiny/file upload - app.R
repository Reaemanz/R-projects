library(shiny)

ui <- fluidPage(
  fileInput("upload", NULL)
)


server <- function(input, output, session
){}

shinyApp(ui, server)
