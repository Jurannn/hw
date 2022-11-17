proc import datafile="C:\Users\USER\Desktop\다변량\[다변량통계학] SAS실습 2\data\roots.csv" dbms=csv out=roots replace;
run;

proc print data=roots;
run;

/*평균 보기*/
proc means data=roots mean maxdec=2;
	class stock;
run;

/*박스 그림 -> 평균 간 차이를 시각적으로 보기 위해서*/
proc univariate data=roots plot;
	var girth4 growth girth15 weight;
	by stock;
run;

/*일변량 분산분석*/
proc anova data=roots;
	class stock; /*stock을 그룹으로 한다*/
	model girth4 growth girth15 weight = stock;
	means stock;
run;

proc anova data=roots;
	class stock;
	model girth4 growth girth15 weight = stock;
	means stock / hovtest welch; /*hovtest - 등분산검정, 등분산성이 만족되지 않는 경우 - welch를 사용*/
run;

/*다변량 분산분석*/

proc anova data=roots;
	class stock;
	model girth4 growth girth15 weight = stock;
	manova h = stock;
run;

/*판별분석*/

proc import datafile="C:\Users\USER\Desktop\다변량\[다변량통계학] SAS실습 2\data\income.csv" dbms=csv out=income;
run;

proc import datafile="C:\Users\USER\Desktop\다변량\[다변량통계학] SAS실습 2\data\skull.csv" dbms=csv out=skull;
run;

/*예제 1*/
proc discrim data=income pool=test simple listerr out=local;
	class own;
	var income size;
	priors prop;
run;

proc print data=local;
run;

data test;
	input own income size xvalues $4-12;
cards;
. 60.5 19.5
. 79.0 18.0
;

proc discrim data=local testdata=test testlist;
	class own;
	testid xvalues;
	var income size;
run;

/*예제 2*/

proc discrim data=skull method=normal listerr/*오분류 된 것이 어디로 됐는지*/ out=local2;
	class group;
	var x1-x4;
run;


proc print data = local2; run; /*오분류 1에 들어갈 확률, 2에 들어갈 확률이 나옴*/

data test2;
	input group x1-x4 testvalue $4-20;
cards;
. 137 12 85 60
. 137 135 107 54
;

proc discrim data=local2 testdata=test2 testlist;
	class group;
	testid testvalue;
	var x1-x4;
run;
