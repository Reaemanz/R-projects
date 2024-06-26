library(shinycssloaders)
library(shiny)

ui <- fluidPage( 
  actionButton("go", "go"), 
  withSpinner(plotOutput("plot")),
)
server <- function(input, output, session) { 
  data <- eventReactive(input$go, { 
    Sys.sleep(3) 
    data.frame(x = runif(50), y = runif(50)) 
  }) 
  output$plot <- renderPlot(plot(data()), res = 96)
}

shinyApp(ui, server)