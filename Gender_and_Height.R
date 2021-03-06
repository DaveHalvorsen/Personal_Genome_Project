
# The aim of this R Markdown document is to compare the heights of men and women
# Read in the Excel
# PGPBasicPhenotypesSurvey2015-20180819174645.csv file is in Personal_Genome_Project directory (CWD)
# Has columns of Participant, Height, Weight, *BUT NOT* Gender
height_CSV <- read.csv(file="PGPBasicPhenotypesSurvey2015-20180819174645.csv", header=TRUE, sep=",")
# Has Gender, but not height or weight
gender_CSV <- read.csv(file="PGPParticipantSurvey-20180819174510.csv", header=TRUE, sep=",")

# These are the ENTIRE CSV documents, so we need to slice them down
# height_CSV
# gender_CSV

# the lengths of these CSVs are mis-matched, BUT they have participant names in common
print('rows of height CSV')
length(height_CSV$Height)
print('rows of gender CSV')
length(gender_CSV$Gender)

# lengths are different and rows are mis-matched, BUT participants names shared
print('participant names for height CSV')
height_CSV$Participant[1:20]
print('participant names for weight CSV')
gender_CSV$Participant[1:20]

# the '$' allows you to select an element of interest
# square brackets select the rows of interest
# print('first 20 heights')
# height_CSV$Height[1:20]
# print('first 20 genders')
# gender_CSV$Gender[1:20]
height_CSV$Participant[1]
gender_CSV$Participant[1]
height_CSV$Height[1]
gender_CSV$Gender[1]


# heights need to be converted from FEET'INCHES" format (6'3") ==> single-dicit numeric 
# HOWEVER, the different formats need to be taken into account
# looks like I'll need to create a function to clean this up
# standard height
heights <- height_CSV$Height
heights[1]
# double single quotes instead of double quotes
heights[18]
# blank
heights[89]
# range of height
heights[796]
# triple single quotes
heights[918]
#length(height_CSV$Height)
#length(height_CSV$Participant)
heights[1:10]




# function that takes height (feet'inches") and returns meters
return_meters <- function(height)
{
  inches <- NA
  feet <- NA
  feet <- substring(height,1,1)
  
  second_block <- substring(height,3,4)
  second_block_second_digit <- substring(second_block,2,2)
  second_block_first_digit <- substring(second_block,1,1)
  if (grepl("\\d", feet))
  {
    if (grepl("\\d",second_block_second_digit))
    {
      #print("both digits triggered")
      inches <- second_block
    }
    else if (grepl("\\d",second_block_first_digit))
    {
      #print("first digit triggered")
      inches <- substr(second_block,1,1)
    }
    else 
    {
      #print("something else")
    }
  }
  feet_to_meters <- as.numeric(feet) * 0.3048
  inches_to_meters <- as.numeric(inches) * 0.0254
  meters <- feet_to_meters + inches_to_meters
  return(meters)
}
# print(return_meters("6'4"))


i <- 1
participant_length <- length(height_CSV$Participant)
height_length <- length(height_CSV$Height)
height_list <- list()
while(i <= participant_length)
{
  #print(i)
  current_participant <- as.character(height_CSV$Participant[i])
  current_height <- return_meters(height_CSV$Height[i])
  height_list[[current_participant]] <- current_height
  i <- i + 1
}
height_list[1:10]
# plot
plot(unlist(height_list))
# histogram
hist(unlist(height_list))
length(height_list)
#length(unique(height_list))


# function that returns gender
returngender <- function(current_gender)
{
  if (grepl("Female", current_gender))
  {
    #print("Female")
    gender <- "Female"
  }
  else if (grepl("female", current_gender))
  {
    #print("Female")
    gender <- "Female"
  }
  else if (grepl("woman", current_gender))
  {
    #print("Female")
    gender <- "Female"
  }
  else if (grepl("Male", current_gender))
  {
    #print("Male")
    gender <- "Male"
  }
  else if (grepl("male", current_gender))
  {
    #print("Male")
    gender <- "Male"
  }
  else {
    gender <- NA
  }
  return(gender)
}


# get a list of genders
i <- 1
participant_length <- length(gender_CSV$Participant)
gender_length <- length(gender_CSV$Gender)
gender_list <- list()
while (i <= gender_length)
{
  current_gender <- gender_CSV$Gender[i]
  current_participant <- as.character(gender_CSV$Participant[i])
  gender_list[[current_participant]] <- returngender(current_gender)
  i <- i + 1
}
length(gender_list)
gender_list[1:10]



# calculate the average heights for men and women
#i <- 1
#female_height_sum <- 0
#female_count <- 0
#male_height_sum <- 0
#male_count <- 0

#while (i <= length(height_and_gender$Gender))
#{
#  current_height <- height_and_gender$Height[i]
#  # print(i)
#  if (height_and_gender$Gender[i] == "Female")
#  {
#    #print("Female")
#    female_count <- female_count + 1
#    female_height_sum <- female_height_sum + as.numeric(current_height)
#    #print(current_height)
#  }
#  else if (height_and_gender$Gender[i] == "Male")
#  {
#    #print("Male")
#    male_count <- male_count + 1
#    male_height_sum <- male_height_sum + as.numeric(current_height)
#  }
#  i <- i + 1
#}
#male_height_average <- male_height_sum / male_count
#female_height_average <- female_height_sum / female_count
#print("male height average")
#print(male_height_average)
##print(male_count)
#print("female height average")
#print(female_height_average)
#print(female_count)



