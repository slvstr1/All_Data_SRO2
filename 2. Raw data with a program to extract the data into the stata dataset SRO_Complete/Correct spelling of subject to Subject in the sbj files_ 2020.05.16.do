// Corrects the spelling in the sbj files
//somehow the program has recorded the variable name as "subjects"instead of "Subjects". The program below corrects this 
// (correct spelling is necessary for the merge operations afterwards)

* Make sure that the working directory is pointed to the correct folder. In my case, this is:
cd "E:\slvst\2TB\_sss\_RPs\12 SROs experiment\___ SRO2!\JRE\All_Data_SRO2_2020.05.16\2. Raw data with a program to extract the data into the stata dataset SRO_Complete"

clear
use "01_111215_0826sbj.dta" 
cap rename ( subject) (Subject)
save "01_111215_0826sbj.dta", replace

clear
use "02_111215_1019sbj.dta" 
cap rename ( subject) (Subject)
save "02_111215_1019sbj.dta", replace
//
clear
use "03_111215_1148sbj.dta" 
cap rename ( subject) (Subject)
save "03_111215_1148sbj.dta", replace
//
clear
use "04_111215_1825sbj.dta" 
cap rename ( subject) (Subject)
save "04_111215_1825sbj.dta", replace
//
clear
use "05_111215_1949sbj.dta" 
cap rename ( subject) (Subject)
save "05_111215_1949sbj.dta", replace
//
clear
use "07_111216_1211sbj.dta" 
cap rename ( subject) (Subject)
save "07_111216_1211sbj.dta", replace
//
clear
use "08_111216_1411sbj.dta" 
cap rename ( subject) (Subject)
save "08_111216_1411sbj.dta", replace
//
clear
use "09--_111216_1458sbj.dta" 
cap rename ( subject) (Subject)
save "09--_111216_1458sbj.dta", replace
//
clear
use "10_111216_1640sbj.dta" 
cap rename ( subject) (Subject)
save "10_111216_1640sbj.dta", replace
//
clear
use "11_111216_1746sbj.dta" 
cap rename ( subject) (Subject)
save "11_111216_1746sbj.dta", replace
//
clear
use "12_111216_1915sbj.dta" 
cap rename ( subject) (Subject)
save "12_111216_1915sbj.dta", replace
//
clear
use "13_111217_1214sbj.dta" 
cap rename ( subject) (Subject)
save "13_111217_1214sbj.dta", replace
//
clear
use "14_111217_1348sbj.dta" 
cap rename ( subject) (Subject)
save "14_111217_1348sbj.dta", replace
//
clear
use "15_111217_1536sbj.dta" 
cap rename ( subject) (Subject)
save "15_111217_1536sbj.dta", replace
//DONE
