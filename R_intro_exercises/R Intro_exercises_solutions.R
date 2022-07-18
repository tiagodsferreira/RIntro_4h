###############################################################################
# EXERCISE 1: Playing R's lottery
###############################################################################

# 1. Start a new R work session and check your current Work Directory (WD).  
getwd()

#2. Add a new folder to your desktop (**new_wd**) and define this folder as your new WD.  
dir.create("C:/Users/tiago/Desktop/newfolder")
setwd("C:/Users/tiago/Desktop/newfolder")

# 3. Assign to a new object, *mynumbers*, 5 non-repeated integers selected from the first 50 positive integers. 
mynumbers <- c(7, 27, 22, 14, 24)

# 4. Assign to a new object, *mystars*, 2 non-repeated integers selected from the first 12 positive integers.
mystars <- c(5, 7)

# 5. Access the R help file for the **sample()** function.  
?sample

# 6. Use the **sample()** function to create a new object, *key_numbers*. Assign to this object 5 non-repeated integers, randomly selected from the first 50 positive integers.
key_numbers <- sample(1:50, 5, replace=FALSE)

# 7. Use the **sample()** function to create a new object, *key_stars*. Assign to this object 2 non-repeated integers, randomly selected from the first 12 positive integers.
key_stars <- sample(1:12, 2, replace=FALSE)

# 8. Print the objects *mynumbers*, *mystars*, *key_numbers*, and *key_stars* in the console.  
mynumbers
mystars
key_numbers
key_stars

# 9. Use the  **%in%** logical operator to check if any of your numbers (*mynumbers*) or stars (*mystars*) were selected by R. The **%in%** will return a logical vector indicating which numbers in vector 1 (e.g., *mynumbers*) match the numbers in vector 2 (e.g., *key_numbers*). Use **?match** for accessing the **%in%** operator help file.  
mynumbers %in% key_numbers
mystars %in% key_stars 

# 10. List all objects in work workspace.
ls()
 
# 11. Remove the objects *mynumbers* e *mystars* from your workspace.  
rm(mynumbers, mystars)

# 12. Clean your workspace and console.
rm(list = ls())
shell("cls") # Or shortcut Ctrl + l

###############################################################################
# Practice time #2: "Smart doggy!"
###############################################################################

# 1. Import *dogs.csv* Data Frame (DF) to your workspace and assign this DF to a new object called **DOGS**. Three indicators of obedience intelligence are included in the DF:  
# obey: probability of obeying the first command;  
# reps_lower: lower limit of repetitions to understand new commands;  
# reps_upper: upper limit of repetitions to understand new commands;   
DOGS <- read.csv("G:\\My Drive\\FPCEUP\\R trainning\\GitRepo\\Intro to R\\R_intro_data\\dogs.csv")

# 2. Check **DOGS** class and structure.  
class(DOGS)
str(DOGS)

#3. Display **DOGS** variable's names in the console and the names of the first and second variables to *breed* and *class*, respectively.  
names(DOGS)
names(DOGS)[1:2] <- c("breed", "class")

#4. Present the first 10 observations (lines) in **DOGS**.  
head(DOGS, 10)

#5. Display breeds’ list in your console.  
DOGS$breed 
# or
DOGS[, "breed"]

#6. Access information in 9th line and columns from 1 to 3.  
DOGS[9, 1:3]

#7. Access the available information for the *Pointer* and *Great Dane* breeds.  
DOGS[DOGS$breed=="Pointer" | DOGS$breed=="Great Dane", ]

#8. Which breeds in the DF have the highest and lowest obey scores?  
DOGS[which.max(DOGS$obey), ]
DOGS[which.min(DOGS$obey), ]

#9. A new breed was recently discovered in Portugal. Researchers named this as "Vira Latas" and were impressed by its obedience scores. Here’s the "Vira Latas" records:  
# data.frame(breed = "Vira Latas", class = "genious", obey = 98, reps_lower = 1, reps_upper = 2)   
# Add this data to your **DOGS** DF.  
DOGS <- rbind(DOGS, data.frame(breed = "Vira Latas", class = "genious", obey = 98, reps_lower = 1, reps_upper = 2))

