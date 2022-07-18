# A (very) short introduction to R ----
  
# R basic functioning ----

## R functions ----
print("Hello!")

## R Work session ----

getwd() # get current WD
setwd("C:/Users/tiago/Desktop") # set a new WD

# Operators and objects ---- 
## Basic communication with R ----
x1 <- 10 # assigns number 10 to object "x1"
x1 # display object in the console

## Operators - assignment ----
x2 <- 0:10  # assigns integers from 0 to 20 to object "x2"
x2
x3 <- c(5, 4, 1, 6, 7, 2, 2, 3, 2, 8)  # using concatenate to create a numeric vector 
x3

## Arithmetic operators ----
x1 <- 2 + 2 #	addition
x2 <- 6 - 2 #	subtraction
x3 <- x1 * x2 #	multiplication
x4 <- x3 /	8 # division
x5 <- x2^x4 # exponentiation; OR 6**2
print(c(x1, x2, x3, x4, x5))

## Relational operators - testing (in)equality ----
x1 < 5 # smaller than 
x1 <= x5 # smaller or equal than
x1 >= x2 # larger or equal than
x1 == x5	# exactly equal to
x1 != x5 # not equal to

## Logical operators - boolean operations ----
x1 | x3 == 4 #	x1 OR x3
x1 & x3 <= 16	# x1 AND x3

## Help on operators ----
?base::Arithmetic
?base::Logic 

## Managing R session ----
ls()  #  returns the names of the objects in the environment
rm(x1)  # removes "x1" from the environment
rm(list = ls())  # using ls() as the argument for "list" will 
# remove all objects from the environment

### Cleaning the console
cat("\014") # cleans console 
# OR 
shell("cls") # shell("clear") if Linux or Mac.
# OR shortcut Ctrl + l

## Help ----
help.start() # general help
help("rm") # help on the function "rm" (quotation marks are optional) | OR ?rm
help.search("ls") # searches the help system using the keyword "ls" | OR ??ls


# Practice time 1: "Playing R’s lottery" ----

# Data Structures ----

## Data Structures

id <- c(1:5)
sex <- c("Male", "Male", "Female", "Male", "Female")
t0_date <- as.Date(c('2017-11-2','2017-11-4','2017-11-5','2017-11-10','2017-11-11'))
t0_beh_prob <- c(11, 14, 5, 20, 16)
intervention <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
t1_date <- as.Date(c('2018-11-1','2018-11-3','2018-11-4','2018-11-10','2018-11-11'))
t1_beh_prob <- c(8, 11, 7, 15, 16)

data_beh <- data.frame(id, sex, t0_date, t0_beh_prob, intervention, t1_date, t1_beh_prob)

## Data classes ----
a <- "one" # Creates a character vector
b <- 1 # Creates a numeric vector
c <- 1L # Creates a numeric (integer) vector
d <- TRUE # Creates a logical vector

print(c(a, class(a)))
print(c(b, class(b)))
print(c(c, class(c)))
print(c(d, class(d)))

## Vectors ----
id <- c(1.2, 3.1, 2.1, 4.5) # numerical vector
id
age <-  c(20, 24, 21, 40) # numerical vector
class(age) # returns object class

name <- c("Ana", "Manuel", "Afonso", "Maria") # character vector
name
class(name)
length(name) # returns object lenght

ruser <- c(TRUE, FALSE, FALSE, TRUE) # logical vector
ruser
class(ruser)
table(ruser)

rbaseskills <- c(40, 35, 20, 60) # previous skills in R using a scale from 1 to 100
rmotivation <- c(60, 90, 10, 50) # motivation in a scale from 1 to 100
rbaseskills[2] # returns vector's 2nd value
rbaseskills[c(2,3)] # returns vector's 2nd and 3rd values

### Basic operations with vectors ----
rbaseskills > rmotivation # logical operation
rbaseskills + 1 # arithmetic operation
rbaseskills + rmotivation # arithmetic operation


## Matrices ----
dailyuse <- rnorm(20, mean = 2, sd = .5) # Creates a vector with 20 elements
dailyuse <- round(dailyuse, 0) # rounds the vector to 0 decimals
dailyuse
class(dailyuse)

dailyuse <-
  matrix(
    dailyuse,
    nrow = 4,
    ncol = 5,
    dimnames = list(NULL,
                    c("day1", "day2", "day3", "day4", "day5"))
  )
dailyuse
class(dailyuse)

dailyuse[1, 2]  # select element in row 1, column 2
dailyuse[c(1, 4), ] # leaving column field blank will select all columns
dailyuse[2:3, -1] # select rows from 2 to 3 and all columns except column 1

