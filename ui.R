
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel(h4("CCTV App Perf. Index Visualization")),
  

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      #selectInput("applications","Choose an application", choice=c("BBoardBridge","ConvertBridge","DataSouInterface","DataSourceApp","FourBridge","MigScheduler","NewsFiveBridge","NormalBridge")),
      selectInput("index", "Choose an index", choice=c("cpu usage","db time","sql hard parse","sql parse","user call","redo","phyical read","sql executions"))
#    selectInput("dataset", "Choose a dataset", choice = c("Select dataset","DataSourceApp", "BBoardBridge", "NewsFiveBridge", "Connections all")),
#      dateInput("dates", label = h5("Date input"), value="2015-03-10"),
#      checkboxGroupInput("Index Group", 
#                        label = h5("Index group"), 
#                         choices = list("连接数" = 1, 
#                                        "硬解析数" = 2, "解析数" = 3, "CPU使用率" = 4,
#                                        "DB TIME" = 5, "用户调用数" = 6, "SQL执行次数" = 7),
#                         selected = 1)
    
    ),

    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput("Outlier.DataSourceApp"),
      verbatimTextOutput("Outlier.DataSouInterface"),
      verbatimTextOutput("Outlier.BBoardBridge"),
      
      #img(src="Oracle1.png", height = 400, width = 400),
      plotOutput("indexplot")
    )
  )
))
