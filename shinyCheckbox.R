library(shiny)

ui <- fluidPage(
  checkboxInput("chk",
                label = h3("선택"),
                value = 
                 ),
  hr(),
  fluidRow(column(3,verbatimTextOutput("value")))
)

server <- function(input, output, session) {
  output$value <- renderText({input$chk})
}

shinyApp(ui, server)
