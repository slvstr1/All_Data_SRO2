// cd "D:\_sss\_RPs\12 SROs experiment\_Analyze Data
cd "E:\slvst\2TB\_sss\_RPs\12 SROs experiment\___ SRO2!\JRE\All_Data_SRO2_2020.05.16\3. Stata_Analysis"

use "SRO_Complete.dta", clear
// coding in ztree is SRO=1 and Gov=2 for Type
gen GOV=(Type==2)
gen SRO=(Type==1)

drop tables Participate
** Overview of treatments

*         File name             - Numbered("sess")- code - condition
* "01_111215_0826_Complete.dta" -  1              -1 T1s      - T1SIM: basic case, SIM
* "02_111215_1019_Complete.dta" -  2              -1 T1s      - T1SIM: basic case, SIM
* "03_111215_1148_Complete.dta" -  3              -1 T1s      - T1SIM: basic case, SIM
* "04_111215_1825_Complete.dta" -  4              -2 T1q      - T1SEQ: basic case, SEQ
* "05_111215_1949_Complete.dta" -  5              -2 T1q      - T1SEQ: basic case, SEQ
* "06_111216_1035Complete.dta" -  something went wrong - this data is not used             -3 T4s_6x6  - T4SIM: 6x6 , SIM
* "07_111216_1211_Complete.dta" -  6              -3 T4s_6x6  - T4SIM: 6x6 , SIM
* "08_111216_1411_Complete.dta" -  7              -3 T4s_6x6  - T4SIM: 6x6 , SIM

