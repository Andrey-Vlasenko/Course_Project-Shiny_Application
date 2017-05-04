
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
shinyServer(function(input, output) {
  Model1 <- lm(mpg ~ wt, data = mtcars)
  Model1_a <- lm(mpg ~ wt, data = mtcars[mtcars$am==0,])
  Model1_m <- lm(mpg ~ wt, data = mtcars[mtcars$am==1,])
  Model2 <- reactive({
    brushed_data <- brushedPoints(mtcars, input$brush1,
                                  xvar = "wt", yvar = "mpg")
    if(nrow(brushed_data) < 2){
      return(NULL)
    }
    lm(mpg ~ wt, data = brushed_data)
  })
  output$slopeOut1 <- renderText({
      Model1[[1]][2]
  })
  output$intOut1 <- renderText({
      Model1[[1]][1]
  })
  output$slopeOut2 <- renderText({
    if(is.null(Model2())){
      "No Model2 Found"
    } else {
      Model2()[[1]][2]
    }
  })
  
  output$intOut2 <- renderText({
    if(is.null(Model2())){
      "No Model2 Found"
    } else {
      Model2()[[1]][1]
    }
  })
  Model1pred <- reactive({
    wtInput <- input$sliderWt
    predict(Model1, newdata = data.frame(wt = wtInput))
  })
  Model2pred <- reactive({
    wtInput <- input$sliderWt
    predict(Model2(), newdata = data.frame(wt = wtInput))
  })
  output$plot1 <- renderPlot({
    wtInput <- input$sliderWt
    plot(mtcars$wt, mtcars$mpg, xlab = "Weight", 
         ylab = "Miles Per Gallon", bty = "n", pch = 16,
         xlim = c(1, 6), ylim = c(5, 35), col=mtcars$am+8)
    if(input$showModel1){
      abline(Model1, col = "red", lwd = 2)
    }
    if(input$showModel1_a){
      abline(Model1_a, col = 8, lwd = 1)
    }
    if(input$showModel1_m){
      abline(Model1_m, col = 9, lwd = 1)
    }
    if((input$showModel2)&(!is.null(Model2()))){
      abline(Model2(), col = "blue", lwd = 2)
    }
    legend(4.3, 35, c("Model 1 Prediction", "Model 2 Prediction",
                      "automatic transmission", "manual transmission"), pch = 16, 
           col = c("red", "blue",8,9), bty = "n", cex = 1.2)
    if(input$showModel1){
      points(wtInput, Model1pred(), col = "red", pch = 16, cex = 1.5)
    }
    if(input$showModel1){
      points(wtInput, Model1pred(), col = "red", pch = 16, cex = 1.5)
    }
    if((input$showModel2)&(!is.null(Model2()))){
      points(wtInput, Model2pred(), col = "blue", pch = 16, cex = 1.5)
    }
  })
  output$plot2 <- renderPlot({
    wtInput <- input$sliderWt
    x <- seq(1,6,0.01); y=x; y[]=0
    if(!is.null(Model2())){
      y = x*(Model1[[1]][2]-Model2()[[1]][2])+(Model1[[1]][1]-Model2()[[1]][1])
    }
    plot(x, y, xlab = "Weight", 
         ylab = "Diff. in Miles Per Gallon", bty = "n", pch = 16,
         xlim = c(1, 6), ylim = c(min(y), max(y)))
  })
  output$pred1 <- renderText({
      Model1pred()
  })
  output$pred2 <- renderText({
    if(is.null(Model2())){
      "No Model2 Found"
    } else {
      Model2pred()
    }
  })
  output$pred3 <- renderText({
    if(is.null(Model2())){
      "No Model2 Found"
    } else {
      Model1pred() - Model2pred()
    }
  })
})
