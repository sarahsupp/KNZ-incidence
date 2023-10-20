# Description ----
# This function uses the beta distribution to decide whether a
# species should be classified based on its incidence as "common", 
# "rare", or "intermediate".
# For use in collaborative project with Sarah Supp
# on species incidences in Konza prairie data
# 
#  08 Aug 2023
# Nicholas J. Gotelli
# Department of Biology, University of Vermont

# --------------------------------------
# FUNCTION bin_beta
# required packages: none
# description: classifies species occurrence into one of 3 
# incidence classes based on commonness and rarity
# inputs: 
  # low_cut = lower bound for relative frequency of rare class
  # high_cut = upper bound for relative frequency of common class
  # sample_n = number of samples (integer)
  # occurrences = number of species occurrences (integer range: 0,sample_n)
  # criteria = "strict" or "relaxed" 
  # ("strict" means the 90% interval for the beta distribution is beyond the cutpoint;
  # "relaxed" means the expectation from the beta distribution (50% probability mass) is beyond the cutpoint)
# 
# outputs: 
  # prob_low = estimated lower bound (< 5%) for 90% confidence interval of 
  # probability of frequency of occurrence from beta distribution, given number   
  # of samples and number of occurrences

  # prob_high = estimated upper bound (> 95%) for 90% confidence interval of   
  # probability of frequency of occurrence from beta distribution, given number 
  # of samples and number of occurrences


  # prob_exp = estimated center of probability mass (50%; = expectation of beta 
  # distribution), given number of samples and number of occurrences

  # $bin = classification of the species (rare,intermediate, common) 

########################################
bin_beta <- function(p=NULL) {

# function body
if (is.null(p)) {
   p <- list(
      low_cut = 0.20,
      high_cut = 0.80,
      sample_n = 18,
      occurrences = 4,
      criteria = "relaxed")
  }
 
  
 dist <- qbeta(p=c(p$low_cut,0.5,p$high_cut),
               shape1=p$occurrences + 1,
               shape2=p$sample_n - p$occurrences + 1)
 names(dist) <- c("prob_low","prob_exp","prob_high")
 
 if(p$criteria=="strict") {
   if(dist["prob_high"] < p$low_cut) bin <- "rare species" else {
     if (dist["prob_low"] > p$high_cut) bin <- "common species" else {
       bin <- "intermediate species"}
   } 
 }
 
 if(p$criteria=="relaxed") {
   if(dist["prob_exp"] < p$low_cut) bin <- "rare species" else {
     if (dist["prob_exp"] > p$high_cut) bin <- "common species" else {
       bin <- "intermediate species"}
   } 
 }
 
cat("input parameters ----","\n")
print(p)
return(list(dist=dist,bin=bin))

} # end of bin_beta function
# --------------------------------------
cat("using built in defaults ----","\n")
print(bin_beta()) # test with defaults

# Examples. Suppose we have a species that occurs in only 1 of the 18 samples you have from Konza. It seems reasonable that this should be classified as a "rare" species. We will use 20% and 80% as the arbitrary cutpoints for rare,intermediate, and common species. We will try the strict and relaxed criteria for the test:

pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 1,
  criteria = "strict")

print(bin_beta(p=pars))

pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 1,
  criteria = "relaxed")

print(bin_beta(p=pars))

# So, the relaxed criterion classifies this species as "rare", but the strict criterion does not. Thus, given the sampling uncertainty in estimating the frequency of occurrence of a species, the majority of the probability mass in falls below the cutpoint of 10% when there is only a single occurrence. Since we cannot even use our runs test with only 1 occurrence, this seems sensible.

# Example 2. Using the relaxed criteria and cutpoints of 10% and 90%, let's try some other occurrence frequencies at both the high and low end:

# first, some other rare species tests:
pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 2,
  criteria = "relaxed")

print(bin_beta(p=pars))

pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 3,
  criteria = "relaxed")

print(bin_beta(p=pars))

pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 4,
  criteria = "relaxed")

print(bin_beta(p=pars))


# common species should give symmetric results for frequent occurrences:
print(bin_beta(p=pars))

pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 18,
  criteria = "relaxed")

print("input parameters ----")
print(bin_beta(p=pars))

pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 17,
  criteria = "relaxed")

print(bin_beta(p=pars))


pars <- list(
  low_cut = 0.10,
  high_cut = 0.90,
  sample_n = 18,
  occurrences = 16,
  criteria = "relaxed")

print(bin_beta(p=pars))

# Conclusions. Of course the cutpoints are arbitrary, and to a certain extent, so are the criteria we use for deciding how much of the probability mass falls in the tails of the distribution once those cutpoints are established. Using our "relaxed" criteria, and cutpoints of 0.10 and 0.90 we have the following results for 18 samples and a given number of species occurrences

# rare species: 0 or 1 occurrences
# intermediate species: 2 - 16 occurrences
# common species: 17 or 18 occurrences

# This is not especially useful, given we can't even conduct the full battery of statistical tests with only a single occurrence. If we use more liberal cutpoints of 0.20 and 0.80 (analyses not shown), we get:

# rare species: 0 to 3 occurrences
# intermediate species: 4 - 14 occurrences
# common species: 15 to 18 occurrences


# Under this classification, you could argue that anything with 15 or more occurrences out of 18 should be classified in our scheme as "always present" (since the estimated probability of occurrence is ~ > 0.80).

# anything with 3 or fewer occurrences we could consider excluding because the species is so rare.

# In either case, we should try analyzing the species in these three groups separately and see how it affects the classifications that result.
