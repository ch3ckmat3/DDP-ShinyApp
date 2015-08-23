
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(scales)
library(reshape2)

shinyServer(function(input, output) {

  output$ggPlot <- renderPlot({

    #sort data
    colIndex <- grep(input$orderBy, colnames(ds))

    if (input$orderByDesc) {
      subds <<- ds[order(-ds[,colIndex]),]
    } else {
      subds <<- ds[order(ds[,colIndex]),]
    }

    #subset data
    subds <<- subds[1:input$airportCount,]

    #######################
    ### plot selected data

    #remove extra column fpr prep
    plotds <- subds[,-c(5)]

    #melt data for ladder plot
    plotds <- melt(plotds, id.var=c("Rank", "Airport"))

    #plot
    ggplot(plotds, aes(variable, value, group = Airport, colour = Airport)) +
      geom_path(alpha = 0.6, size = 1) +
      scale_y_continuous(labels = comma) +
      xlab("Year") + ylab("Passengers Handled") +
      ggtitle("Airport Performance by 2012-2013")
  })

  # render data subset table
  output$table <- renderDataTable({
      #sort data
      colIndex <- grep(input$orderBy, colnames(ds))

      if (input$orderByDesc) {
        subds <- ds[order(-ds[,colIndex]),]
      } else {
        subds <- ds[order(ds[,colIndex]),]
      }

      #subset data
      subds <- subds[1:input$airportCount,]
      subds
      },
      options = list(searching = FALSE, paging = TRUE, pageLength=10)
    )

  # debug - remove
  #output$text <- renderText({
  #  paste("Order by:", input$orderBy, " - Row Count Input:", input$airportCount, "Row Count DS: ", nrow(subds))
  #})

  # for raw data tab
  output$rawData <- renderDataTable(ds, options=list(pageLength=10))

})
