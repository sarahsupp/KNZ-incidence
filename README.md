# KNZ-incidence
This repository contains data and code for analyses supporting the NSF EAGER Award 2227298.


*Note* This repository is under development (c) 2023-2024.


## Code Authors
- Sarah R. Supp, PI, supps@denison.edu; Denison University
- Maya J. Parker-Smith, Data Analyst, parkersmithm@denison.edu; Denison University (remote from Lansing, Michigan)

## Collaborators
- Nicholas Gotelli, Nicholas.Gotelli@uvm.edu; University of Vermont
- Nancy Tran, Denison University
- Biana Qiu, Denison University

## Data Source
All data was downloaded via EDI (https://portal.edirepository.org/nis/home.jsp) on February 18, 2023.
Links to each raw dataset will be provided below.

### Code
- *"E0_AllTaxa_RawToClean.Rmd"*
  - This RMarkdown takes the raw datasets from all taxa (located in the "/Datasets/Raw_data"" folders) and prepares them for analysis. The cleaned data is saved in a new folder ("/Datasets/E0_cleaned_data").
  
- *"E1_AllTaxa_Analysis.Rmd"*
  - This RMarkdown takes the cleaned data from all taxa (located in the "/Datasets/E0_cleaned_data") and runs them through the classification function, conducts dissimilarity tests between watersheds, and calculates species richness. The output tables are saved in a new folder ("/Datasets/E1_output_data"). 


### Folder: "Datasets"
This folder contains all the raw and relevant datasets that will be used. Contents include:


- Sub-folder: *"Raw_data"* 

  - Sub-sub-folder: *"Abiotic"*
    - File: *"ANA011.csv"*
      - This file contains information for chemical analysis on rainfall at Konza Prairie from 1982 to 2019.
      - Info included: dates the data was collected, calcium concentration, magnesium conc., potassium conc., sodium conc., NH4 conc., NO3 conc., chlorine conc., SO4 conc., pH in the field and in the lab, conductivity in the field and lab, precipitation sample volume, precipitation amount on the rain gauge, and precipitation amount used by NADP/NTN in calculating weighted-mean concentrations, depositions and precipitation totals.
    - File: *"ANA01_metadata.txt"*
      - A text file including Konza's metadata for the *"ANA011.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.3.13.txt" when downloaded.
    - Link to EDI data repository for the downloaded rainfall analysis data/text files: https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.3.15 
    - File: *"APT011.csv"*
      - This file contains daily rain gauge amounts at 10 rain gauges located at Konza Prairie from 1982 to 2022.
      - Info included: date the data was collected, watershed in which the gauge was located (includes HQ (later HQA & HQB), 20B, 2C, 4B, N4D, N1B, K20A, and N2B), precipitation amount in millimeters. 
    - File: *"APT01_metadata.txt"*
      - A text file including Konza's metadata for the *"APT011.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.4.18.txt" when downloaded.
    - Link to EDI repository for downloaded precipiation (APT01) data/text files: https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-knz&identifier=4
    


  - Sub-sub-folder: *"Birds"*
    - File: *"CBP011.csv"* 
      - This file contains bird species counts from different watersheds at Konza Prairie from 1981 to 2009.
      - Info included: year, month, and day the data was collected, season data was collected, transect number, watershed (includes N4D, N4B, 4A, N1B, 1D, R20A, R1B, 20C, 20B, and N20B), observation number, species name, AOU code (standardized 4-letter species code), common name, perpendicular distance from transect line at which bird was observed, count of species, sex of observed species, residency status.
    - File: *"CBP01_metadata.txt"*
      - A text file including Konza's metadata for the *"CBP011.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.26.12.txt"
    - Link to EDI repository for bird data/text files: https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.26.12
  
  - Sub-sub-folder: *"Grasshoppers"*
    - File: *"CGR021.csv"* 
      - This file contains some environmental variables collected at the grasshopper sampling sites at Konza Prairie from 1982 to 2020.
      - Info included: year, month, and day the data was collected, watershed at which data was collected (includes 2D, 1D, N20B, N1B, SuB, 4F, 20B, N4D, 2C, SpB, 4B, 4A, N1A, and N20A), soil type, replication site id, time data was recorded, wind speed, air temperature, relative humidity at ground level, and percent cloud cover.
    - File: *"CGR022.csv"*
      - This file contains the grasshopper species counts from different watersheds from 1982 to 2020.
      - Info included: year, month, and day the data was collected, watershed at which data was collected (includes 2D, 1D, N20B, N1B, SuB, 4F, 20B, N4D, 2C, SpB, 4B, 4A, N1A, and N20A), soil type, replication site id, species code, species name, number of grasshoppers caught at each sweep (10 sweeps are done), total number of grasshoppers caught in those 10 sweeps.
    - File: *"CGR023.csv"*
      - This file contains the life cycle stage (instar level or adult) and sex for the grasshoppers collected at different watersheds at Konza Prairie from 1982 to 2020.
      - Info included: year, month, and day the data was collected, watershed at which data was collected (includes 2D, 1D, N20B, N1B, SuB, 4F, 20B, N4D, 2C, SpB, 4B, 4A, N1A, and N20A), soil type, replication site id, species code, species name, number of grasshoppers in first, second/ third, fourth, and fifth instar stage, sex of grasshoppers collected, total number of grasshoppers collected.
    - File: *"CGR02_metadata.txt"*
      - A text file including Konza's metadata for the *"CGR021.csv"*, *"CGR022.csv"*, and *"CGR023.csv"* datasets; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.29.20.txt". 
    - Link to EDI repository for all downloaded grasshopper (CGR02) data/text files: https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.29.22
    - File: *"Grasshopper_families.xlsx"* 
      - Created by Maya P.S. to add information about the families and suborders of the grasshopper species found at Konza. 


  - Sub-sub-folder: *"Plants"*
    - File: *"PVC021.csv"*
      - This file contains the plant canopy cover values for transects and plots located at watersheds at Konza Prairie from 1983 to 2022.
      - Info included: year, month, and day data was collected, watershed at which data was collected (includes FA, SuB, N4A, R1A, 2D, WB, N20B, N1A, 1D, R1B, SpA, SpB, WA, 20B, 4A, 4F, SuA, N1B, N20A, N4D), soil type, transect, plot, species code, genus, species, cover value (values are from 1-7; where 1 is 0-1% cover, 2 is 1-5% cover, 3 is 5-25% cover, 4 is 25-50% cover, 5 is 50-75% cover, 6 is 75-95% cover, and 7 is 95-100% cover).
    - File: *"PVC02_metadata.txt"*
      - A text file including Konza's metadata for the *"PVC021.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.69.21.txt".
    - Link to EDI repository for all downloaded plant (PVC02) data/text files:  https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.69.22
    - File: *"plant_sp_list.xlsx"* 
      - Created by Konza LTER to add information such as family, growth form, and life form to the plant species data.
    - File: *"Plant-Traits.xlsx"*
      - Combined the species we are using in our analysis with the information in the "plant_sp_list.xlsx"


  - Sub-sub-folder: *"Small_mammals"*
    - File: *"CSM011.csv"*
      - This file contains the seasonal summary numbers of small mammal species collected at Konza Prairie from 1981 to 2013.
      - Info included: year and season the data was collected, watershed (includes 4B, 4F, N4D, N20B, 1D, 20B, and N1B) and transect line in which data was collected, the count of each species.
    - File: *"CSM012.csv"*
      - This file contains individual trait records for the small mammals collected at Konza Praire from 1981 to 2013.
      - Info included: year, season, month, and day the data was collected, the trap day, watershed at which data was collected (includes ), transect line, the numbered tag on the rebar where the trap was placed, species, sex, age, pregnancy status, scrotal condition, mass of small mammal, life status in the trap, postion of toe clip, hair clip, right ear tag, left ear tag, tail length, amd hind foot length.
    - File: *"CSM01_metadata.txt"*
      - A text file including Konza's metadata for the *"CSM011.csv"* and *"CSM012.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.88.9.txt".
    - Link to EDI repository for all downloaded small mammal (CSM01) data/text files: https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.88.9



- Sub-folder: *"Other"*
  - File: *"Fire_info_KFH011.csv"*
    - Fire information for each watershed at Konza.
    - Info included: watershed, previous name for watershed, hectares, acres, date of fire, type of fire, year of fire
  - File: *"WatershedNameMatrix.xlsx"*
    - Created by the data managers at Konza LTER to track the changes in watershed names throughout the years.
  - File: *"Watershed Info.xlsx"*
    - Created by Maya P.S. to add information (such as burn-interval and grazing presence) regarding the watersheds used in our project.




- Sub-folder: *"E0_cleaned_data"*

  - File: *"E0_birds.csv"*
    - The cleaned data output after running the raw bird data file (*"CBP011.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 1992-2009.
  - File: *"E0_grasshoppers.csv"*
    - The cleaned data output after running the raw grasshopper data file (*"CGR022.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 2002-2020.
  - File: *"E0_plants.csv"*
    - The cleaned data output after running the raw plant cover data file (*"PVC021.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 1992-2022.
  - File: *"E0_smammals.csv"*
    - The cleaned data output after running the raw small mammal data file (*"CSM011.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 1992-2013.
    


    
- Sub-folder: *E1_output_data*

  - Sub-sub-folder: *"E1_birds"*
    - File: *"E1_birds_classified.csv"*
      - The output after running a presence/absence matrix of the bird species at each watershed & year through our classification function ("getTrends3.0") in the *"E1_AllTaxa_Analysis.Rmd"* code file.
      - Info included: AOU_code & species (are the same in this dataset), watershed, number of years for the time series (18 years), number of years each species at each watershed was present, percent of years present, the presence/absence information for each year of the time series, chi-square p-value, percent present in the first half of the time series, percent present in the last half of the time series, runstest p-value, number of transitions from present to absent (and vice versa), trend (increasing, decreasing, neither), and actual classification (No-change_absent, No-change_present, Random, Recurrent, Increasing, or Decreasing).
    - File: *"E1_birds_dissimilarity.csv"*
      - Watershed dissimilarity values for the bird dataset
      - Info included: two columns of watersheds that are being compared, Jaccard's dissimilarity for the first year of the dataset, Jaccard's dissimilarity for the last year of the dataset, Jaccard's dissimilarity for the entire dataset, and Bray-Curtis dissimilarity for the entire dataset
      - *I NEED TO CHANGE THIS TO INCLUDE WATERSHEDS I PREVIOUSLY CUT OUT, AND CREATE ANOTHER ONE THAT COMPARES THE JACCARD'S DISSIMILARITY FOR FIRST AND LAST YEARS OF THE DATASET WITHIN A WATERSHED, NOT BETWEEN THEM*
    - File: *"E1_birds_richness"* 
      - Species richness information across years and watersheds for the bird dataset. 
      - Info included: watershed, year, species richness for that year, slope of species richness for watershed, p-value from the linear model looking at richness through years for each watershed, and the r-squared value from the year~richness by watershed linear model.
    
    
  - Sub-sub-folder: *"E1_grasshoppers"*
    - File: *"E1_grasshoppers_classified.csv"*
      - The output after running a presence/absence matrix of the grasshopper species at each watershed & year through our classification function ("getTrends3.0") in the *"E1_AllTaxa_Analysis.Rmd"* code file.
      - Info included: species name, watershed name, number of years for the time series (19 years), number of years each species at each watershed was present, percent of years present, the presence/absence information for each year of the time series, chi-square p-value, percent present in the first half of the time series, percent present in the last half of the time series, runstest p-value, number of transitions from present to absent (and vice versa), trend (increasing, decreasing, or neither), and actual classification (No-change_absent, No-change_present, Random, Recurrent, Increasing, or Decreasing).
    - File: *"E1_grasshoppers_dissimilarity.csv"*
      - I NEED TO CHANGE THIS
    - File: *"E1_grasshoppers_richness"*
      - Species richness information across years and watersheds for the grasshopper dataset.
      - Info included: watershed, year, species richness for that year, slope of species richness for watershed, p-value from the linear model looking at richness through years for each watershed, and the r-squared value from the year~richness by watershed linear model.
      
      
  - Sub-sub-folder: *"E1_plants"*
    - File: *"E1_plants_classified.csv"*
      - The output after running a presence/absence matrix of the plant species data at each watershed & year through our classification function (getTrends3.0) in the *"E1_AllTaxa_Analysis.Rmd"* code file.
      - Info included: species name, watershed name, number of years for the time series (31 years), number of years each species at each watershed was present, percent of years present, the presence/absence information for each year of the time series, chi-square p-value, percent present in the first half of the timeseries, percent present in the last half of the time series, runstest p-value, number of transitions from present to absent (and vice versa), trend (increasing, decreasing, or neither), and actual classification (No-change_absent, No-change_present, Random, Recurrent, Increasing, or Decreasing).
    - File: *"E1_plants_dissimilarity.csv"*
      - I NEED TO CHANGE THIS
    - File: *"E1_plants_richness.csv"*
      - Species richness information across years and watersheds for the plant cover dataset.
      - Info included: watershed, year, species richness for that year, slope of species richness for watershed, p-value rom the linear model looking at richness through years for each watershed, and the r-squared value from the year~richness by watershed linear model.
      
  - Sub-sub-folder: *"E1_smammals"*
    - File: *"E1_smammals_classified.csv"*
      - The output after running a presence/absence matrix of the small mammals species data at each watershed & year through our classification function (getTrends3.0) in the *"E1_AllTaxa_Analysis.Rmd"* code file.
      - Info included: species name, watershed name, common name for species, number of years for the time series (22 years), number of years each species at each watershed was present, percent of years present, the presence/absence information for each year of the time series, chi-square p-value, percent present in the first half of the timeseries, percent present in the last half of the time series, runstest p-value, number of transitions from present to absent (and vice versa), trend (increasing, decreasing, or neither), and actual classification (No-change_absent, No-change_present, Random, Recurrent, Increasing, or Decreasing).
    - File: *"E1_smammals_dissimilarity.csv"*
      - I NEED TO CHANGE THIS
    - File: *"E1_smammals_richness.csv"*
      - Species richness information across years and watersheds for the small mammals dataset.
      - Info included: watershed, year, species richness for that year, slope of species richness for watershed, p-value rom the linear model looking at richness through years for each watershed, and the r-squared value from the year~richness by watershed linear model.
      
    
  
      
    
      
    
      
  

## Code
The main code for data processing and analysis will be developed in .R and .Rmd files.
