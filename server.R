
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output)
  {
  
  indexInput <- reactive({
    switch(input$index,
           "cpu usage" = cctv.cpu.all,
           "db time" = cctv.dbtime.all,
           "sql hard parse" = cctv.sqlhardparse.all,
           "sql parse" = cctv.sqlparse.all,
           "redo" = cctv.redo.all,
           "user call" = cctv.usercall.all,
           "phyical read" = cctv.phyread.all,
           "sql executions" = cctv.exec.all
           )
  })
  
  

    
#  if(is.null(dataset) != TRUE)
#    dataset.sub <- subset(dataset, DATE = input$dates)
  
  output$Outlier.DataSourceApp <- renderPrint({
    #mdate <- mydate()
    datasets <- indexInput()
    #if(is.null(datasets) != TRUE)
          #datasets[1,]
    dsisubset <- subset(datasets,APP_NAME=="DataSourceApp")
    
    outliers <- which(dsisubset$VALUE_DELTA %in% boxplot.stats(dsisubset$VALUE_DELTA)$out)
    #outliers <- which(subset(datasets,APP_NAME="DataSouInterface")$VALUE_DELTA %in% boxplot.stats(subset(datasets,APP_NAME="DataSouInterface")$VALUE_DELTA)$out)
    #head(subset(datasets,APP_NAME=="DataSouInterface")[outliers,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
    head(dsisubset[outliers,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
    #head(datasets[,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
    #tail(datasets[,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
    #which(datasets$VALUE_DELTA == (sort(datasets$VALUE_DELTA,decreasing=TRUE))[1:5])
    })

    output$Outlier.DataSouInterface <- renderPrint({
      #mdate <- mydate()
      datasets <- indexInput()
      #if(is.null(datasets) != TRUE)
      #datasets[1,]
      dsisubset <- subset(datasets,APP_NAME=="ConvertBridge")
      
      outliers <- which(dsisubset$VALUE_DELTA %in% boxplot.stats(dsisubset$VALUE_DELTA)$out)
      #outliers <- which(subset(datasets,APP_NAME="DataSouInterface")$VALUE_DELTA %in% boxplot.stats(subset(datasets,APP_NAME="DataSouInterface")$VALUE_DELTA)$out)
      #head(subset(datasets,APP_NAME=="DataSouInterface")[outliers,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      head(dsisubset[outliers,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      #head(datasets[,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      #tail(datasets[,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      #which(datasets$VALUE_DELTA == (sort(datasets$VALUE_DELTA,decreasing=TRUE))[1:5])
    })  

    output$Outlier.BBoardBridge <- renderPrint({
      #mdate <- mydate()
      datasets <- indexInput()
      #if(is.null(datasets) != TRUE)
      #datasets[1,]
      dsisubset <- subset(datasets,APP_NAME=="BBoardBridge")
      
      outliers <- which(dsisubset$VALUE_DELTA %in% boxplot.stats(dsisubset$VALUE_DELTA)$out)
      #outliers <- which(subset(datasets,APP_NAME="DataSouInterface")$VALUE_DELTA %in% boxplot.stats(subset(datasets,APP_NAME="DataSouInterface")$VALUE_DELTA)$out)
      #head(subset(datasets,APP_NAME=="DataSouInterface")[outliers,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      head(dsisubset[outliers,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      #head(datasets[,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      #tail(datasets[,c("APP_NAME","SNAP_TIME","VALUE_DELTA")])
      #which(datasets$VALUE_DELTA == (sort(datasets$VALUE_DELTA,decreasing=TRUE))[1:5])
    })
  
  
  output$indexplot <- renderPlot({
    
    datasets <- indexInput()
    
    xtime <- strptime(cctv.dbtime.all$TIME,"%H:%M:%S")
    
 
    ggplot(datasets, aes(x=strptime(xtime,"%H:%M:%S"),
                                 y=VALUE_DELTA,fill=APP_NAME)) + 
                                  geom_area() + 
                                  scale_fill_manual(values=c("#999999","#E69F00","#56B4E9","#009e73","#F0E442","#0072B2","#D55E00","#CC79A7")) + 
                                  facet_wrap(~DATE,ncol=1) + 
                                  theme(axis.text.x = element_text(angle=30,hjust=1)) + 
                                  xlab("Snap Time, step: 10 minutes") + 
                                  ylab("Index of Applications") + 
                                  ggtitle("Index Accumulation of Applications")

    #hist(dataset$VALUE_DELTA)
    
  })
  
  
  

})
