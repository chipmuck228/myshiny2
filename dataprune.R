function(filename){

sheetindex = 1
data.result <- data.frame()
data.temp <- data.frame()

appname <- c("BBoardBridge","ConvertBridge","DataSouInterface","DataSourceApp","FourBridge","MigScheduler","NewsFiveBridge","NormalBridge")
for(sheetindex in 1:length(appname))
{
data.temp <- read.xlsx(filename, sheetIndex=sheetindex)
data.temp$APP_NAME = appname[sheetindex]
data.temp$DATE = format(data.temp$SNAP_TIME, "%y-%m-%d")
data.temp$TIME = format(data.temp$SNAP_TIME, "%H:%M:%S")
data.result <- rbind(data.result, data.temp)
tail(data.result)
}
return(data.result)
}