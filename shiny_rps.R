library(shiny)
library(shinyjs)

rps <- function(x){
  #가위 1, 바위2, 보 3
  #a-b=0 비김
  #a-b=1,-2 b패배
  #a-b=-1,2 b승리 
  if(x=="가위"){
    user <-1
  }else if(x=="바위"){
    user <- 2
  }else {
    user <- 3
  }
  comp <- sample(1:3,1,replace = T)
  user <- x
  result <- comp-user
  print(result)
  return(if(result==1|result==-2)"패배"
  else if(result==-1|result==2)"승리"
  else "비김")
}
rps(2)

ui <- fluidPage(
  titlePanel("가위 바위 보 게임"),
  sidebarLayout(
    sidebarPanel(
      helpText("가위,바위,보 중에서 선택하세요"),
      selectInput("var",
                  label = "가위바위보",
                  choices=c("가위","바위","보"),
                  selected="가위")
     ), 
      mainPanel(
        textOutput("selectedVar")
    )
  )
)

server <- function(input, output, session) {
  output$selectedVar <- renderText(
    paste("경기결과:",rps(input$var)
  )
}

if(interactive()){
  shinyApp(ui,server)
}
shinyApp(ui, server)



