// cd "C:\Data\Synch\_______PAPERS\Paper 12_SROs experiment\_Analyze Data\Make complete dataset"
cd "E:\slvst\2TB\_sss\_RPs\12 SROs experiment\___ SRO2!\JRE\All_Data_SRO2_2020.05.16\2. Raw data with a program to extract the data into the stata dataset SRO_Complete"

//

// extract the subject tables from the ZTREE files, and append the sbj files to them.
// treatment 1 

clear
ztree2stata subjects using "01_111215_0826.xls"
merge m:1 Subject using "01_111215_0826sbj.dta"
compress
save "01_111215_0826_Complete", replace

// treatment 2 
clear
ztree2stata subjects using "02_111215_1019.xls"
merge m:1 Subject using "02_111215_1019sbj.dta"
compress
save "02_111215_1019_Complete.dta", replace

// treatment 3 
clear
ztree2stata subjects using "03_111215_1148.xls"
merge m:1 Subject using "03_111215_1148sbj.dta"
compress
save "03_111215_1148_Complete.dta", replace

// treatment 4 
clear
ztree2stata subjects using "04_111215_1825.xls"
merge m:1 Subject using "04_111215_1825sbj.dta"
compress
save "04_111215_1825_Complete.dta", replace

// treatment 5 
clear
ztree2stata subjects using "05_111215_1949.xls"
merge m:1 Subject using "05_111215_1949sbj.dta"
compress
save "05_111215_1949_Complete.dta", replace

// treatment 7 
clear
ztree2stata subjects using "07_111216_1211.xls"
merge m:1 Subject using "07_111216_1211sbj.dta"
compress
save "07_111216_1211_Complete.dta", replace

// treatment 8 
clear
ztree2stata subjects using "08_111216_1411.xls"
merge m:1 Subject using "08_111216_1411sbj.dta"
compress
save "08_111216_1411_Complete.dta", replace

// treatment 9 
clear
ztree2stata subjects using "09--_111216_1458.xls"
merge m:1 Subject using "09--_111216_1458sbj.dta"
compress
save "09--_111216_1458_Complete.dta", replace

// treatment 10 
clear
ztree2stata subjects using "10_111216_1640.xls"
merge m:1 Subject using "10_111216_1640sbj.dta"
encode client, generate(client_sub)
drop client
gen client=client_sub
drop client_sub
compress
save "10_111216_1640_Complete.dta", replace

// treatment 11 
clear
ztree2stata subjects using "11_111216_1746.xls"
merge m:1 Subject using "11_111216_1746sbj.dta"
encode client, generate(client_sub)
drop client
gen client=client_sub
drop client_sub
compress
save "11_111216_1746_Complete.dta", replace

// treatment 12 
clear
ztree2stata subjects using "12_111216_1915.xls"
merge m:1 Subject using "12_111216_1915sbj.dta"
encode client, generate(client_sub)
drop client
gen client=client_sub
drop client_sub
compress
save "12_111216_1915_Complete.dta", replace

echo "make sure to add the ztree2stata file to your stata program"

// treatment 13 
clear
ztree2stata subjects using "13_111217_1214.xls"
merge m:1 Subject using "13_111217_1214sbj.dta"
encode client, generate(client_sub)
drop client
gen client=client_sub
drop client_sub
compress
save "13_111217_1214_Complete.dta", replace

// treatment 14 
clear
ztree2stata subjects using "14_111217_1348.xls"
merge m:1 Subject using "14_111217_1348sbj.dta"
encode client, generate(client_sub)
drop client
gen client=client_sub
drop client_sub
compress
save "14_111217_1348_Complete.dta", replace

// treatment 15 
clear
ztree2stata subjects using "15_111217_1536.xls"
merge m:1 Subject using "15_111217_1536sbj.dta"
encode client, generate(client_sub)
drop client
gen client=client_sub
drop client_sub
compress
save "15_111217_1536_Complete.dta", replace







// create one dataset with all treatments
clear
use "01_111215_0826_Complete.dta", clear
append using "02_111215_1019_Complete.dta"
append using "03_111215_1148_Complete.dta"
append using "04_111215_1825_Complete.dta"
append using "05_111215_1949_Complete.dta"
append using "07_111216_1211_Complete.dta"
append using "08_111216_1411_Complete.dta"
append using "09--_111216_1458_Complete.dta"
append using "10_111216_1640_Complete.dta"
append using "11_111216_1746_Complete.dta"
append using "12_111216_1915_Complete.dta"
append using "13_111217_1214_Complete.dta"
append using "14_111217_1348_Complete.dta"
append using "15_111217_1536_Complete.dta"
compress
drop if treatment==4
drop if treatment==5
gen hadquestion= 1-(session=="111216_1411"|session=="111216_1746"|session=="111216_1915")
encode session, gen (sess)
compress
save "SRO_Complete.dta", replace

