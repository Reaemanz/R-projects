library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Number Multiplier"),
  sidebarLayout(
    sidebarPanel(
      numericInput("number_input", "Enter a number (between 1 and 50):", value = 1, min = 1, max = 50),
      numericInput("multiplier_input", "Enter a multiplier (y):", value = 5, min = 1),  # New input for the multiplier
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
    y <- input$multiplier_input  # Retrieve the value of the multiplier
    result <- x * y
    output$result_output <- renderPrint({
      cat("The result of", x, "multiplied by", y, "is", result)
    })
  })
}

# Run the app
shinyApp(ui, server)
