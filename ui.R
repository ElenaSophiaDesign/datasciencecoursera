library(shiny)
library(ggplot2)
library(dplyr)

shinyUI(
  navbarPage("Course Project",
             tabPanel("Plot",
        fluidPage(
        titlePanel("Gamma Distribution Simulation"),
        sidebarLayout(
          sidebarPanel(
             sliderInput("slider", "Sample Size:",
                         min = 1, max = 2000, value = 500),
             numericInput("shapeIn", label = "Shape:",
                          value = 1, min = .5, max = 5, step = .5),
             numericInput("scaleIn", label = "Scale:",
                          value = 1, min = .5, max = 5, step = .5),
             submitButton("Submit")
          ),
          mainPanel(
            plotOutput("Gplot")
          )
        )
)),

tabPanel("About",
         mainPanel(
           includeMarkdown("notes.md"))
         )
))
