library(shiny)

shinyUI(fluidPage(
  
  titlePanel("NYC Dog Data"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("age",
                  label = "Age",
                  choices = list("All Ages" = 1,
                                 "Puppy (1 year or younger)" = 2,
                                 "Adult (2 - 6 years)" = 3,
                                 "Senior (7 years or older)" = 4),
                  selected = 1),
      radioButtons("gender",
                  label = "Gender",
                  choices = list("All Genders" = 1,
                                 "Female" = 2,
                                 "Male" = 3),
                  selected = 1)
    ),
    
    mainPanel(
       plotOutput("nameplot")
    )
  )
))
