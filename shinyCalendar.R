library(shiny)
library(shinydashboard)
library(shinyjs)

library(shiny)

ui <- fluidPage(
 dateInput("date",
           label = h3("날짜입력"),
           value="2018-01-01"),
 hr(),
 fluidRow(column(3,verbatimTextOutput("value")))
)

server <- function(input, output, session) {
  output$value <- renderPrint({input$date})
}

shinyApp(ui, server)
