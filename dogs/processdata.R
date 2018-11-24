library('dplyr')
library('ggplot2')
library('stringr')

## Read in dog data and remove duplicates. We assume that if the name, gender, birth month and year, breed,
## and geographic information (such as zip code) are the same, then it is referring to the same dog.
data <- read.csv("dogs.csv.bz2", stringsAsFactors = FALSE) %>%
  select(-RowNumber, -LicenseIssuedDate, -LicenseExpiredDate) %>%
  mutate(AnimalName = str_trim(AnimalName)) %>%
  unique()

## Select only relevant columns
dogs <- select(data, AnimalName, AnimalGender, AnimalBirthMonth, BreedName, Borough)

## Returns a dataset consisting of the counts of the 10 most popular dog names for a given age
## category. Ages are calculated based on the time difference between the last day of 2016 and a
## dog's birth month.
most_popular_names <- function(age_cat) {
  date <- as.Date("2016-12-31")
  if (age_cat == 1) {
    names <- filter(dogs, date - as.Date(AnimalBirthMonth) < 2 * 365)
  } else if (age_cat == 2) {
    names <- filter(dogs, (date - as.Date(AnimalBirthMonth)) >= 2 * 365) %>%
      filter((date - as.Date(AnimalBirthMonth)) < 7 * 365)
  } else {
    names <- filter(dogs, date - as.Date(AnimalBirthMonth) >= 7 * 365)
  }
  names <- group_by(names, AnimalName) %>%
    count() %>%
    arrange(desc(n)) %>%
    filter(AnimalName != "UNKNOWN" && AnimalName != "NAME NOT PROVIDED" && AnimalName != "N/A") %>% 
    head(10)
}

