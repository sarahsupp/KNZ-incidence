# Contains functions for the classification and analysis for Supp et al. NSF funded EAGER project
# Intended Data: Konza Prairie LTER; Small mammals, Grasshopper, Birds, Plants
# Code authors: Sarah R. Supp, Maya Parker-Smith
#   Modified from original code in Gotelli et al. 2021 for incidence classification
# Corresponding author: Sarah R. Supp; supps@denison.edu

# Requirements
require(tidyverse)
require(vegan)

#---------------------------------------------------------------------------------
### getTrends3.0
# The "getTrends3.0" function will classify species within each taxa, from each watershed, into distinct categories, using only presence-absence data. This version of the function has the stipulations for 'No_change-present' >=90% years present, 'Rare' present but for only <=10% of years, 'No_change-absent' 0 years present, and for recurrent category requires at least 2 blocks of time when it is present. I also renamed some variables for clarity. The categories include: 
#   
#   - **"No_change-absent"** <- though species was detected at other surrounding watersheds, it was absent at specified watershed for the duration of the time series.
#   - **"Rare"** <- Species was present at specified watershed for between 1-10% of years in the duration of the time series.
#   - **"No_change-present"** <- species at watershed is present in >=90% of years in which data was collected.
#   - **"Increasing"** <- the presence of the species increases throughout the duration of the study (it is absent during the beginning of the study, but appears towards the end of the study)
#   - **"Decreasing"** <- the presence of the species decreases throughout the duration of the study (it is present during the beginning of the study, but then disappears towards the end of the study)
#   - **"Recurrent"** <- species is detected in consecutive years and is followed by the absence of the species for a period of time, in a distinct pattern. Species must at least two instances of presences followed by absences. 
#   - **"Random"** <- species is detected sporadically for the duration of the study at watershed

getTrends3.0 <- function(x) {
  #input (x) is a single row of a matrix where the species are rows and the columns are each year with 1/0 values (1=present, 0=absent). 
  #So you need to iterate each row separately to get the results
  # Output is a list with 10 items, that represents the classification results for a single species
  
  #create an object the same length as x that defines early vs late years
  time <- rep("late", length(x))
  time[1:(round(length(x)/2))] <- "early"
  
  #NOTE: I ended up placing the z_x table back at the top of the function because I was having a hard time getting it to run without it.
  # makes a table that tells you how many 0s and 1s are in the early and the late halves of the time series
  z_x <- table(x,time)
  
  #find the time-series length (number of years)
  tslen <- length(x)
  
  # counts the number of years the species was present
  tssum <- sum(x)
  
  # calculate proportion of years species was present
  tsprop <- tssum/tslen
  
  # create an empty vector to store results in for the next for loop
  l <- c()
  
  # identifies when a change from a 0 to a 1 or vice versa happens
  for(k in 1:(tslen-1)) {
    j <- x[k+1] - x[k]
    l <- c(l, j)
    v <- sum(abs(l))
  }
  
  # If all the values are 0, it is always absent
  if (tsprop == 0) {
    p_val <- NA
    f_early <- NA
    f_late <- NA
    runsTestPV <- NA
    trend <- NA
    trendPlus <- NA
    cat <- "No_change-absent"
  } else if ((tsprop > 0) & (tsprop <= 0.10)) {
    # if most of the values are 1 (<=10% of all years), it is "rare"
    p_val <- NA
    f_early <- NA
    f_late <- NA
    runsTestPV <- NA
    trend <- NA
    trendPlus <- NA
    cat <- "Rare"
  } else if (tsprop >= 0.90) {
    # if most of the values are 1 (>=90% of all years), it is "no change" present
    p_val <- NA
    f_early <- NA
    f_late <- NA
    runsTestPV <- NA
    trend <- NA
    trendPlus <- NA
    cat <- "No_change-present"
  } else {
    #If the time series contains changes, then we do a chi-sq test to detect directed change
    #adds rownames to the z_x table
    rownames(z_x) <- c("absent","present")
    
    # get p value for the chi-squared test
    p_val <- chisq.test(z_x)$p.val
    
    # get early and late fractions
    # for each the early and the late parts of the time series:
    #    the number of years it was present divided by the number of years
    f_early <- z_x["present","early"] / sum(z_x[,1]) 
    f_late <- z_x["present","late"] / sum(z_x[,2])
    
    if((f_early > f_late) & (p_val <= 0.05)) {
      trend <- -1
      cat = "Decreasing"
      runsTestPV <- NA
    } 
    else if((f_early < f_late) & (p_val <= 0.05)) {
      trend <- 1
      cat = "Increasing"
      runsTestPV <- NA
    } 
    else {
      # Chi-squared test not significant
      trend <- 0
      
      #conduct a runs test on the time-series
      runsPV <- tseries::runs.test(as.factor(x), alternative = "less")
      runsTestPV <- runsPV$p.value
      if(is.nan(runsTestPV)) {
        runsTestPV <- 2 }
      # if Chi-sq test insignif. and the runs test was significant AND it was present in at least TWO blocks of time
      if((p_val > 0.05) & (runsTestPV < 0.05) & (v > 2)) {
        cat="Recurrent"
      } 
      else if(((p_val > 0.05) & (runsTestPV > 0.05))|((runsTestPV < 0.05) & (v <= 2))) {
        cat="Random"
      }
    } #end else for ns chisq
  }
  
  # for each species, record the summary statistics
  statSumm <- tibble("numyears" = tslen, 
                     "numpresent" = tssum,
                     "percyears" = tsprop,
                     "chiPval" = p_val, 
                     "chi_fearly" = f_early, 
                     "chi_flate" = f_late, 
                     "runsPval" = runsTestPV, 
                     "numtransitions" = v, 
                     "trend" = trend, 
                     "classification" = as.factor(cat))
  return(statSumm)
}


