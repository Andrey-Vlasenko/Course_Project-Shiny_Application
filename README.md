# Course_Project-Shiny_Application

This README file is the supporting documentation accompagning the Shiny application available [here](https://andrey-vlasenko.shinyapps.io/ShinyCoursePr-Motor_Trend/).
In this repository you can see the source code of that application:
- server.R
- ui.R

For the associated Slidify presentation, [click here]()

## Description of the Application

This application was developed to compare two linear models which were biult on the mtcars data set.
Both models are _lm(mpg~wt)_ but first model (*Model1*) uses all data points and the second (*Model2*) uses only data points from selected area. 

To set area of data for Model2 you have to select (brush) area on the plot on the 'Models' tabPanel. On this tabpanel you can see coefficents of models and predicted values (You can use slider to set the value of weight to predict mpg).

On the tabPanel 'Difference' you can see the plot of difference in predictions of Model1 and Model2 (*y=Model1-Model2*).
