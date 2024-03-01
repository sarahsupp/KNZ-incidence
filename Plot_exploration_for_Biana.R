# Title: EAGER Small Mammal and Bird Traits: Plot Exploration for Biana!
# Author: Maya Parker-Smith
# Date: November 30, 2023

## Load in packages:
library(tidyverse) #This is a huge package that includes ggplot, which is what we'll use for our plots

## Read in the data
smammals_traits_class <- read_csv("Datasets/smammals_traits_class.csv") #You'll use the working directory you're using! 
birds_traits_class <- read_csv("Datasets/birds_traits_class.csv") # And the working directory is basically just where you're storing the downloaded files on your computer 

## Note: there are many more entries (rows) compared to the trait datasets you created. 
## This is because the species are repeated at each watershed (site). So much of the trait data will be repeated. 
## However, we want to keep these repetitions because the classification of each species can change across the different watersheds.




## We'll look at the small mammals first!
### Let's just look at a singular watershed at first to keep things simple 
### I just picked the watershed 1D, which is an area that is burned annually and not grazed by bison

## I'll start with a scatter plot, looking at the how litters per year correlates with classification. Each dot will be a species.
subset(smammals_traits_class, Watershed_name =="1D") %>% #Subsets watershed 1D from "smammals_traits_class"
  # The "%>%" is called a "pipe"; it just feeds the dataset we're using into what our input is
  ggplot(aes(x = classification, y = litters_per_year, color = classification)) + # This establishes the basics of our plot. "aes" is just short for "aesthetics". Within aes(), you state the x and y variables
  geom_point(position = "jitter") # This establishes what kind of plot we are making. 
  # There are many different "geom_...", but "geom_point" iterates that we want to create a "point" plot, or a scatter plot. The "position = "jitter"" makes points not overlap each other.


## Let's look at all the watersheds now
smammals_traits_class %>% 
  ggplot(aes(x = classification, y = litters_per_year, color = classification)) +
  geom_jitter(width = 0.1, height = 0.1) + # "geom_jitter" is just an easier way to creat a "geom_point(position = "jitter")" plot 
  #"width" and "height" controls the spread of the points on the graph
  facet_wrap(.~Watershed_name) # This creates several different graphs, grouped by "Watershed_name". 
  
## In the last plot, it was difficult to distinguish between the categorical variables on the x-axis. 
## So I am going to create the exact same plot, but make it more legible.

smammals_traits_class %>% 
  ggplot(aes(x = classification, y = litters_per_year, color = classification)) +
  geom_jitter(width = 0.1, height = 0.1) +  
  facet_wrap(.~Watershed_name) + 
  theme(axis.text.x = element_text(angle=45, hjust = 1)) # This sets the words on the x-axis at a 45 degree angle, and makes the text sit right at the horizontal plot line.

## What do these plots tell us? Not much! That is okay! 
## I mean I guess it looks like the species that is increasing through time does not have a high litter count per year, 
## and the rest of the classifications contain species that have highly variable litter counts per year.




## Okay lets do a bird plot!

## For this, I'll show you what to do when you want to look at two or more categorical variables (variables with text, not numbers).
## What we basically want is a table that gives us counts of how many species fall into the combinations of the categorical variables.

## I'll pick the categorical variable of "Trophic.Level" to look at. We still want to separate by watershed as well.
birds_class_trophic <- birds_traits_class %>%  
  group_by(Watershed_name, classification, Trophic.Level) %>% # This is grouping together the variables we want to look at
  summarize(count = n()) # This summarizes the groups based on what we want to look at. 
  # "count" is the name of the new column being created with the summary; 
  # the "n" means we just want it to count the number of things that fall into these categories. But we can summarize anything we want, such as "sum" or "mean".

view(birds_class_trophic) # Just wanted to view the newly created data frame


# Now lets do a plot!

# Even though I separated it out by watershed before, I am not going to separate out watershed just so I can show you a different kind of plot.
birds_class_trophic %>% ggplot(aes(x = Trophic.Level, y = count, fill = classification)) + # This time I used "fill" instead of "color" since I want to fill in the boxplots with a color. You can use color instead and see how it changes!
  geom_boxplot() + # Now I am going to create boxplots 
  theme(axis.text.x = element_text(angle=45, hjust = 1)) + # Angling the text again
  labs(x = "Trophic Level", 
       y = "Number of Species Across Watersheds", 
       title = "Trophic Levels and Incidence Classification for Birds") # I wanted to show that you can label the axes differently and make a title for the plot as well

## Alright so this plot sucks and doesn't really tell us anything, but I just wanted to show you something different than a scatter plot!



## If we were just looking at one categorical variable, it's easy to do a bar graph
## I am subsetting and looking at a single watershed so that duplicates aren't counted
## I just chose a random watershed, but the graph would be the same no matter what I chose since I just want to look at a trait.
subset(birds_traits_class, Watershed_name == "N20B") %>% 
  ggplot(aes(x = Trophic.Level)) + 
  geom_bar(stat = "count") # For bar plots without actual numbers, we have to specify that we want it to just count the number of rows for each trophic level category


## If we just wanted to look at a single numerical variable, it is easy to do a histogram
subset(birds_traits_class, Watershed_name == "N20B") %>%
  ggplot(aes(x = Beak.Length_Culmen)) +
  geom_histogram()

## And if we wanted to look at two numerical variables, then we can do a scatter plot and try and fit a regression line
subset(birds_traits_class, Watershed_name == "N20B") %>%
  ggplot(aes(x = Beak.Length_Culmen, y = Beak.Depth)) +
  geom_point() +
  geom_smooth(method = "lm") # This adds a regression line via a linear model ("lm"); I won't get into linear models right now, but we can always talk about stats some other time!


## Sorry I kinda did this all backwards, where I did a bit more complicated stuff in the beginning and ended with super simplistic plots. But I hope it was useful anyway!
## I hope these were some good basics! Feel free to explore with just the trait data at first if that feels most comfortable.
## This is all just to introduce you to plots, so don't worry about trying to actually find correlations or anything. Just explore and have fun!

  
