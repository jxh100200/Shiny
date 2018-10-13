library(shiny)
#고도 비만 : 40 이상
#중등도 비만 (2단계 비만) : 35 - 39.9
#경도 비만 (1단계 비만) : 30 - 34.9
#과체중 : 25 - 29.9
#정상 : 18.5 - 24.9
#저체중 : 18.5 미만
bmi <- function(t,w){
  t <- t/100
  x <- w/t*t
  return(if(x>=40)"고도 비만"else
    if(x>=35&x<40)"중등도 비만" else
    if(x>=30&x<35)"경도 비만" else
    if(x>=25&x<30)"과체중"else
    if(x>=18.5&x<25)"정상"else
    "저체중")
}
bmi(180,100)
ui <- shiny::fluidPage(
  numericInput("t","키:",10,min=1,max=100),
  numericInput("w","몸무게:",10,min=1,max=100),
  verbatimTextOutput("value")
)
server <- function(input,output,session){
  output$value <- renderText({bmi(input$t,input$w)})
}
shinyApp(ui,server)
  