[![NSF-0000000](https://img.shields.io/badge/NSF-2227298-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=2227298)
 [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
 
# KNZ-incidence
This repository contains data and code for analyses supporting the NSF EAGER Award 2227298.This work investigates a novel classification methodology for sequential species presence and absence (incidence) patterns and uses long-term control-experiment comparisons at the [Konza Prairie Long Term Ecological Research site](https://lternet.edu/site/konza-prairie-lter/) with 15 or more years of data to test the level of ecological disturbance needed for species to "switch" their incidence. The work compares two watershed treatments representing pulse (fire) and press (grazing) disturbance types, and will compare the findings across plant and animal (insect, bird, small mammal) taxonomic groups. The research will generate estimates of changes in population abundance, the proportion of years present, the incidence classification and an abundance-based classification, for each species population and compare among the disturbance treatment levels.


*Note* This repository is under development (c) 2023-2025.


## Code Authors
- Sarah R. Supp, PI, supps@denison.edu; Denison University
- Maya J. Parker-Smith, Data Analyst, parkersmithm@denison.edu; Denison University (now at UNC Greensboro)
- Nancy Tran, Denison University
- Biana Qiu, Denison University

## Collaborators
- Nicholas Gotelli, Nicholas.Gotelli@uvm.edu; University of Vermont

---
## Getting Started
If you want to use or modify the code developed in this repository, please read the following steps to help with your setup and implementation.

### Prerequisites
This software requires Program R version 4.3 or greater. R can be downloaded for free <https://www.r-project.org/>.

Several specialized packages are used in the software and will need to be installed or updated.

---
## Method

This paper uses a novel incidence classification method (presence vs absence). We also convert the method to be used with abundance information (above vs below average abundance). The original method was published in [Gotelli et al. 2021](https://onlinelibrary.wiley.com/doi/full/10.1111/gcb.15947). Here, we update the method and test it using long-term ecological experiment data. 

Using the incidence classificaiton method, a population may fall into one of seven classes:
| Type | Classification and description | consistency | contingency test | runs test |
| ---- | ---- |  ---- | ---- | ---- |
| No change |  **Core**: Species is consistently present throughout the time series | present >=90% years | -- | -- |
| No change | **Absent**: Species is consistently absent throughout the time series, but is in the species pool | absent in all years | -- | -- |
| No change | **Rare**: Species is infrequent throughout time series and cannot be classified | Present <= 10% years | -- | -- |
| Directed change | **Increasing**: Species incidence significantly greater in later half of the time series | -- | p < 0.05 (+) | -- |
| Directed change | **Decreasing**: Species incidence significantly greater in the earlier half of the time series | -- | p < 0.05 (-) | -- |
| Undirected change | **Recurrent**: Species has repeated colonization extinction events where presence is grouped in at least two blocks of time | -- | NS | p < 0.05 |
| Undirected change | **Random**: Species presences are indistinguishable from equiprobable reshuffling | -- | NS | NS |





---
## Data
This project requires data from the Konza Prairie LTER (KNZ) site. Data are freely available to request online through the [Environmental Data Initiative](https://edirepository.org/). All data was downloaded via EDI (https://portal.edirepository.org/nis/home.jsp) on February 18, 2023. We provide here our queried versions of the raw data, and our processed data, for replication purposes.

Data can be found in the directory `Datasets`. Subfolders for `Raw_data`, `E0_cleaned_data`, and `E1_output_data` organize the data at different levels of processing and results.

### Raw data
| directory and datasets | description| data wrangling |
| ------------- | ------------- | ------------- |
| Raw_data | contains raw data and metadata separated by taxa, downloaded from EDI | raw data |
| | *Abiotic/ANA011.csv* - contains information for chemical analysis on rainfall at Konza Prairie from 1982 to 2019. Info included: dates the data was collected, calcium concentration, magnesium conc., potassium conc., sodium conc., NH4 conc., NO3 conc., chlorine conc., SO4 conc., pH in the field and in the lab, conductivity in the field and lab, precipitation sample volume, precipitation amount on the rain gauge, and precipitation amount used by NADP/NTN in calculating weighted-mean concentrations, depositions and precipitation totals. | raw data |
| | *Abiotic/ANA01_metadata.txt* - Konza's metadata for the *"ANA011.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.3.13.txt" when downloaded. [Link to EDI data repository for the downloaded rainfall analysis data/text files](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.3.15) | raw data |
| | *Abiotic/APT011.csv* - This file contains daily rain gauge amounts at 10 rain gauges located at Konza Prairie from 1982 to 2022. Info included: date the data was collected, watershed in which the gauge was located (includes HQ (later HQA & HQB), 20B, 2C, 4B, N4D, N1B, K20A, and N2B), precipitation amount in millimeters | raw data |
| | *Abiotic/APT01_metadata.txt* - Konza's metadata for the *"APT011.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.4.18.txt" when downloaded. [Link to EDI repository for downloaded precipiation (APT01) data/text files](https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-knz&identifier=4) | raw data |
| | *Birds/CBP011.csv* - bird species counts from different watersheds at Konza Prairie from 1981 to 2009. Info included: year, month, and day the data was collected, season data was collected, transect number, watershed (includes N4D, N4B, 4A, N1B, 1D, R20A, R1B, 20C, 20B, and N20B), observation number, species name, AOU code (standardized 4-letter species code), common name, perpendicular distance from transect line at which bird was observed, count of species, sex of observed species, residency status. | raw data |
| | *Birds/CBP01_metadata.txt* - Konza's metadata for the *CBP011.csv* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.26.12.txt". [Link to EDI repository for bird data/text files](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.26.12)
| | *Grasshoppers/CGR021.csv* - environmental variables collected at the grasshopper sampling sites at Konza Prairie from 1982 to 2020. Info included: year, month, and day the data was collected, watershed at which data was collected (includes 2D, 1D, N20B, N1B, SuB, 4F, 20B, N4D, 2C, SpB, 4B, 4A, N1A, and N20A), soil type, replication site id, time data was recorded, wind speed, air temperature, relative humidity at ground level, and percent cloud cover. | raw data |
| | *Grasshoppers/CGR022.csv* - species counts from watersheds, 1982-2020. Info included: year, month, and day the data was collected, watershed at which data was collected (includes 2D, 1D, N20B, N1B, SuB, 4F, 20B, N4D, 2C, SpB, 4B, 4A, N1A, and N20A), soil type, replication site id, species code, species name, number of grasshoppers caught at each sweep (10 sweeps are done), total number of grasshoppers caught in those 10 sweeps. | raw data |
| | *Grasshoppers/CGR023.csv* - life cycle stage (instar level or adult) and sex for the grasshoppers collected at different watersheds at Konza Prairie from 1982 to 2020. Info included: year, month, and day the data was collected, watershed at which data was collected (includes 2D, 1D, N20B, N1B, SuB, 4F, 20B, N4D, 2C, SpB, 4B, 4A, N1A, and N20A), soil type, replication site id, species code, species name, number of grasshoppers in first, second/ third, fourth, and fifth instar stage, sex of grasshoppers collected, total number of grasshoppers collected. | raw data |
| | *Grasshoppers/CGR02_metadata.txt* - Konza's metadata for the *"CGR021.csv"*, *"CGR022.csv"*, and *"CGR023.csv"* datasets; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.29.20.txt". [Link to EDI repository for all downloaded grasshopper (CGR02) data/text files](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.29.22) | raw data |
| | *Grasshopper/Grasshopper_families.xlsx* - Created by Maya P.S. to add information about the families and suborders of the grasshopper species found at Konza. | raw data |
| | *Plants/PVC021.csv* - plant canopy cover values for transects and plots located at watersheds at Konza Prairie from 1983 to 2022. Info included: year, month, and day data was collected, watershed at which data was collected (includes FA, SuB, N4A, R1A, 2D, WB, N20B, N1A, 1D, R1B, SpA, SpB, WA, 20B, 4A, 4F, SuA, N1B, N20A, N4D), soil type, transect, plot, species code, genus, species, cover value (values are from 1-7; where 1 is 0-1% cover, 2 is 1-5% cover, 3 is 5-25% cover, 4 is 25-50% cover, 5 is 50-75% cover, 6 is 75-95% cover, and 7 is 95-100% cover). | raw data |
| | *Plants/PVC02_metadata.txt* - Konza's metadata for the *"PVC021.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.69.21.txt". [Link to EDI repository for all downloaded plant (PVC02) data/text files](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.69.22) | raw data |
| | *Plants/plant_sp_list.xlsx* - Created by Konza LTER to add information such as family, growth form, and life form to the plant species data. | raw data |
| | *Plants/Plant-Traits.xlsx* -Combined the species we are using in our analysis with the information in the "plant_sp_list.xlsx | aggregated data |
| | *Small_mammals/CSM011.csv* - seasonal summary numbers of small mammal species collected at Konza Prairie from 1981 to 2013. Info included: year and season the data was collected, watershed (includes 4B, 4F, N4D, N20B, 1D, 20B, and N1B) and transect line in which data was collected, the count of each species. | raw data |
| | *Small_mammals/CSM012.csv* - individual trait records for the small mammals collected at Konza Praire from 1981 to 2013. Info included: year, season, month, and day the data was collected, the trap day, watershed at which data was collected (includes ), transect line, the numbered tag on the rebar where the trap was placed, species, sex, age, pregnancy status, scrotal condition, mass of small mammal, life status in the trap, postion of toe clip, hair clip, right ear tag, left ear tag, tail length, amd hind foot length.
| | *Small_mammals/CSM01_metadata.txt* - Konza's metadata for the *"CSM011.csv"* and *"CSM012.csv"* dataset; originally included in the zip-file downloaded via EDI and titled "knb-lter-knz.88.9.txt".[Link to EDI repository for all downloaded small mammal (CSM01) data/text files](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-knz.88.9) | raw data |
| Watershed_data | contains information about the watersheds downloaded from EDI | raw data |
| | *Fire_info_KFH011.csv* Fire information for each watershed at Konza. Info included: watershed, previous name for watershed, hectares, acres, date of fire, type of fire, year of fire | raw data |
| | *WatershedNameMatrix.xlsx* - Created by the data managers at Konza LTER to track the changes in watershed names throughout the years. | raw data |
| | *Watershed Info.xlsx* - Created by Maya P.S. to add information (such as burn-interval and grazing presence) regarding the watersheds used in our project. | raw data |

### Processed data and results
| directory and datasets | description| data wrangling |
| ------------- | ------------- | ------------- |
| E0_cleaned_data | contains data cleaned for consistency, field names, years, and watersheds to be included | processed data |
| | *E0_birds.csv* - cleaned data after running the raw data file (*"CBP011.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 1992-2009. | processed data |
| | *E0_grasshoppers.csv* - cleaned data after running the raw data file (*"CGR022.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 2002-2020. | processed data |
| | *E0_plants.csv* - cleaned data after running the raw data file (*"PVC021.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 1992-2022. | processed data |
| | *E0_smammals.csv* - cleaned data after running the raw data file (*"CSM011.csv"*) through the *"E0_AllTaxa_RawToClean"* RMarkdown code. The shortened dataset has a time series from 1992-2013. | processed data |
| E1_output_data | contains results for incidence classification, dissimilarity, and richness, separate by taxa | output data |
| Traits_data | contains tables with species life history information, in development | processed data |

---

### Code
This project requires multiple code files that achieve different steps in the data processing, analysis, and visualization steps. Rmarkdown code files are stored in the main directory for this repository.

| file name and location | description| analysis stage |
| ------------- | ------------- | ------------- |
| E0_AllTaxa_RawToClean.Rmd | Takes the raw datasets from all taxa (located in the "/Datasets/Raw_data"" folders) and prepares them for analysis. The cleaned data is saved in a new folder ("/Datasets/E0_cleaned_data") | cleans data |
| E1_AllTaxa_Analysis.Rmd | Takes the cleaned data from all taxa (located in the "/Datasets/E0_cleaned_data") and runs them through the classification function, conducts dissimilarity tests between watersheds and years (plus, creates plots for them), and calculates species richness. The output tables are saved in a new folder ("/Datasets/E1_output_data") | outputs results and figures |
| E2_AllTaxa_Plots.Rmd | Takes the results data and creates plots from them. The output for these plots are saved into a new folder ("/Plots"). Note: the code for the Jaccard dissimilarity plots are located in the "E1_AllTaxa_Analysis.Rmd" file, not this one | outputs figures |
| Trait-exploration.Rmd | Takes the results data and trait files, and generates visualizations | outputs figures |

--- 

### Figures
This directory contains figures that are relevant to the main project. It contains .png and .pdf files.

---

      
    

