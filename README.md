# KNZ-incidence
This repository contains data and code for analyses supporting the NSF EAGER Award 2227298.

*Note* This repository is under development (c) 2023-2024.


## Code Authors
Sarah R. Supp, PI, supps@denison.edu; Denison University
Maya J. Parker-Smith, Data Analyst, parkersmithm@denison.edu; Denison University (remote from Lansing, Michigan)

## Collaborators
Nicholas Gotelli, Nicholas.Gotelli@uvm.edu; University of Vermont

## Data
### Folder: "Datasets-EAGER"
This folder contains all the raw and relevant datasets that will be used. Contents include:
- Sub-folder: *"Abiotic"*
  - Sub-sub-folder: "knb-lter-knz.3.14_GISCoverage"
    - Raw data: "ANA011.csv" <- 
  - Sub-sub-folder: "knb-lter-knz.4.18_Precipitation" 
    - Raw data: "APT011.csv" <-
  
- Sub-folder: *"Birds"*
  - Sub-sub-folder: "knb-lter-knz.26.12"
    - Raw data: "CBP011.csv" <- 
    - Meta-data from Konza: "knb-lter-knz.26.12.txt"
    
- Sub-folder: *"Grasshoppers"*
  - Sub-sub-folder: "knb-lter-knz.29.20"
    - Raw data: "CGR021.csv" <-
                "CGR022.csv" <-
                "CGR023.csv" <-
    - Meta-data from Konza: "knb-lter-knz.29.20.txt"
  - File: "Grasshopper_families.xlsx" <- created by Maya P.S. to add information about the families and suborders of the grasshopper species found at Konza. 

- Sub-folder: *"Plants"*
  - Sub-sub-folder: "knb-lter-knz.69.21_SpeciesComposition"
    - Raw data: "PVC021.csv" <- 
    - Meta-data from Konza: "knb-lter-knz.69.21.txt"
  - File: "plant_sp_list.xlsx" <- created by Konza LTER to add information such as family, growth form, and life form to the plant species data
    
- Sub-folder: *"Small_mammals"*
  - Sub-sub-folder: "knb-lter-knz.88.9_FourteenTraplines"
    - Raw data: "CSM011.csv" <- 
                "CSM012.csv" <- 
    - Meta-data from Konza: "knb-lter-knz.88.9.txt"

- Sub-folder: *"Other"*
  - Raw data: "Fire_info_KFH011.csv"
  - File: "WatershedNameMatrix.xlsx" <- created by the data managers at Konza LTER to track the changes in watershed names throughout the years.
  - File: "Watershed Info.xlsx" <- created by Maya P.S. to add information (such as burn-interval and grazing presence) regarding the watersheds used in our project.

The data was downloaded from EDI via the Konza Prairie Long-term Ecological Research (LTER) website on February 17, 2023.

## Code
The main code for data processing and analysis will be developed in .R and .Rmd files.
