sort Period
label variable random_choice9  "Random play"
label variable random_choice29  "Random play"
label variable NESEQboth_basicSIM  "Baseline for sequential play"
label variable opt_both_basic_SEQ  "Baseline for sequential play"
label var NESIM_fem "Female"
label var NESIM_male "Male"
label var random_choice3 "random choice"


// p.14
// FIGURE 3 Proportion of joint choices that constitute a Nash equilibrium 
// (left) and a joint profit maximization (right)
// Left graph
twoway ///
(connected NESIMboth_basic Period, msize(vlarge)  lwidth(vthick)  ms(O) mcolor(black) lcolor(black)) ///
(connected NESIMboth_alp  Period,  msize(large)  lwidth(thick) lpattern(dash) ms(Th) mcolor(blue) lcolor(blue)) ///
(connected NESIMboth_6x6  Period,  msize(large) lwidth(thick)  lpattern(dash) ms(Dh) mcolor(red) lcolor(red)) ///
(connected random_choice9  Period, msize(large) lpattern(shortdash) lwidth(thick) ms(i) lcolor(black)) ///
, graphregion(margin(1))   aspectratio(.7)  xsize(3.6) ysize(2.8) yscale(range(0 1 )) xscale(range(1 10)) xlabel(1 2 3 4 5 6 7 8 9 10,  grid ) ytitle(Joint NE play) ylabel(0 0.1 0.2 0.3 .4 .5 .6 .7 .8 .9 1, grid ) scheme(s1color) ///
legend(order(1 2 3 4)  cols(2) ) 

// (connected NESEQboth_basicSIM  Period, msize(large)  lwidth(thick) lpattern(longdash) ms(O) mcolor(gray) lcolor(gray)) ///


// p.14
// FIGURE 3 Proportion of joint choices that constitute a Nash equilibrium 
// (left) and a joint profit maximization (right)
// Right graph

*** Proportion of joint max choices.
* joint random:
* basic 2/3 for SRO, 1/3 for GOV...   2/9  
* ext 2/3 for SRO, 1/3 for GOV  ...   2/9
* alp 1/3 for SRO, 1/3 for GOV  ...   1/9
* 6x6 alp 1/3 for SRO, 1/6 for GOV... 1/18
sort Period
label variable random_choice19  "Random play baseline for 3x3 (alt.param.)"
label variable random_choice18  "Random play baseline for 6x6"

twoway ///
(connected opt_both_basic Period, msize(vlarge)  lwidth(vthick)  ms(O) mcolor(black) lcolor(black)) ///
(connected opt_both_alp  Period,  msize(large)  lwidth(thick) lpattern(dash) ms(Th) mcolor(blue) lcolor(blue)) ///
(connected opt_both_6x6  Period,  msize(large) lwidth(thick)  lpattern(dash) ms(Dh) mcolor(red) lcolor(red)) ///
(connected opt_both_basic_SEQ Period, msize(large)  lwidth(thick)  lpattern(longdash) ms(O) mcolor(gray) lcolor(gray)) ///
(connected random_choice29  Period, msize(large) lpattern(shortdash) lwidth(thick) ms(i) lcolor(black)) ///
, graphregion(margin(1))   aspectratio(.7)  xsize(3.6) ysize(2.8) yscale(range(0 0.3 )) xscale(range(1 10)) xlabel(1 2 3 4 5 6 7 8 9 10,  grid ) ///
ytitle(Joint max play) ylabel(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1, grid ) scheme(s1color) ///
legend(order(1 5 - " "  - "Robustness tests and SEQ:" 4 2 3)  cols(1) ) ///
legend(off)




* for creating legend for the 2 figures
twoway ///
(connected opt_both_basic Period, msize(vlarge)  lwidth(vthick)  ms(O) mcolor(black) lcolor(black)) ///
(connected opt_both_alp  Period,  msize(large)  lwidth(thick) lpattern(dash) ms(Th) mcolor(blue) lcolor(blue)) ///
(connected opt_both_6x6  Period,  msize(large) lwidth(thick)  lpattern(dash) ms(Dh) mcolor(red) lcolor(red)) ///
(connected opt_both_basic_SEQ Period, msize(large)  lwidth(thick)  lpattern(longdash) ms(O) mcolor(gray) lcolor(gray)) ///
(connected random_choice29  Period, msize(large) lpattern(shortdash) lwidth(thick) ms(i) lcolor(black)) ///
, graphregion(margin(1))   aspectratio(.7)  xsize(4.8) ysize(2.8) yscale(range(0 0.3 )) xscale(range(1 10)) xlabel(1 2 3 4 5 6 7 8 9 10,  grid ) ///
ytitle(Joint max play) ylabel(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1, grid ) scheme(s1color) ///
legend(order(- "Baseline treatment:"   1 5 -  "Robustness tests:" 2 3  -  "Sequential play:"  4 - " " )  cols(3) colfirst)


// p. 15
// "A statistical test shows that, for all treatments, the proportions are 
// significantly higher than the "random play proportions" (the proportions that 
// would result from random play). For the test, I determine for each independent 
// group of 6 participants the proportion of joint NE play, averaged over the last 
// 5 rounds. I then use a two-sided, single-sample sign-test to test for 
// significance.  The baseline and complex treatments are significant at 
// the 1% level."


signrank NESIMboth_basic_av_5 = 1/9
signrank NESIMboth_alp_av_5 = 1/9
signrank NESIMboth_6x6_av_5 = 3/36