#---------------------------------------------------------------------------------
### label_abundance
# First, we will need a new function that can convert the abundance values into:
#     - below average (0)
#     - equal to or above average (1) 
# 
# according to each population time series mean. 
# This function also needs to label any populations that have a large number of absences, 
# and should be considered as rare or always absent, 
# so those can be labeled in the abundance trends function later.
# Define a custom function to label each time step according to its abundance trend.


label_abundance <- function(x) {
  # this function acts on each row of a species count matrix (x)
  # 0 = below average abundance
  # 1 = equal to or greater than average abundance
  # label is added to indicate classification if it is absent or too rare
  
  # Create a new vector with labels
  convert_x <- numeric(length(x))
  # Calculate average of population time series
  average = mean(x)
  # Calculate the proportion of zeros in the time series (how many years absent?)
  tsabs <- round(mean(x==0), 2)
  #iterate and replace values with abundance conversion
  for (i in 1:length(x)) {
    if (x[i] >= average) {
      convert_x[i] <- 1
    } else {
      convert_x[i] <- 0
    }
  }
  convert_x <- append(convert_x, tsabs)
  return(convert_x)
}

#---------------------------------------------------------------------------------
### getAbundTrends
# The "getAbundTrends" function will classify species within each taxa, from each watershed, into distinct categories, informed by the abundance (count or percent cover) data. This modification of the incidence classification makes a few key changes, but is largely similar. First, using the average abundance of the population time series (i.e., from the sequence of counts), each time step is converted into 0 (less than average) or 1 (equal to or greater than average). At this step, we will also record the percent of years species was present, so we can avoid over-interpreting a lot of zeros. The previous rule for recurrent classification is relaxed here as it is not needed. The categories include: 
#   
#   - **"No_change-absent"** <- though species was detected at other surrounding watersheds, it was absent at specified watershed for the duration of the time series (# years present = 0).
#     - **"Rare"** <- Species was present at specified watershed for between 1-10% of years in the duration of the time series. Abundance will not be classified.
#     - **"No_change-increasing"** <- species at watershed is above average abundance in >=90% of years in which data was collected. #CHECKME: is this even possible?
#     - **"No_change-decreasing"** <- species at watershed is below average abundance in >=90% of years in which data was collected. #CHECKME: is this even possible?
#     - **"Increasing"** <- the second half of the study contains most of the above average records of the species (it is mostly below average during the beginning of the study)
#     - **"Decreasing"** <- the second half of the study contains most of the below average records of the species (it is mostly above average during the beginning of the study)
#     - **"Recurrent"** <- species abundance fluctuations appear to be clumped into consecutive years, with distinct periods of above average and below average abundances.
#     - **"Random"** <- species abundance fluctuates in an unpredictable pattern for the duration of the study.

