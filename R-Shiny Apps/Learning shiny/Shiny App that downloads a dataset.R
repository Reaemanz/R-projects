library(shiny)

ui <- fluidPage(
  # Choose dataset from a dropdown
  selectInput("dataset", "Choose a dataset:", choices = c("rock", "pressure", "cars")),
  
  # Button to trigger download
  downloadButton("downloadData", "Download")
)

server <- function(input, output) {
  # Reactive value for selected dataset
  datasetInput <- reactive({
    switch(
      input$dataset,
      "rock" = rock,
      "pressure" = pressure,
      "cars" = cars
    )
  })
  
  # Display the selected dataset in a table
  output$table <- renderTable({
    datasetInput()
  })
  
  # Define the download action
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui, server)
