library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Number Multiplier"),
  sidebarLayout(
    sidebarPanel(
      numericInput("number_input", "Enter a number (between 1 and 50):", value = 1, min = 1, max = 50),
      actionButton("calculate_button", "Calculate")
    ),
    mainPanel(
      verbatimTextOutput("result_output")
    )
  )
)

# Define the server
server <- function(input, output) {
  observeEvent(input$calculate_button, {
    x <- input$number_input
    result <- x * 5
    output$result_output <- renderPrint({
      cat("The result of", x, "multiplied by 5 is", result)
    })
  })
}

# Run the app
shinyApp(ui, server)
