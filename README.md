**ACProjectFun** from Grace, Maggie, Hawa and Liam

*Now featuring dogs!*

# Project Description 
## Data
We are going to use a public data source on dog registration in New York City, which contains information related to dog's such as names, ages, breeds, etc. and we will be able to analyze all of these variables in different ways.

[NYC Dog Licensing Dataset](https://public.enigma.com/datasets/nyc-dog-licensing-dataset-2016/3729f91b-f340-467e-9170-4078de389d24)

This data is collected through the DOHMH Dog Licensing System in New York City, where residents are required by law to register their dogs with the city government. We will be accessing it through Public.Enigma which provides us with either API access or a downloadable .csv file. 

## Audience 
Our audience is intended to be dog lovers in general, because we think this data will reveal a lot of interesting things about the popularity of certain dog breeds, names, etc. as well as possibly revealing trends in names/breeds that are trending either towards being more popular or less popular. 

We think our audience would be interested in reading about: 
* What was the most popular name for dogs in 2016?
* What was the most popular breed of dog in 2016? 
* What is a common name for older dogs that isn't as popular with younger dogs? 
* What breeds of dogs seem to live the longest? 
* Do certain names correlate with certain breeds?
* We could also ask these same questions but with the added variable of gender

# Technical Description
## Format
To present our final report, we will build a Shiny app to showcase the results of our research on dogs. The Shiny app will allow for user interaction, allowing users to explore various aspects or trends in the data. To read in data, we plan to use the Public.Enigma API, saving us from downloading a very large .csv file. 

## Data Wrangling and Libraries 
Our dataset is very large, consisting of over 120,000 rows. Since the dataset is already reasonably well formatted, we will not have to do much reshaping or reformatting of the data. However, we will have to remove possible duplicate rows so that each row corresponds to an unique dog. Additionally, we plan to filter out columns irrelevant to our analysis in order to speed up R data processing.

For this project, we anticipate using shiny to build our app and ggplot2 to illustrate plots or graphs.

## Questions and Challenges
Questions we will be answering through statistical analysis include distribution of dog names, breeds, age, and gender. We will also explore possible correlations between these variables.

Challenges we anticipate include manipulating the data to answer our questions and designing a visually appealing presentation of the results. For some of us, this is the first time we are assigned a group project that involves coding. Learning to work together in an effective way will also be very important.
