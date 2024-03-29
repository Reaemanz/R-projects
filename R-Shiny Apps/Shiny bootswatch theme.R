library(shiny)

ui <- fluidPage( 
  theme = bslib::bs_theme(bootswatch = "darkly"), 
  sidebarLayout( 
    sidebarPanel( 
      textInput("txt", "Text input:", "text here"), 
      sliderInput("slider", "Slider input:", 1, 100, 30) 
    ), 
    mainPanel( 
      h1(paste0("Theme: darkly")), 
      h2("Header 2"), 
      p("Some text") 
    ) 
  )
)

shinyApp(ui, server)