## Data frame ----
df  <-  data.frame(id, name, ruser, rbaseskills, rmotivation, dailyuse) 
df

bechdel <-
  read.table(
    "G:\\My Drive\\FPCEUP\\R trainning\\GitRepo\\Intro to R\\R_intro_data\\bechdel.csv",
    header = TRUE,
    sep = ";",
    quote = "\"", 
    dec = ".",
    na.strings = " ",
    stringsAsFactors = FALSE,
    colClasses =  c("numeric", "character", "factor", "factor", "numeric", "numeric", "numeric"),
    fileEncoding="UTF-8-BOM")


bechdel <-
  read.csv2(
    "G:\\My Drive\\FPCEUP\\R trainning\\GitRepo\\Intro to R\\R_intro_data\\bechdel.csv")
dim(bechdel)
head(bechdel, 2)

data() # lists all available datasets
browseURL("http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html") 
# informations about available datasets
?mtcars # diplays information about cars dataset

data(mtcars)  # loading a data frame
class(mtcars)
head(mtcars, 2)

mtcars # displays a dataset
head(mtcars,2)
mtcars[1:3, 1]
mtcars$mpg # extract column "mpg"
mtcars[sample(1:nrow(mtcars), 2), ]
mtcars$hp <= 70
mtcars[mtcars$hp <= 70,]
mtcars[mtcars$hp <= 70 & mtcars$mpg <= 30, "qsec"]


# Built-in functions for basic statistics ----

## Basic functions - Inspect data structure ----
class(mtcars) # reports the data format
dim(mtcars) # reports data dimensions
names(mtcars) # view variable names
str(mtcars) # summarizes data structure

## Basic functions - View data ----
head(mtcars) # returns first observations

## Basic functions - Summarize data ----
summary(mtcars[,1:8]) # summarize R objects

## Basic functions - Ordering data ----
which.max(mtcars$qsec) # Prints the row name (index) with the highest value for qsec
which.min(mtcars$qsec) # Prints the row name (index) with the lowest value for qsec
mtcars[which.min(mtcars$qsec),] 
order(mtcars$qsec) # Orders the vector of indexes into ascending or descending order
head(mtcars[order(mtcars$qsec), ], 2) # Orders the original DF using ordered indexes

## Basic functions - Visualising data  ----
barplot(table(mtcars$cyl)) # bar plot for cylinder
hist(mtcars$qsec) # histogram for 1/4 mile time
plot(mtcars$qsec, mtcars$hp) # scatter plot for hp and qsec

## Basic functions - Summarize data (cont.) ----
mean(mtcars$hp)
sd(mtcars$hp)
cor(mtcars[,c(4,6,7)])

## R formulas ----
form <- y ~ x
class(form)
names(mtcars)
model1 <- lm(qsec ~ hp, data = mtcars) # linear regression model
summary(model1)
plot(qsec ~ hp, data = mtcars)
mtcars$cyl_factor <- as.factor(mtcars$cyl) # Creates a factor from cyl
head(mtcars$cyl_factor)
model2 <- aov(mpg ~ cyl_factor, data=mtcars)  
summary(model2)
model2$coefficients # 2 cylinders is the reference category
TukeyHSD(model2) 
plot(mpg ~ as.factor(cyl), data=mtcars)

# Practice time 2: "Smart doggy!" ----

# Some usefull packages ----

## The *"data.table"* package ----
install.packages("data.table")
help(package="data.table")
library(data.table)
bechdel <- fread("G:\\My Drive\\FPCEUP\\R trainning\\GitRepo\\Intro to R\\R_intro_data\\bechdel.csv")
names(bechdel)
bechdel[c(152,1500),1:4]
?data.table::fread

## The *"psych"* package ----
install.packages("psych")
help(package="psych")
library(psych)

class(bechdel)
bechdel$movie_title <- as.character(bechdel$movie_title)
bechdel$bechdel_test_binary <- as.factor(bechdel$bechdel_test_binary)
sapply(bechdel, class)

names(bechdel)
psych::describe(bechdel[ ,c(3,5)], check=FALSE)
describeBy(bechdel[ ,5], group=bechdel[ ,4])
reliability <- alpha(bechdel[ ,c(5, 6)]) # Internal consistency measures of reliability
reliability$total
correlations <- corr.test(bechdel[ ,c(3, 5:7)])
correlations$r
correlations$p
cor.plot(bechdel[ ,c(3, 5:7)], cex=.5)

# Practice time 3: Nice coffee! ----