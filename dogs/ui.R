library(shiny)


  
shinyUI(fluidPage(
  
  titlePanel("NYC Dog Data"),
  navbarPage("Dog Data",
    tabPanel("Description",
             mainPanel(
               img(src='https://media.giphy.com/media/Dkf37ayTUExQ4/giphy.gif', align = "right")),
             p("Now featuring dogs!. In this app you'll be able 
               to find information regarding top dog breeds, top names, have the 
               oppertunity to explore differnt dog breads and compare top name,
               distribution of ages, and distribution of borough of residence.")),
    
   
    tabPanel(
      "Top Breeds",
    sidebarLayout(
      sidebarPanel(
        selectInput("age1",
                    label = "Age",
                    choices = list("All Ages" = 1,
                                  "Puppy (1 year or younger)" = 2,
                                  "Adult (2 - 6 years)" = 3,
                                  "Senior (7 years or older)" = 4),
                    selected = 1),
        radioButtons("gender1",
                    label = "Gender",
                    choices = list("All Genders" = 1,
                                  "Female" = 2,
                                  "Male" = 3),
                    selected = 1)
        ),
        
        mainPanel(
          plotOutput("breedplot")
        ))
    ),
    
    tabPanel(
      "Top Names",
      sidebarLayout(
        sidebarPanel(
          selectInput("age2",
                      label = "Age",
                      choices = list("All Ages" = 1,
                                     "Puppy (1 year or younger)" = 2,
                                     "Adult (2 - 6 years)" = 3,
                                     "Senior (7 years or older)" = 4),
                      selected = 1),
          radioButtons("gender2",
                       label = "Gender",
                       choices = list("All Genders" = 1,
                                      "Female" = 2,
                                      "Male" = 3),
                       selected = 1)
        ),
        
        mainPanel(
          plotOutput("nameplot"),
          plotOutput("nametrendsplot")
        )
      )
      
    ),
    
    tabPanel("Explore Dog Breeds",
             sidebarLayout(
               sidebarPanel(
                 selectizeInput("breed",
                                label = "Breed",
                                choices = breeds, 
                                selected = "Dachshund")
                 ),
               
               mainPanel(
                 plotOutput("topnamesplot"),
                 plotOutput("ageHist"),
                 plotOutput("boroughplot")
               )
               
             )
    
    )
  )
))
