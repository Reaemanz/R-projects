library(shiny)
library(brickr)
library(png)

# Function to provide user feedback
notify <- function(msg, id = NULL) {
  showNotification(msg, id = id, duration = NULL, closeButton = FALSE)
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        fileInput("myFile", "Upload a PNG file", accept = c('image/png')),
        sliderInput("size", "Select size:", min = 1, max = 100, value = 35),
        radioButtons("color", "Select color palette:", choices = c("universal", "generic"))
      )
    ),
    mainPanel(
      plotOutput("result")
    )
  )
)

server <- function(input, output) {
  imageFile <- reactive({
    if (!is.null(input$myFile))
      png::readPNG(input$myFile$datapath)
  })
  
  output$result <- renderPlot({
    req(imageFile())
    id <- notify("Transforming image...")
    on.exit(removeNotification(id), add = TRUE)
    imageFile() %>%
      image_to_mosaic(img_size = input$size, color_palette = input$color) %>%
      build_mosaic()
  })
}

shinyApp(ui, server)
