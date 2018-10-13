library(shiny)
library(shinydashboard)
library(shinyjs)

library(shiny)

ui <- fluidPage(
  useShinyjs(),
  actionButton("btn",
               "클릭"
  )
)

server <- function(input, output, session) {
  onclick("btn",info(date()))
}

shinyApp(ui, server)
