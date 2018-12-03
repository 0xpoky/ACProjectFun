library('dplyr')
library('ggplot2')
library('stringr')

## Read in dog data and remove duplicates. We assume that if the name, gender, birth month and year, breed,
## and geographic information (such as zip code) are the same, then it is referring to the same dog.
data <- data.table::fread("dogs.csv.bz2", stringsAsFactors = FALSE) %>%
  select(-RowNumber, -LicenseIssuedDate, -LicenseExpiredDate) %>%
  unique()

## Select only relevant columns
dogs <- select(data, AnimalName, AnimalGender, AnimalBirthMonth, BreedName, Borough) %>%
  mutate(AnimalName = str_trim(AnimalName))

rm(data)

breed_list <- select(dogs, BreedName) %>%
  unique() %>%
  filter(BreedName != "Unknown")

breeds <- breed_list$BreedName %>%
  sort()

## Returns a dataset consisting of the counts of the 10 most popular dog names for a given age and gender
## category. Ages are calculated based on the time difference between the last day of 2016 and a
## dog's birth month.
most_popular_names <- function(age_cat, gender_cat) {
  date <- as.Date("2016-12-31")
  names <- select(dogs, AnimalName, AnimalGender, AnimalBirthMonth)
  
  if (gender_cat == 2) {
    names <- filter(names, AnimalGender == "F")
  } else if (gender_cat == 3) {
    names <- filter(names, AnimalGender == "M")
  }
  
  if (age_cat == 2) {
    names <- filter(names, date - as.Date(AnimalBirthMonth) < 2 * 365)
  } else if (age_cat == 3) {
    names <- filter(names, (date - as.Date(AnimalBirthMonth)) >= 2 * 365) %>%
      filter((date - as.Date(AnimalBirthMonth)) < 7 * 365)
  } else if (age_cat == 4) {
    names <- filter(names, date - as.Date(AnimalBirthMonth) >= 7 * 365)
  }
  
  names <- group_by(names, AnimalName) %>%
    count() %>%
    arrange(desc(n)) %>%
    filter(AnimalName != "UNKNOWN" && AnimalName != "NAME NOT PROVIDED" && AnimalName != "N/A") %>% 
    head(10)
  names$AnimalName <- reorder(names$AnimalName, names$n)
  return(names)
}

## Returns a dataset consisting of the counts of the 10 most popular dog names for a given breed
most_popular_names_by_breed <- function(breed) {
  names <- select(dogs, AnimalName, BreedName) %>%
    filter(BreedName == breed) %>%
    group_by(AnimalName) %>%
    count() %>%
    arrange(desc(n)) %>%
    filter(AnimalName != "UNKNOWN" && AnimalName != "NAME NOT PROVIDED" && AnimalName != "N/A") %>% 
    head(10)
  names$AnimalName <- reorder(names$AnimalName, names$n)
  return(names)
}

## Returns a dataset consisting of the counts of the 10 most popular dog breeds for a given age and gender
## category. Ages are calculated based on the time difference between the last day of 2016 and a
## dog's birth month.
most_popular_breeds <- function(age_cat, gender_cat) {
  date <- as.Date("2016-12-31")
  names <- select(dogs, BreedName, AnimalGender, AnimalBirthMonth)
  
  if (gender_cat == 2) {
    names <- filter(names, AnimalGender == "F")
  } else if (gender_cat == 3) {
    names <- filter(names, AnimalGender == "M")
  }
  
  if (age_cat == 2) {
    names <- filter(names, date - as.Date(AnimalBirthMonth) < 2 * 365)
  } else if (age_cat == 3) {
    names <- filter(names, (date - as.Date(AnimalBirthMonth)) >= 2 * 365) %>%
      filter((date - as.Date(AnimalBirthMonth)) < 7 * 365)
  } else if (age_cat == 4) {
    names <- filter(names, date - as.Date(AnimalBirthMonth) >= 7 * 365)
  }
  
  breeds <- group_by(names, BreedName) %>%
    count() %>%
    arrange(desc(n)) %>%
    filter(BreedName != "Unknown") %>%
    head(10)
  breeds$BreedName <- reorder(breeds$BreedName, breeds$n)
  return(breeds)
}

## Returns a dataset that includes the ages of dogs of the given breed. Ages are calculated based
## on the time difference between the last day of 2016 and a dog's birth month.
age_data <- function(breed) {
  date <- as.Date("2016-12-31")
  ages <- select(dogs, AnimalBirthMonth, BreedName) %>%
    filter(BreedName == breed) %>%
    mutate(age = round((date - as.Date(AnimalBirthMonth)) / 365, 1))
}

## Get number of dogs of a given breed per Borough 
boroughs_by_breed <- function(breed) {
  borough <- select(dogs, Borough, BreedName) %>%
    filter(BreedName == breed) %>%
    mutate(Borough = toupper(Borough))
  borough$Borough[borough$Borough == "STATEN IS"] = "STATEN ISLAND"
  borough <- group_by(borough, Borough) %>%
    count() %>%
    filter(Borough == "BROOKLYN" || Borough == "BRONX" || Borough == "QUEENS"
           || Borough == "STATEN ISLAND" || Borough == "MANHATTAN")
    
  return(borough)
}
