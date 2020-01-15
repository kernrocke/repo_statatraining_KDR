
clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SES_BSS_ED_000.do
**  Project:      	STATA Training - DATA GROUP GACDRC
**	Sub-Project:	Week 1 (Collapse and Reshape)
**  Analyst:		Kern Rocke
**	Date Created:	15/01/2020
**	Date Modified: 	15/01/2020
**  Algorithm Task: Collapse and Reshape within STATA


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 150


*Setting working directory
** Dataset to encrypted location

*WINDOWS OS
local datapath "X:/The University of the West Indies/DataGroup - repo_data/data_statatraining"

*MAC OS
*local datapath "/Volumes/Secomba/kernrocke/Boxcryptor/DataGroup - PROJECT_p145/data_statatraining"

** Logfiles to unencrypted location
local logpath "X:/The University of the West Indies/DataGroup - repo_data/data_statatraining_KDR"

*-------------------------------------------------------------------------------

/*INSTRUCTIONS

Using DATASET 1 (dataset01_meteorology.dta), do the following:
Produce a summary table and summary graph of rainfall totals between 2000 and 2013, summarizing the time into quarter-years (2000q1, 2000q2, and so on)
Produce a summary table and summary graph of rainfall totals between 2000 and 2013, summarizing the time into month-years (2000m1, 2000m2, and so on)
Produce a summary table and summary graph of rainfall totals between 2000 and 2013, summarizing the time into week-years (2000w1, 2000w2, and so on)

Using DATASET 2 (dataset02_asthma.dta), do the following:
Tabulate the number of annual paediatric events along with an annual summary of dust levels
tabulate the number of annual paediatric events BY SEX, along with an annual summary of dust and rainfall
Graph the variation in admissions across the week (Sunday to Saturday)
*/

*-------------------------------------------------------------------------------

*Open log file to store results

log using "`logpath'/Week01_KDR.log", name(Week_01_STATA_Training) replace

*Open meterology dataset from encrypted location
use "`datapath'/dataset01_meteorology.dta", clear


*Describe data and variables
describe

*Create time variables for quarters



log close Week_01_STATA_Training