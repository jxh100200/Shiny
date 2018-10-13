if("plotly" %in% installed.packages("plotly") == FALSE)install.packages("plotly")
library(plotly)
library(shiny)

data <- data.frame(
  population <- sample(1:20,10,replace = T),
  HouseHolds <- sample(1:20,10,replace = T),
  year <- sample(c(2000,2010),10,replace = T)
)
str(data)

ui <- fluidPage(
  titlePanel(
  title=h4("인구 조사",align="center")
  ),
  sidebarPanel(
    radioButtons("YEAR","10년 주기선택",
                 choices=c("2000","2010"),
                 selected="2000")
  ),
  mainPanel(
    plotOutput("bar",height = 500))
)

server <- function(input, output) {
  reactive_data <- reactive({
    selected_year <- as.numeric(input$YEAR)
    return(data[data$year==selected_year,])
  })
  output$bar <- renderPlot({
    color <- c("bule","red")
    our_data <- reactive_data()
    barplot(colSums(our_data[,c("population","HouseHolds")]),
    ylab <- "Total",
    xlab <- "Census Year",
    names.arg=c("population","HouseHolds"),
    col=color)
  })
}

shinyApp(ui, server)
