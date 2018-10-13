library(shiny)
if("shinyjs" %in% installed.packages("shinyjs") == FALSE)install.packages("shinyjs")
library(shinyjs)

calc <- function(n1,op,n2){
  return(if(op=="+"){n1+n2}else
    if(op=="-"){n1-n2}else
    if(op=="*"){n1*n2}else
    if(op=="/"){n1%/%n2}else
    {0}
  )
}

ui <- shiny::fluidPage(
  useShinyjs(),
  numericInput("num1","첫번째수:",0,min=1,max=100),
  textInput("op","연산기호"),
  numericInput("num2","두번째수:",0,min=1,max=100),
  #verbatimTextOutput("value")
  actionButton("btn","클 릭")
)
server <- function(input,output,session){
  #output$value <- renderText({calc(input$num1,input$op,input$num2)})
  onclick("btn",info({calc(input$num1,input$op,input$num2)}))
}
if(interactive()){
  shinyApp(ui,server)
}
shinyApp(ui,server)

