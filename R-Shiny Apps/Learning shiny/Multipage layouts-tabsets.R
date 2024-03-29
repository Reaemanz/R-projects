library(shiny)

ui <- fluidPage( 
  tabsetPanel( 
    tabPanel("Import data", 
             fileInput("file", "Data", buttonLabel = "Upload..."), 
             textInput("delim", "Delimiter (leave blank to guess)", ""), 
             numericInput("skip", "Rows to skip", 0, min = 0), 
             numericInput("rows", "Rows to preview", 10, min = 1) 
    ), 
    tabPanel("Set parameters"), 
    tabPanel("Visualise results") 
  )
)

shinyApp(ui, server)