# Define a custom function to label each time step according to its abundance trend.
# 0 = below average abundance
# 1 = equal to or greater than average abundance
# label is added to indicate classification if it is absent or too rare
# this function acts on each row of a species count matrix

label_abundance <- function(x) {
  # Create a new vector with labels
  convert_x <- numeric(length(x))
  # Calculate average of population time series
  average = mean(x)
  # Calculate the proportion of zeros in the time series (how many years absent?)
  tsabs <- round(mean(x==0), 2)
  #iterate and replace values with abundance conversion
  for (i in 1:length(x)) {
    if (x[i] >= average) {
      convert_x[i] <- 1
    } else {
      convert_x[i] <- 0
    }
  }
  convert_x <- append(convert_x, tsabs)
  return(convert_x)
}    

#---------------------------------------------------------------------------------
### extract model results functions
# We also need functions to extract information from linear models. 
# These will be used later for analyzing species richness across each watershed.

##'fit_model' takes the data frame and runs a linear model for richness ('value') by year ('n').
fit_model <- function(df) lm(value ~ n, data = df)

##'get_slope' takes the output from the models ('mod') and extracts the slope ('estimate')
get_slope <- function(mod) tidy(mod)$estimate[2]

##'get_p_value' takes the output from the models ('mod') and extracts the p.value
get_p_value <- function(mod) tidy(mod)$p.value[2]

##'get_rsq' takes the output from the models ('mod') and extracts the r-squared value
get_rsq <- function(mod) summary(mod)$r.squared

#---------------------------------------------------------------------------------
### Jaccard Dissimilarity functions
# this is repeated across all four taxa to collect results

compute_dissimilarity <- function(df_counts, method = "jaccard", baseline_year) {
  # input a dataframe where the first column is watershed_year and
  #   all subsequent columns are species names. Values are the count (abundance)
  # method can be specified as "jaccard" or "bray" for dissimiliarity calculation
  # if baseline_year is specified, will calculate dissimiliarity to all subsequent years
  # if baseline_year is NULL, will calculate dissimilarity across watersheds, within the same year
  
  # Prepare matrix
  diss_input <- df_counts[, -1]  # drop Watershed_year
  diss_input <- diss_input %>% mutate_if(is.character, as.numeric)
  
  # Optional standardization (Bray requires total, Jaccard uses presence-absence)
  if (method == "jaccard") {
    diss_input <- decostand(diss_input, method = "pa")
  } else if (method == "bray") {
    diss_input <- decostand(diss_input, method = "total")
  } else {
    stop("Unsupported method. Use 'jaccard' or 'bray'")
  }
  
  # Compute dissimilarity
  diss_mat <- vegdist(diss_input, method = method)
  diss_mat <- as.matrix(diss_mat)
  rownames(diss_mat) <- colnames(diss_mat) <- df_counts$Watershed_year
  
  # Melt into long format
  df_long <- as.data.frame.table(diss_mat) %>%
    separate(Var1, c("Watershed1", "Year1"), sep = "_") %>%
    separate(Var2, c("Watershed2", "Year2"), sep = "_") %>%
    mutate(across(c(Year1, Year2), as.numeric)) %>%
    rename(diss = Freq)
  
  # Compare to baseline year, within watersheds
  df_baseline <- df_long %>%
    filter(Year1 == baseline_year, Watershed1 == Watershed2)
  
  # Compare watersheds, within years, removing redundancy 
  df_watershed <- df_long %>%
    filter(Year1 == Year2) %>%
    rowwise() %>%
    mutate(
      Watershed_min = min(Watershed1, Watershed2),
      Watershed_max = max(Watershed1, Watershed2)
    ) %>%
    ungroup() %>%
    distinct(Year1, Watershed_min, Watershed_max, .keep_all = TRUE) %>%
    dplyr::select(Watershed1 = Watershed_min, Year1,
           Watershed2 = Watershed_max, Year2, diss)
  
  # Rename columns to identify metric
  colnames(df_baseline)[ncol(df_baseline)] <- paste0(method, "_diss")
  colnames(df_watershed)[ncol(df_watershed)] <- paste0(method, "_diss")
  
  list(baseline = df_baseline, watershed = df_watershed)
  }
 