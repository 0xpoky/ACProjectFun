library(shiny)
library(ggplot2)

source('processdata.R')

shinyServer(function(input, output) {
  
  output$breedplot <- renderPlot({
    age_cat <- input$age
    gender_cat <- input$gender
    breeds <- most_popular_breeds(age_cat, gender_cat)
    ggplot(breeds) + geom_col(aes(BreedName, n), fill = "forestgreen") +
      labs(title = "Top Ten Dog Breeds") +
      coord_flip()
    
  })
  
  output$nameplot <- renderPlot({
    age_cat <- input$age
    gender_cat <- input$gender
    names <- most_popular_names(age_cat, gender_cat)
    ggplot(names) + geom_col(aes(AnimalName, n), fill = "forestgreen") +
      labs(title = "Top Ten Dog Names")
    
  })
  
})
