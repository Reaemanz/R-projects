library(shiny)
library(ggplot2)

ui <- fluidPage( 
  plotOutput("plot", click = "plot_click"), 
  tableOutput("data")
)
server <- function(input, output, session) { 
  output$plot <- renderPlot({ 
    plot(mtcars$wt, mtcars$mpg) 
  }, res = 96) 
  output$data <- renderTable({ 
    nearPoints(mtcars, input$plot_click, xvar = "wt", yvar = 
                 "mpg") 
  })
}

shinyApp(ui, server)