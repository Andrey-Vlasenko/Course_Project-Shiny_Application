
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
shinyUI(fluidPage(
  titlePanel("Motor Trend (brushed points and tabPanels)"),
  sidebarLayout(
    sidebarPanel(
      h3("Model 1 (on all data)"),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel1_a", "Show/Hide Model 1 only for auto", value = TRUE),
      checkboxInput("showModel1_m", "Show/Hide Model 1 only for manual", value = TRUE),
      h3("Model 2 (on brushed data)"),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      h3("Predictions of Model 1 and Model 2"),
      sliderInput("sliderWt", "Set the wt of the car", 1, 6, value = 3,step = 0.1)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Models", br(), 
                           h4("Please select the area of data points for Model 2 on the plot"),
                           plotOutput("plot1", brush = brushOpts(id = "brush1")),
                           h5("Slope 1"),
                           textOutput("slopeOut1"),
                           h5("Intercept 1"),
                           textOutput("intOut1"),
                           h5("Slope 2"),
                           textOutput("slopeOut2"),
                           h5("Intercept 2"),
                           textOutput("intOut2"),
                           h4("Predicted MPG from Model 1:"),
                           textOutput("pred1"),
                           h4("Predicted MPG from Model 2:"),
                           textOutput("pred2") 
                           ),
                  tabPanel("Difference", br(), 
                           h3("Difference Model1 from Model2:"),
                           h4("Predicted MPG from Model1 - Model2:"),
                           textOutput("pred3"),
                           plotOutput("plot2") 
                  )
      )
    )
  )
))
