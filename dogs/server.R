library(shiny)

shinyServer(function(input, output) {
  
  output$breedplot <- renderPlot({
    age_cat <- input$age1
    gender_cat <- input$gender1
    breeds <- most_popular_breeds(age_cat, gender_cat)
    ggplot(breeds) + geom_col(aes(BreedName, n), fill = "tomato") +
      labs(title = "Top Ten Dog Breeds") +
      coord_flip()
    
  })
  
  output$nameplot <- renderPlot({
    age_cat <- input$age2
    gender_cat <- input$gender2
    names <- most_popular_names(age_cat, gender_cat)
    ggplot(names) + geom_col(aes(AnimalName, n), fill = "gold1") +
      labs(title = "Top Ten Dog Names") +
      coord_flip()
    
  })
  
  output$topnamesplot <- renderPlot({
    breed_name <- input$breed
    if (breed_name != "") {
      names <- most_popular_names_by_breed(breed_name)
      ggplot(names) + geom_col(aes(AnimalName, n), fill = "darkslategray") +
        labs(title = "Top Names") +
        coord_flip()
    }
  })
  
  output$ageHist <- renderPlot({
    breed_name <- input$breed
    if (breed_name != "") {
      ages <- age_data(breed_name)
      ggplot(ages) + geom_histogram(aes(age), binwidth = 1, fill = "forestgreen") +
        labs(title = "Distribution of Ages")
    }
  })
  
  output$boroughplot <- renderPlot({
    breed_name <- input$breed
    if (breed_name != "") {
      borough <- boroughs_by_breed(breed_name)
      ggplot(borough) + geom_col(aes(Borough, n), fill = "orange") +
        labs(title = "Distribution of Borough of Residence") +
        ylab("Number") 
    }
  })
  
  output$nametrendsplot <- renderPlot({
    age_cat <- input$age2
    gender_cat <- input$gender2
    names <- most_popular_names_trends(age_cat, gender_cat)
    ggplot(names, aes(x = as.Date(AnimalBirthMonth), y = n, group = AnimalName)) +
      geom_line(aes(color = AnimalName)) + 
      labs(title = "Top Ten Dog Names Over Time") + 
      xlab("Year") +
      ylab("Count") +
      scale_x_date(date_breaks = "years" , date_labels = "%y")
    
  })
})
