
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

*Tabulate measurement type
tab measure

*Retrieve codes for measure variables
codebook measure

/*Only rainfall needed therefore Av temp, Rel Hum, Max Temp and Min Temp will 
be removed */ 

keep if measure== 5

*-------------------------------------------------------------------------------

/*

Create time variables

This is being done because there is need for 3 different time variables 
(quarter, month and week) years

*/

*Create time variables for quarters
gen date_q = qofd(dov)
format date_q %tq
label var date_q "Date in quarter-years"

*Create time variables for months
gen date_m = mofd(dov)
format date_m %tm
label var date_m "Date in month-years"

*Create time variables for weeks
gen date_w = wofd(dov)
format date_w %tw
label var date_w "Date in week-years"

*-------------------------------------------------------------------------------

*Collapse section
*-------------------------------------------------------------------------------

/*
Using preserve here due to analysis has to be conducted on quarter, month and 
week
*/


preserve

*Collapse dataset using sum of rainfall measures for each quarter
collapse (sum) value, by(date_q)

*SUMMARY TABLE Quarter-years
tabstat value, by(date_q) stat(mean median min max) col(stat) format(%9.1f)

restore

*-------------------------------------------------------------------------------


preserve

*Collapse dataset using sum of rainfall measures for each month
collapse (sum) value, by(date_m)

*SUMMMARY TABLE Month-years
tabstat value, by(date_m) stat(mean median min max) col(stat) format(%9.1f)

restore

*-------------------------------------------------------------------------------


preserve

*Collapse dataset using sum of rainfall measures for each month
collapse (sum) value, by(date_w)

*SUMMMARY TABLE Month-years
tabstat value, by(date_w) stat(mean median min max) col(stat) format(%9.1f)

restore

*-------------------------------------------------------------------------------

*SUMMARY GRPAHS





log close Week_01_STATA_Training

*-----------------------------END-----------------------------------------------
