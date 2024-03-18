library(shiny)
ui <- fluidPage(
  textInput("name", "Enter your name:"),
  verbatimTextOutput("greeting")
)

server <- function(input, output) {
  output$greeting <- renderText({
    if (input$name != "") {
      paste("Hello,", input$name, "!")
    } else {
      "Please enter your name."
    }
  })
}

shinyApp(ui, server)

