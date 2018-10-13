library(shiny)

library(shiny)

ui <- fluidPage(
  textInput("txt",
            label = h3("로그인"),
            value="ID 입력"
            ),
  hr(),
  fluidRow(column(3,verbatimTextOutput("value")))
)

server <- function(input, output, session) {
  output$value <- renderText({input$txt})
}

shinyApp(ui, server)
