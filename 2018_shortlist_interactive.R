#install packages
install.packages("DT")
install.packages("htmlwidgets")
install.packages("widgetframe")

unloadNamespace('data.table')
unloadNamespace('reshape2')
unloadNamespace('plyr')

#load datatables library
library(DT)
library(htmlwidgets)
library(widgetframe)

#load csv
dat <- read.csv("/docs/data/period-compare.csv")

#create data table as R object
table <- datatable(dat, rownames = FALSE,
                             colnames=c("State", "2015-2016","2017-2018", "Rise in Turbulence"), 
                             extensions = 'Responsive',
                             options = list(
                               dom = 'lpt',
                               searching = FALSE,
                               pageLength = 12,
                               paging = FALSE,
                               autoWidth = TRUE,
                               initComplete = JS(
                                 "function(settings, json) {",
                                 "$(this.api().table().header()).css({
                                 'text-align': 'left',
                                 'background-color': '#092253', 
                                 'color': '#fff', 
                                 'font-family': 'verdana',
                                 'font-size': '14px'});",
                                 "}"),
                               rowCallback = JS(
                                 "function(row, data, index){",
                                 "if(data[3] < 0){
                                   $(row).find('td:eq(3)').css('color', 'red');
                                 }",
                                 "}")
)) %>%
  formatStyle(columns = c(1, 2, 3, 4), fontSize = '80%', fontFamily = 'verdana')

#create htmlwidget object
saveWidget(frameableWidget(table), "/docs/index.html", selfcontained = FALSE, libdir = "src")