#10. Sort **DOGS** DF in ascending order by breeds' obedience scores. 
DOGS <- DOGS[order(DOGS$obey), ]

#11. Remove cases with missing obey scores in your DF.  
is.na(DOGS$obey)
DOGS <- DOGS[!is.na(DOGS$obey), ]

#12. Check the class of the **class** variable in **DOGS** DF and transform this variables into a factor with the following ordered categories:  
# dumb < slow < normal < clever <  intelligent < bright
DOGS$class <- factor(DOGS$class, 
                     levels=c("dumb", "slow", "normal", "clever", "intelligent", "bright", "genious"), ordered = TRUE) 
# we can drop unused levels using the **droplevels()** functio
DOGS$class <- droplevels(DOGS$class)

#13. Confirm **class** attributes and, using the table() function, count the number of breeds in each **class** category.  
attributes(DOGS$class)
table(DOGS$class)

#14. Which "clever" dogs have obey probability equal or higher than 70?   
DOGS[DOGS$class == "clever" & DOGS$obey >= 70,]


###############################################################################
# Practice time #3: "Nice coffee!"
###############################################################################
#1. Import **coffee.csv** Data Frame (DF) to your workspace and assign this DF to a new object called **COFFEE**. This DF has Yelp.com reviews on coffee shops from Austin and was adapted from: https://data.world/rdowns26/austin-coffee-yelp-reviews/workspace/project-summary    
COFFEE <- read.csv("G:\\My Drive\\FPCEUP\\R trainning\\GitRepo\\Intro to R\\R_intro_data\\coffee.csv")

#2. Summarize **COFFEE** DF and check its last 5 rows.  
summary(COFFEE)
tail(COFFEE, 5)

#3. Summarize the *coffee*, *tea*, *food*, and *alcohol* variables. 
myvars <- c("coffee", "tea", "food", "alcohol")
summary(COFFEE[myvars])

#4. Use the **describe()** function from the psych package to present descriptive statistics for the *coffee*, *tea*, *food*, and *alcohol* variables.  
library(psych)
describe(COFFEE[myvars])

#5. Used **describeBy()** function to descriptive the same variables by *cityarea*.  
describeBy(COFFEE[myvars], COFFEE$cityarea) 

#6. Produce histograms to visualize the distributions of the *coffee*, *tea*, *food*, and *alcohol*  variables.
par(mfrow=c(2,2))

hist(COFFEE$coffee)
hist(COFFEE$tea)
hist(COFFEE$food)
hist(COFFEE$alcohol)

dev.off()

#7. Use the **corr.test()** function from the psych package to present correlations for "num_reviews", "rating", "coffee", "tea", "food", and "alcohol" variables.   
library(psych)
coffee_num <- COFFEE[c(3,5,10,12,14,16)]
corr.test(coffee_num)

#8. Use the t.test function (see t.test help)to analyze whether the average satisfaction ratings ("ratings") differ by coffee shops with or without free Wifi ("internet").   
t.test(rating ~ internet, data=COFFEE)  # h0 (no differences) is retained
boxplot(rating ~ internet, data=COFFEE)

#9. Test to what extent coffee satisfaction ratings ("coffee") predict the coffee shop global rating ("rating"). Plot the model and add the regression line through the **abline()** function.  
model1 <-  lm(rating ~ coffee, data = COFFEE)
summary(model1)

plot(rating ~ coffee, data = COFFEE)
abline(lm(rating ~ coffee, data = COFFEE))

#10. Test whether coffee shops mean ratings ("rating") are significantly different across city area. Summary the results and perform post hoc analysis. Display notched parallel box plot to help you understanding the results.  
model2 <- aov(rating ~ cityarea, data = COFFEE)
summary(model2)
TukeyHSD(model2)
boxplot(rating ~ cityarea, data = COFFEE, notch=TRUE)