* "09--_111216_1458_Complete.dta"- 8              -4 T4q_6x6  - T4SEQ: 6x6 , SEQ
* "10_111216_1640_Complete.dta" -  9              -4 T4q_6x6  - T4SEQ: 6x6 , SEQ
* "11_111216_1746_Complete.dta" - 10              -5 T6q_ext  - T6SEQ: Extensive form, SEQ (internal stamp says T1_SEQ and Phase is 3) (is correct - for extensive only pay-off representation different
* "12_111216_1915_Complete.dta" - 11              -6 T6s_ext  - T6SIM: Extensive form, SIM (internal stamp says T1_SIM and Phase is 2) (is correct - for extensive only pay-off representation different
* "13_111217_1214_Complete.dta" - 12              -7 T2s_alp - T2SIM: alternative parametrisation, SIM (internal stamp says T2_SIM and Phase is 2)
* "14_111217_1348_Complete.dta" - 13              -8 T2q_alp - T2SEQ: alternative parametrisation, SIM (internal stamp says T2_SEQ and Phase is 3)
* "15_111217_1536_Complete.dta" - 14              -8 T2q_alp - T2SEQ: alternative parametrisation, (internal stamp says T2_SEQ and Phase is 3)
* "16_181120_1255_Complete.dta" - 15              -? T2       - T2SIM: alternative parametrisation, (internal stamp says T2_SIM and Phase is 2)
* "17_181120_1419_Complete.dta" - 16              -? T2       - T2SIM: alternative parametrisation, (internal stamp says T2_SIM and Phase is 2)
* "18_181120_1552_Complete.dta" - 17              -? T4_6x6    - T4SIM: alternative parametrisation, (internal stamp says T4_SIM and Phase is 2)


* all xls outputs from ZTREE are checked for the internal stamp, and the phase (which indicates SIM (2) or SEQ (3))
******************************
******************************
* what is the difference between session, section and group?
* session - each run using the full lab
* section -
* group   - the people dealing with one another (thus 2 people)
******************************
******************************
* identify the treatments from the questions
gen propertreatments = cond(hadquestion==1, treatment==2, treatment==1)
* encode session, gen(session_no)


* create tr as identifyer of the treatments
gen tr=sess if propertreatments==1
recode tr (1/3= 1) (4/5= 2) (6/7= 3) (8/9= 4) (10= 5) (11= 6) (12= 7) (13/14= 8) (15/16= 7) (17= 3)
label define tr 1 "T1s" 2 "T1q" 3 "T4s_6x6" 4 "T4q_6x6" 5 "T6q_ext" 6 "T6s_ext" 7 "T2s_alp" 8 "T2q_alp"
label values tr tr
replace treatment=tr
label values treatment tr
* checked and treatment properly and correctly identifies the treatment
gen id=sess*100+Subject


* get rid of question data (later maybe include for check)
drop if propertreatments==0
drop if tr==6

tabulate session, generate(session_dum)
tabulate tr, generate(tr_dum)
***********************************************

drop question LLpayoff LLpayoffother 
* the choices are renamed to indicate that the way choices are recorded are different
* For the 6x6 1-> NONE, 2-> VERY LOW, 3-> LOW, 4-> MEDIUM, 5->HIGH, 6->VERY HIGH
* For the 3x3 1-> NONE, 2-> LOW, 3->HIGH, 
rename Choice1 Choicediff
rename OtherChoice OtherChoicediff

 
* For all 3x3 treatmens I change 1->1, 2->3, 3->5
*
* now the variables Choice & OtherChoice are manipulated so that they record choices in the same way:
* For the 6x6 1-> NONE, 2-> VERY LOW, 3-> LOW, 4-> MEDIUM, 5->HIGH, 6->VERY HIGH
* For the 3x3 1-> NONE, 3-> LOW, 5->HIGH, 
*
gen Choice= cond((treatment==3|treatment==4),Choicediff,1+2*(Choicediff-1))
gen OtherChoice= cond((treatment==3|treatment==4),OtherChoicediff,1+2*(OtherChoicediff-1))

* strategy is represented by a 2-digit number, the 1st (2nd) number shows the choice of the 1st (2nd) player, SRO (GOV). Note this is true both for data on SRO and GOV!!!
gen strat=cond(SRO==1, Choice*10+OtherChoice,Choice+OtherChoice*10)

gen SessPeriod= sess*100+Period
gen SessGroup = sess*100+ Group
gen SessSect= sess*100+ Section



* Mark the different treatments
gen SEQ= (treatment==2|treatment==4|treatment==5|treatment==8)
gen t6x6=(treatment==3|treatment==4)
gen alp=(treatment==7|treatment==8)
gen ext=(treatment==5|treatment==6)
gen basic=(treatment==1|treatment==2)
gen SIM= 1 - SEQ

*label them
*label define choice_t6x6 1 "NONE" 2 "VERY LOW" 3 "LOW" 4 "MEDIUM" 5 "HIGH" 6 "VERY HIGH"
*label define choice_t3x3 1 "NONE" 2 "LOW" 3 "HIGH"
*label values Choice choice_t6x6 if t6x6==1
*label values OtherChoice choice_t6x6 if t6x6==1
*label values Choice choice_t3x3 if t6x6==0
*label values OtherChoice choice_t3x3 if t6x6==0


* rename the label sex to Female
quietly tabulate sex, generate(new_sex)
rename new_sex1 Female
cap drop new_sex2

*********************************
* DETERMINE IF THE CHOICE IS NE*
*********************************
* NE choice is 1 (NONE) for SRO
cap drop NESIMsro
cap drop NESIMgov
gen NESIMsro= cond((Choice == 1 & SIM==1),1,0) if SRO==1
* NE choice is 5(NONE) for GOV , but for 6x6 it is also 4 and 6 AND 5!
gen NESIMgov= cond(t6x6==1, cond((Choice==4|Choice==5|Choice==6) & SRO==0 & SIM==1,1,0),cond(OtherChoice==5 & SRO==1 & SIM==1,1,0)) if GOV==1
gen NESIMboth= cond(t6x6==1, cond((strat==14|strat==15|strat==16) & SRO==1 & SIM==1,1,0),cond(strat==15 & SRO==1 & SIM==1,1,0))

* (I expect more 4 than 5 or 6, as 4 gives SIM guy more payoff 13 versus 11 and 8)


* for the 3 NE choices for SRO in 6x6 in SIM
gen NESIM_6x6_gov_HIGHv = cond(t6x6==1 & SRO==0 & SIM==1 & Choice==5,1,0)
gen NESIM_6x6_gov_VERYHIGHv = cond(t6x6==1 & SRO==0 & SIM==1 & Choice==6,1,0)
gen NESIM_6x6_gov_MEDIUMv = cond(t6x6==1 & SRO==0 & SIM==1 & Choice==4,1,0)


cap drop NESIM 
cap drop NESIMsro_nomis 
gen NESIMsro_nomis = NESIMsro
recode NESIMsro_nomis (.=0)
gen NESIMgov_nomis = NESIMgov
recode NESIMgov_nomis (.=0)

gen NESIM= NESIMsro_nomis + NESIMgov_nomis
gen NESIM_HIGHv= NESIMsro + NESIM_6x6_gov_HIGHv
gen Tbegin = (Period<4)
gen Tmiddle= (Period>3 & Period <8)
gen Tend =(Period>7)
gen T= Tbegin + Tmiddle * 2 + Tend * 3
label define Tl 1 "Rounds 1-3" 2 "Rounds 4-7" 3 "Rounds 8-10"
label values T Tl

tab NESIMsro if  GOV==1
tab NESIMsro if SRO==1
tab NESIMsro
tab NESIMgov
tab NESIM



gen SROchoice= cond(SRO==1,Choice,.)

label define stratlabel6x6 11 "NONE_NONE"      12 "NONE_VERY LOW"      13 "NONE_LOW"      14 "NONE_MEDIUM"      15 "NONE_HIGH"      16 "NONE_VERY HIGH" 21 "VERY LOW_NONE"  22 "VERY LOW_VERY LOW"  23 "VERY LOW_LOW"  24 "VERY LOW_MEDIUM"  25 "VERY LOW_HIGH"  26 "VERY LOW_VERY HIGH" 31 "LOW_NONE"       32 "LOW_VERY LOW"       33 "LOW_LOW"       34 "LOW_MEDIUM"       35 "LOW_HIGH"       36 "LOW_VERY HIGH" 41 "MEDIUM_NONE"    42 "MEDIUM_VERY LOW"    43 "MEDIUM_LOW"    44 "MEDIUM_MEDIUM"    45 "MEDIUM_HIGH"    46 "MEDIUM_VERY HIGH" 51 "HIGH_NONE" 52 "HIGH_VERY LOW"      53 "HIGH_LOW"      54 "HIGH_MEDIUM"      55 "HIGH_HIGH"      56 "HIGH_VERY HIGH" 61 "VERY HIGH_NONE" 62 "VERY HIGH_VERY LOW" 63 "VERY HIGH_LOW" 64 "VERY HIGH_MEDIUM" 65 "VERY HIGH_HIGH" 66 "VERY HIGH_VERY HIGH"
label values strat stratlabel6x6 
label define stratlabel3x3 11 "NONE_NONE" 12 "NONE_LOW" 13 "NONE_HIGH" 21 "LOW_NONE" 22 "LOW_LOW" 23 "LOW_HIGH" 31 "HIGH_NONE" 32 "HIGH_LOW" 33 "HIGH_HIGH" 



* NE choice is 5(HIGH) for SRO , but for alp it is 3,3 (LOW, LOW) and for 6x6 it is LOW, VERY LOW ((3,2)->SRO-14)
* (if SRO thinks GOV will choose the one with the highest SRO payoff), and only otherwise HIGH,NONE ((5,1)->SRO-11))

gen NESEQsro=cond(alp==1, cond(Choice==3 & SRO==1 ,1,0), cond(t6x6==1,cond((Choice==5|Choice==3)& SRO==1 ,1,0),cond(Choice==5 & SRO==1 ,1,0)))
gen NESEQgov=cond(alp==1, cond(Choice==3 & SRO==0 ,1,0), cond(t6x6==1,cond((Choice==1|Choice==2)& SRO==0 ,1,0),cond(Choice==1 & SRO==0 ,1,0)))
gen NESEQboth=cond(SRO==1,cond(alp==1, cond(strat==33 & SRO==1 ,1,0), cond(t6x6==1,cond((strat==51|strat==32)& SRO==1 ,1,0), cond(strat==51 & SRO==1 ,1,0),0)),.)
gen otherNESEQsro=cond(alp==1, cond(OtherChoice==3 & SRO==0 ,1,0), cond(t6x6==1,cond((OtherChoice==5|OtherChoice==3)& SRO==0 ,1,0),cond(OtherChoice==5 & SRO==0 ,1,0)))
gen newNESEQsro=cond(alp==1, cond(Choice==3 & SRO==1 ,1,0), cond(t6x6==1,cond((Choice==5|Choice==3)& SRO==1 ,1,0),cond(Choice==5 & SRO==1 ,1,0)))
gen newNESEQgov=cond(alp==1, cond(OtherChoice==3 & SRO==1 ,1,0), cond(t6x6==1,cond((OtherChoice==1|OtherChoice==1)& SRO==1 ,1,0),cond(OtherChoice==1 & SRO==1 ,1,0)))
gen newNESEQboth=cond(SRO==1,cond(alp==1, cond(strat==33 & SRO==1 ,1,0), cond(t6x6==1,cond((strat==51|strat==32)& SRO==1 ,1,0),cond(strat==51 & SRO==1 ,1,0),0)),.)

// tab NESEQsro
// tab NESEQgov
gen NESEQ =NESEQgov+NESEQsro
// tab NESEQ

* for the 2 NEs in 6x6 in SEQ
gen NESEQ_6x6_both_standv = cond(t6x6==1 & SRO==1  & strat==51,1,0)
gen NESEQ_6x6_both_lowv = cond(t6x6==1 & SRO==1  & strat==32,1,0)



*************************
*************************
*************************
* Do GOV & SRO try to go for the optimal (not NE)?
*cap drop opt_both_basicv opt_both_extv opt_both_alpv opt_both_6x6v
gen opt_both_basicv= cond(t6x6==0 & ext==0 & alp==0 &SRO==1, cond((strat==51|strat==31),1,0),.)
*gen opt_both_extv= cond(SIM==1 & t6x6==0 & ext==1 & alp==0 &SRO==1, cond((strat==51|strat==31),1,0),.)
gen opt_both_alpv= cond(t6x6==0 & ext==0 & alp==1 &SRO==1, cond((strat==31),1,0),.)
gen opt_both_6x6v= cond( t6x6==1 & ext==0 & alp==0 &SRO==1, cond((strat==41|strat==51),1,0),.)
* joint random:
* basic 2/3 for SRO, 1/3 for GOV...   2/9  
* ext 2/3 for SRO, 1/3 for GOV  ...   2/9
* alp 1/3 for SRO, 1/3 for GOV  ...   1/9
* 6x6 alp 1/3 for SRO, 1/6 for GOV... 1/18

g random_choice19=1/9
g random_choice29=2/9
g random_choice18=1/18



// summ opt_both_basicv
// summ strat if SRO==1





*cap drop opt_both_basic opt_both_ext opt_both_alp opt_both_6x6
by Period, sort : egen float opt_both_basic= mean(opt_bot h_basicv) if SIM==1 & t6x6==0 & ext==0 & alp==0 &SRO==1
* by Period, sort : egen float opt_both_ext= mean(opt_both_extv) if SIM==1 & t6x6==0 & ext==1 & alp==0 &SRO==1
by Period, sort : egen float opt_both_alp= mean(opt_both_alpv) if SIM==1 & t6x6==0 & ext==0 & alp==1 &SRO==1
by Period, sort : egen float opt_both_6x6= mean(opt_both_6x6v) if SIM==1 & t6x6==1 & ext==0 & alp==0 &SRO==1

by Period, sort : egen float opt_both_basic_SEQ= mean(opt_bot h_basicv) if SEQ==1 & t6x6==0 & ext==0 & alp==0 &SRO==1
* by Period, sort : egen float opt_both_ext= mean(opt_both_extv) if SIM==1 & t6x6==0 & ext==1 & alp==0 &SRO==1
by Period, sort : egen float opt_both_alp_SEQ= mean(opt_both_alpv) if SEQ==1 & t6x6==0 & ext==0 & alp==1 &SRO==1
by Period, sort : egen float opt_both_6x6_SEQ= mean(opt_both_6x6v) if SEQ==1 & t6x6==1 & ext==0 & alp==0 &SRO==1


// by Period, sort : tab strat if SRO==1 & t6x6==0 & ext==0 & alp==0 
// tab  opt_both_basicv if SRO==1 & t6x6==0 & ext==0 & alp==0 & Period==10






by Period, sort : egen float NESIMboth_all = mean(NESIMboth) if SIM==1 &SRO==1
by Period, sort : egen float NESIMboth_basic = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 & alp==0&SRO==1
by Period, sort : egen float NESIMboth_6x6 = mean(NESIMboth) if SIM==1 & t6x6==1 & ext==0 & alp==0&SRO==1
by Period, sort : egen float NESIMboth_ext = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==1 & alp==0&SRO==1
by Period, sort : egen float NESIMboth_alp= mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 & alp==1&SRO==1
by Period, sort : egen float NESIMboth_allE6x6 = mean(NESIMboth) if SIM==1 & t6x6==0 &SRO==1

by Period, sort : egen float NESIM_all= mean(NESIM) if SIM==1 &SRO==1
by Period, sort : egen float NESIM_fem= mean(NESIM) if SIM==1 &SRO==1 & Female==1 
by Period, sort : egen float NESIM_male= mean(NESIM) if SIM==1 &SRO==1 & Female==0 



label variable NESIMboth_basic "Baseline"
label variable NESIMboth_ext "Extensive"
label variable NESIMboth_alp "Alternative"
label variable NESIMboth_allE6x6  "All except 6x6"
label variable NESIMboth_6x6 "6x6"


g random_choice3=1/3
g random_choice36=1/3
g random_choice6=1/6
g random_choice9=1/9
*g random_choice18=1/18


************************
* setup for xxx test

// tab  SessGroup NESIMboth
// by tr, sort:tab  SessGroup NESIMboth if Period ==10
// sum SessGroup

cap drop NESIMboth_all_5 

*summ NESIMboth_all_5
*tab NESIMboth_all_5
// summ NESIMboth
// tab NESIMboth
by SessGroup,sort: egen float NESIMboth_all_5 = mean(NESIMboth) if SIM==1 &SRO==1& Period==5

*summ NESIMboth_all_5_rep
*by Period ,sort:tab NESIMboth_basic_5_rep


*regress NESIMboth_basic_5_rep ibn.x, noconstant
sort Period SessSect SessGroup
cap drop NESIMboth_av

by SessSect Period,sort: egen float NESIMboth_av= mean(NESIMboth) if SIM==1 & SRO==1
* gives the success proportion per section (in a session) per period for all treatments with SIM
cap drop tag_SessSect 
cap drop tag_SessSect_Period5 
egen tag_SessSect = tag(SessSect Period)if SIM==1 &SRO==1
egen tag_SessSect_Period5 = tag(SessSect)if SIM==1 &SRO==1 & Period>5
cap drop NESIMboth_basic_av_r
gen NESIMboth_basic_av_r=NESIMboth_av if tag_SessSect ==1 & t6x6==0 & ext==0 & alp==0


//
// forvalues x = 1/10 {
// generate NESIMboth_basic_av`x' = NESIMboth_av if tag_SessSect ==1 & t6x6==0 & ext==0 & alp==0 & Period ==`x'
// summ NESIMboth_basic_av`x'
// }
//
//
// forvalues x = 1/10 {
// summ NESIMboth_basic_av`x'
// }

forvalues x = 1/10 {
generate NESIMboth_basic_`x' = NESIMboth if  t6x6==0 & ext==0 & alp==0 & Period==`x' & SRO==1 & SIM==1
// summ NESIMboth_basic_`x'
}


forvalues x = 1/10 {
prtest NESIMboth_basic_`x'  == 0.111
}


// tab NESIMboth_basic_1
prtest NESIMboth_basic_1 == 0.111
prtest NESIMboth_basic_5 == 0.111
prtest NESIMboth_basic_9 == 0.111
prtest NESIMboth_basic_10  == 0.111
// prtest NESIMboth_basic_10  == 0.111,cluster(SessSect) rho(1)

// generate NESIMboth_basic_av`x' = NESIMboth_av if tag_SessSect ==1 & t6x6==0 & ext==0 & alp==0 & Period==`x'
tab NESIMboth_basic_5



******************
******************
*lump the last 5 periods together, and compare the proportion of success with signrank to random choice
******************
******************
cap drop NESIMboth_basic_av_5 
cap drop NESIMboth_basic_5_rep
cap drop NESIMboth_alp_5_rep 
cap drop NESIMboth_allE6x6_5_rep 
cap drop NESIMboth_all_5_rep 
by SessSect,sort:  egen float NESIMboth_basic_5_rep = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 & alp==0&SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_6x6_5_rep = mean(NESIMboth) if SIM==1 & t6x6==1 & ext==0 & alp==0&SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_alp_5_rep = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 & alp==1&SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_allE6x6_5_rep = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 &alp>=0 & alp<=2 &SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_all_5_rep = mean(NESIMboth) if SIM==1 &  ext==0  &SRO==1& Period>5


// egen NESIMboth_allE6x6_av_5 = rowtotal(NESIMboth_basic_av_5 NESIMboth_alp_av_5), missing

*************************
*************************
*************************



******************
******************
*lump the last 5 periods together, and compare the proportion of success with signrank to random choice
******************
******************
cap drop NESIMboth_basic_av_5 
cap drop NESIMboth_basic_5_rep
cap drop NESIMboth_alp_5_rep 
cap drop NESIMboth_allE6x6_5_rep 
cap drop NESIMboth_all_5_rep 
cap drop NESIMboth_6x6_5_rep
by SessSect,sort:  egen float NESIMboth_basic_5_rep = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 & alp==0&SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_6x6_5_rep = mean(NESIMboth) if SIM==1 & t6x6==1 & ext==0 & alp==0&SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_alp_5_rep = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 & alp==1&SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_allE6x6_5_rep = mean(NESIMboth) if SIM==1 & t6x6==0 & ext==0 &alp>=0 & alp<=2 &SRO==1& Period>5
by SessSect,sort:  egen float NESIMboth_all_5_rep = mean(NESIMboth) if SIM==1 &  ext==0  &SRO==1& Period>5

// sum NESIMboth_allE6x6_5_rep NESIMboth_basic_5_rep
// tab NESIMboth_basic_5_rep

cap drop NESIMboth_all_5
generate NESIMboth_basic_av_5 = NESIMboth_basic_5_rep if tag_SessSect_Period5 ==1 & t6x6==0 & ext==0 & alp==0 &SRO==1& Period>5
generate NESIMboth_6x6_av_5 = NESIMboth_6x6_5_rep if tag_SessSect_Period5 ==1 & t6x6==1 & ext==0 & alp==0 &SRO==1& Period>5
generate NESIMboth_alp_av_5 = NESIMboth_alp_5_rep if tag_SessSect_Period5 ==1 & t6x6==0 & ext==0 & alp==1 &SRO==1& Period>5
generate NESIMboth_all_5 = NESIMboth_all_5_rep if tag_SessSect_Period5 ==1 & ext==0 &SRO==1& Period>5



 by Period, sort : egen float NESEQboth_basicSIM = mean(NESIMboth) if SEQ==1 & t6x6==0 & ext==0 & alp==0 & SRO==1

label variable NESIMboth_basic "Baseline"
label variable NESIMboth_ext "Extensive"
label variable NESIMboth_alp "Alternative"
label variable NESIMboth_allE6x6  "All except Complex"
label variable NESIMboth_6x6 "Complex"

label variable opt_both_basic "Baseline"
label variable NESIMboth_ext "Extensive"
label variable opt_both_alp "Alternative"
label variable opt_both_basic_SEQ  "SEQ-Baseline"
label variable opt_both_6x6 "Complex"


compress
