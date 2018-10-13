library(shiny)
library(shinyjs)

gender <- function(x){
  t <- substr(x,8,8)
  cat("\n ssn에서 추출한 값:",t) #print함수와 동일하나 결과값을 더 자세하게 보여줌 
  y<- switch(t,   #ip else 함수와 동일 
         "1"="남성",
         "2"="여성",
         "3"="남성",
         "4"="여성",
         "5"="외국인",
         "6"="외국인",
         "잘못된 값")
  cat("\n 결과값:",y)
  return(y)
}

ui <- fluidPage(
  useShinyjs(),
  textInput("txt",
            label = h3("주민번호앞자리 입력"),
            value="(예시)900101-2"),
  actionButton("btn","확 인")
)

server <- function(input, output, session) {
  onclick("btn",
          info({gender(input$txt)})
          )
  # output$value <- renderText({gender(input$txt)})
  #성별을 체크하는 함수 코딩 
  
}

shinyApp(ui, server)


