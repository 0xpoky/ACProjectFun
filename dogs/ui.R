library(shiny)

shinyUI(fluidPage(
  
  titlePanel("NYC Dog Data"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("age",
                  label = "Age",
                  choices = list("Puppy (1 year or younger)" = 1,
                                 "Adult (2 - 6 years)" = 2,
                                 "Senior (7 years or older)" = 3),
                  selected = 1)
    ),
    
    mainPanel(
       plotOutput("nameplot")
    )
  )
))
