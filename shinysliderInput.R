if("shiny" %in% installed.packages("shiny") == FALSE)install.packages("shiny")
library(shiny)
ui <- shiny::fluidPage(
  sliderInput(
    inputId = "num1",
    label= "숫자를 선택하세요",
    value= 25,
    min=1,
    max=50,
    step=1
  ),
  plotOutput("hist")
)
server <- function(input,output){
  output$hist <- renderPlot({
    hist(rnorm(input$num1),
    main="50범위내에서 선택")
  })
}
shiny::shinyApp(ui,server)

