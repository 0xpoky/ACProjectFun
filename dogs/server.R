library(shiny)

shinyServer(function(input, output) {
  
  output$breedplot <- renderPlot({
    age_cat <- input$age1
    gender_cat <- input$gender1
    breeds <- most_popular_breeds(age_cat, gender_cat)
    ggplot(breeds) + geom_col(aes(BreedName, n), fill = "tomato") +
      labs(title = "Top Ten Dog Breeds") +
      coord_flip() +
      ylab("Count") +
      xlab("Breed")
    
  })
  
  output$nameplot <- renderPlot({
    age_cat <- input$age2
    gender_cat <- input$gender2
    names <- most_popular_names(age_cat, gender_cat)
    ggplot(names) + geom_col(aes(AnimalName, n), fill = "gold1") +
      labs(title = "Top Ten Dog Names") +
      coord_flip() +
      ylab("Count") +
      xlab("Name")
    
  })
  
  output$topnamesplot <- renderPlot({
    breed_name <- input$breed
    if (breed_name != "") {
      names <- most_popular_names_by_breed(breed_name)
      ggplot(names) + geom_col(aes(AnimalName, n), fill = "darkslategray") +
        labs(title = "Top Names") +
        coord_flip() +
        ylab("Count") +
        xlab("Name")
    }
  })
  
  output$ageHist <- renderPlot({
    breed_name <- input$breed
    if (breed_name != "") {
      ages <- age_data(breed_name)
      ggplot(ages) + geom_histogram(aes(age), binwidth = 1, fill = "forestgreen") +
        labs(title = "Distribution of Ages") +
        ylab("Count") +
        xlab("Age")
    }
  })
  
  output$boroughplot <- renderPlot({
    breed_name <- input$breed
    if (breed_name != "") {
      borough <- boroughs_by_breed(breed_name)
      ggplot(borough) + geom_col(aes(Borough, n), fill = "orange") +
        labs(title = "Distribution of Borough of Residence") +
        ylab("Count") 
    }
  })
  
  output$nametrendsplot <- renderPlot({
    age_cat <- input$age2
    gender_cat <- input$gender2
    names <- most_popular_names_trends(age_cat, gender_cat)
    ggplot(names, aes(x = AnimalBirthYear, y = n, group = AnimalName)) +
      geom_line(aes(color = AnimalName), size = 1) + 
      labs(title = "Top Six Dog Names Over Time") + 
      xlab("Year") +
      ylab("Count") +
      labs(color = "Name")
    
  })
  
  output$breedtrendsplot <- renderPlot({
    age_cat <- input$age1
    gender_cat <- input$gender1
    breeds <- most_popular_breeds_trends(age_cat, gender_cat)
    ggplot(breeds, aes(x = AnimalBirthYear, y = n, group = BreedName)) +
      geom_line(aes(color = BreedName), size = 1) + 
      labs(title = "Top Six Dog Breeds Over Time") + 
      xlab("Year") +
      ylab("Count") +
      labs(color = "Breed")
    
  })
  
})
