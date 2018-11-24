library(shiny)
library(ggplot2)

source('processdata.R')

shinyServer(function(input, output) {
   
  output$nameplot <- renderPlot({
    age_cat <- input$age
    names <- most_popular_names(age_cat)
    ggplot(names) + geom_col(aes(AnimalName, n), fill = "blue") +
      labs(title = "Top Ten Dog Names")
    
  })
  
})
