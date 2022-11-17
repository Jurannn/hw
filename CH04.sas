ods pdf file = "C:\Users\USER\Desktop\시계열\ch04.pdf";


/**************EXAMPLE 4.1**************/
data food;
infile "C:\Users\USER\Desktop\시계열\food.txt"; input food @@;
   date = intnx('month', '1JAN84'D,_n_-1);
   format date Monyy.; t+1;
      mon = month(date);
      if mon = 1 then i1 = 1; else i1 = 0;
      if mon = 2 then i2 = 1; else i2 = 0;
      if mon = 3 then i3 = 1; else i3 = 0;
      if mon = 4 then i4 = 1; else i4 = 0;
      if mon = 5 then i5 = 1; else i5 = 0;
      if mon = 6 then i6 = 1; else i6 = 0;
      if mon = 7 then i7 = 1; else i7 = 0;
      if mon = 8 then i8 = 1; else i8 = 0;
      if mon = 9 then i9 = 1; else i9 = 0;
      if mon = 10 then i10 = 1; else i10 = 0;
      if mon = 11 then i11 = 1; else i11 = 0;
      if mon = 12 then i12 = 1; else i12 = 0;
      run;

proc print data = food; run;


/**food 자료에 선형추세모형 적합하기**/
proc reg data = food;
model food = t / dw;
output out = trendata p = trend;
id date;
run;

proc print data = trendata; run;

data adtrdata; set trendata;
adjtrend = food/trend; run;

/**food 자료에 자기회귀오차모형 적합하기**/
proc autoreg data = adtrdata;
model adjtrend = i1-i12 / noint nlag = 13 dwprob backstep;
output out = seasdata p = seasonal; run;


data all;
set seasdata;
keep date food trend seasonal irregular fitted;
irregular = adjtrend/seasonal; fitted = trend*seasonal; run;

proc print data = all; var date food trend seasonal irregular fitted; run;

/**arima**/
proc arima data = all;
identify var = irregular nlag = 12; run;




/**[그림 4-1] 그리기**/
proc sgplot data = all;
series x = date y = food / lineattrs = (pattern=1 color = blue);
series x= date y = trend / lineattrs = (pattern=2 color = black); run;

/**[그림 4-2] 그리기**/
proc sgplot data = all;
series x = date y = seasonal; run;

/**[그림 4-3] 그리기**/
proc sgplot data = all;
series x = date y = irregular; refline 1.0 / axis = y; run;

/**[그림 4-4] 그리기**/
proc sgplot data = all;
series x = date y = food / lineattrs = (pattern=1 color = blue);
series x= date y = fitted / lineattrs = (pattern=2 color = black); run;







/**adjseason (계절조정)**/

data all1;
set seasdata;
keep date food trend seasonal irregular fitted adjseason;
irregular = adjtrend/seasonal; fitted = trend*seasonal; adjseason = food/seasonal; run;


proc print data = all1; var date food trend seasonal irregular fitted adjseason; run;



/**원계열 + 계절 보정된 계열(adjseason) 그림**/
proc sgplot data = all1;
series x = date y = food / lineattrs = (pattern=1 color = blue);
series x= date y = adjseason / lineattrs = (pattern=2 color = black); run;











/**************EXAMPLE 4.2**************/
data index;
infile "C:\Users\USER\Desktop\시계열\mindex.txt";
input index @@;
date = intnx('month', '1JAN84'D,_n_-1);
format date monyy.; t+1;
run;

proc print data=index; run;

/**expand 절차를 이용하여 이동평균값 구하기**/
proc expand data = index out = index1;
convert index = m3/transformout = (cmovave 3 trim 1);
convert index = m7/transformout = (cmovave 7 trim 3);
run;


/**<표 4-4>**/
proc print data = index1; run;

/**[그림 4-5] 그리기**/
proc sgplot data = index1;
series x = date y = index / lineattrs = (pattern=1 color = black);
series x= date y = m3 / lineattrs = (pattern=2 color = blue);
xaxis values = ('1jan86'd to '1jan94'd by year); run;


