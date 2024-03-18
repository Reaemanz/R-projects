library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Date Slider App"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date_range", "Select Date Range:",
                     start = Sys.Date() - 30, end = Sys.Date() + 30),
      actionButton("show_dates_button", "Show Selected Dates")
    ),
    mainPanel(
      verbatimTextOutput("selected_dates_output")
    )
  )
)

# Define the server
server <- function(input, output) {
  observeEvent(input$show_dates_button, {
    selected_start_date <- input$date_range[1]
    selected_end_date <- input$date_range[2]
    output$selected_dates_output <- renderPrint({
      cat("Selected date range:\n")
      cat("Start date:", selected_start_date, "\n")
      cat("End date:", selected_end_date)
    })
  })
}

# Run the app
shinyApp(ui, server)
