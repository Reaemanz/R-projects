library(shiny)

ui <- fluidPage( 
  waiter::use_waiter(), 
  actionButton("go", "go"), 
  plotOutput("plot"),
) 

server <- function(input, output, session) { 
  data <- eventReactive(input$go, { 
    waiter::Waiter$new(id = "plot")$show() 
    Sys.sleep(1) 
    data.frame(x = runif(50), y = runif(50)) 
  }) 
  output$plot <- renderPlot(plot(data()), res = 96)
}

shinyApp(ui, server)