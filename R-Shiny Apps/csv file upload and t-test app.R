library(shiny)


# Define UI
ui <- fluidPage(
  titlePanel("CSV File Upload and t-Test"),
  fileInput("upload", "Upload a CSV file"),
  selectInput("variable", "Select a variable:", choices = NULL),
  verbatimTextOutput("ttest_result")
)

# Define server
server <- function(input, output, session) {
  
  # Read uploaded CSV file
  data <- reactive({
    req(input$upload)
    read.csv(input$upload$datapath)
  })
  
  # Update variable choices based on uploaded data
  observe({
    updateSelectInput(session, "variable", choices = names(data()))
  })
  
  # Perform t-test
  output$ttest_result <- renderPrint({
    req(input$variable)
    t_result <- t.test(data()[[input$variable]])
    t_result
  })
}

# Run the app
shinyApp(ui, server)
