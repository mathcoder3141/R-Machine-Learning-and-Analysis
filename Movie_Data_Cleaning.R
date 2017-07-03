# Set working directory
setwd("/Users/randallhall/Documents/r-data-analysis/2-r-data-analysis-m2-exercise-files")

# Load data from tab-delimited file
movies <- read.table(
  file = "Movies.txt",
  sep = "\t",
  header = TRUE,
  quote="\""
)

# Peak at data
head(movies)

# Look at column names
names(movies)

# Problem #1: Column name is incorrect
names(movies)[5]
# Rename varialbes (i.e. columns)
names(movies)[5] <- "Critic.Score"

# Problem #1 solved
names(movies)

# Problem #2: Missing Values
# Count Missing Values
sum(is.na(movies))

# Inspect rows witth missing values
tail(movies)

# Exclude observations with missing values
movies <- na.omit(movies)

# Problem #2 is solved
sum(is.na(movies))

# Problem #3 units in runtime column
# Peek at the movie runtime data
head(movies$Runtime)

# Determine the data type
class(movies$Runtime)

# Cast from factor to character string
runtimes <- as.character(movies$Runtime)
head(runtimes)
class(runtimes)

# Eliminate the unit of measure
runtimes <- sub(" min", "", runtimes)
head(runtimes)

# Cast the character string to integer
movies$Runtime <- as.integer(runtimes)
head(movies$Runtime)
class(movies$Runtime)

# Problem 4: Box office uses three units of measure
head(movies$Box.Office)

# Create a function to convert box office avenue
convertBoxOffice <- function(boxOffice)
{
  stringBoxOffice <- as.character(boxOffice)
  
  replaceBoxOffice <- gsub("[$|k|M]", "", stringBoxOffice)
  
  numericBoxOffice <- as.numeric(replaceBoxOffice)
  
  if (grepl("M", boxOffice)) 
  {
    numericBoxOffice
  }
  else if (grepl("k", boxOffice))
  {
    numericBoxOffice * 0.001
  }
  else
  {
    numericBoxOffice * 0.00001
  }
}

# Convert box office to single unit of measure (millions)
movies$Box.Office <- sapply(movies$Box.Office, convertBoxOffice)

# Problem 4 is solved
head(movies$Box.Office)
class(movies$Box.Office)
mean(movies$Box.Office)

# Set working directory
setwd("/Users/randallhall/Desktop")

# Save data to a CSV file
write.csv(movies, "Movies.csv")