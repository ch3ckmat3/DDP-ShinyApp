
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(navbarPage("Data App",

  tabPanel("Plot",

    # Application title
    titlePanel("Top Airports by 2012/2013 - Analysis using Ladder Plot"),
    p("Based on Busiest International Routes to and from Suvarnabhumi Airport (2013)"),

    # Sidebar with a slider input for number of rows
    sidebarLayout(
      sidebarPanel(
        sliderInput("airportCount",
                    "Show Number of Airports:",
                    min = 1,
                    max = 50,
                    value = 5),

        selectInput("orderBy",
                    "Sort Airports By:",
                    names(ds),
                    selected=1,
                    multiple = FALSE),

        checkboxInput("orderByDesc",
                      "Descending", FALSE),

        submitButton("Submit")
      ),

      # Show a plot of airport perfomance in 2012 & 2013
      mainPanel(
        fluidRow(
          #debug
          #verbatimTextOutput("text")
        ),
        fluidRow(
          plotOutput("ggPlot")
          ),
        fluidRow(
          h4("Selected Data"),
          dataTableOutput(outputId="table")
        )
      )
    )
  ), #app tab ends

  tabPanel("Data",
    titlePanel("Top Airports by 2012/2013 - Raw Data"),

    p("Based on Busiest International Routes to and from Suvarnabhumi Airport (2013)"),
    a(href="https://en.wikipedia.org/wiki/Suvarnabhumi_Airport#Traffic_and_statistics",
      "Source: https://en.wikipedia.org/wiki/Suvarnabhumi_Airport#Traffic_and_statistics"),
    p("Meta: The 'y2012' and 'y2013' columns denote the number of passengers handled each year."),

    dataTableOutput(outputId="rawData")
  ),

  tabPanel("About",
    includeMarkdown("readme.md")
  )

))