/**[그림 4-6] 그리기**/
proc sgplot data = index1;
series x = date y = index / lineattrs = (pattern=1 color = black);
series x= date y = m7 / lineattrs = (pattern=2 color = blue);
xaxis values = ('1jan86'd to '1jan94'd by year); run;











/**************EXAMPLE 4.3**************/
data food;
infile "C:\Users\USER\Desktop\시계열\food.txt"; input food @@;
   date = intnx('month', '1JAN84'D,_n_-1);
   format date Monyy.; t+1;
   mon = month(date);
   run;

proc print data = food; run;


/**expand 절차를 이용하여 승법모형의 구성 성분들을 추정하기**/
proc expand data = food out = food2;
convert food = tc/transformout=(cda_tc 12);
convert food = s/transformout=(cda_s 12);
convert food = i/transformout=(cda_i 12);
convert food = sa/transformout=(cda_sa 12);
run;

proc print data = food2; run;

/**[그림 4-7] 그리기**/
proc sgplot data = food2;
series x = date y = food / lineattrs = (pattern=1 color = black);
series x= date y = tc / lineattrs = (pattern=2 color = blue);
xaxis values = ('1jan80'd to '1jan92'd);
run;

/**[그림 4-8] 그리기**/
proc sgplot data = food2;
series x = date y = food / lineattrs = (pattern=1 color = black);
series x= date y = s / lineattrs = (pattern=2 color = blue);
xaxis values = ('1jan80'd to '1jan92'd);
run;

/**[그림 4-9] 그리기**/
proc sgplot data = food2;
series x = date y = food / lineattrs = (pattern=1 color = black);
series x= date y = i / lineattrs = (pattern=2 color = blue);
xaxis values = ('1jan80'd to '1jan92'd);
run;

/**[그림 4-10] 그리기**/
proc sgplot data = food2;
series x = date y = food / lineattrs = (pattern=1 color = black);
series x= date y = sa / lineattrs = (pattern=2 color = blue);
xaxis values = ('1jan80'd to '1jan92'd);
run;












/**************EXAMPLE 4.4**************/
data food;
infile "C:\Users\USER\Desktop\시계열\food.txt"; input food @@;
   date = intnx('month', '1JAN84'D,_n_-1);
   format date Monyy.; t+1;
   mon = month(date);
   run;

proc print data = food; run;

/**X12 절차에서 X11 방법에 의해 여러 가지 성분들을 산출하기**/
proc X12 data = food seasons = 12 start = jan1980;
var food; x11;
output out = foodout a1 d10 d11 d12 d13; run;

/**<표 4-7> 출력**/
proc print data = foodout; run;

/**[그림 4-11] ~ [그림 4-14] 그리기**/
data foodout; set foodout(rename = (_date_ = date food_a1 = food food_d10 = d10 food_d11 = d11 food_d12 = d12 food_d13 = d13));
label food="" d10 = "" d11 = "" d12 = "" d13 = ""; run;

/**[그림 4-11] 그리기**/
title "Final seasonal factors";
proc sgplot data = foodout; series x = date y = d10; run;


/**[그림 4-12] 그리기**/
title "Original time series ve Seasonally adjuted series";
proc sgplot data = foodout;
series x = date y = food/ lineattrs = (pattern=1 color = blue);
series x= date y = d11 / lineattrs = (pattern=2 color = black); run;


/**[그림 4-13] 그리기**/
title "Original time series vs Trend Cycle";
proc sgplot data = foodout;
series x = date y = food/ lineattrs = (pattern=1 color = blue);
series x= date y = d12 / lineattrs = (pattern=2 color = black); run;


/**[그림 4-14] 그리기**/
title "Irregular component";
proc sgplot data = foodout;
series x = date y = d13; refline 1.0 / axis = y; run;

/**arima**/
proc arima data = foodout; identify var = d13 nlag = 24; run;


ods pdf close;
