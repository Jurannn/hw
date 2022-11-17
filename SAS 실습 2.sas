proc import datafile="C:\Users\USER\Desktop\�ٺ���\[�ٺ��������] SAS�ǽ� 2\data\roots.csv" dbms=csv out=roots replace;
run;

proc print data=roots;
run;

/*��� ����*/
proc means data=roots mean maxdec=2;
	class stock;
run;

/*�ڽ� �׸� -> ��� �� ���̸� �ð������� ���� ���ؼ�*/
proc univariate data=roots plot;
	var girth4 growth girth15 weight;
	by stock;
run;

/*�Ϻ��� �л�м�*/
proc anova data=roots;
	class stock; /*stock�� �׷����� �Ѵ�*/
	model girth4 growth girth15 weight = stock;
	means stock;
run;

proc anova data=roots;
	class stock;
	model girth4 growth girth15 weight = stock;
	means stock / hovtest welch; /*hovtest - ��л����, ��л꼺�� �������� �ʴ� ��� - welch�� ���*/
run;

/*�ٺ��� �л�м�*/

proc anova data=roots;
	class stock;
	model girth4 growth girth15 weight = stock;
	manova h = stock;
run;

/*�Ǻ��м�*/

proc import datafile="C:\Users\USER\Desktop\�ٺ���\[�ٺ��������] SAS�ǽ� 2\data\income.csv" dbms=csv out=income;
run;

proc import datafile="C:\Users\USER\Desktop\�ٺ���\[�ٺ��������] SAS�ǽ� 2\data\skull.csv" dbms=csv out=skull;
run;

/*���� 1*/
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

/*���� 2*/

proc discrim data=skull method=normal listerr/*���з� �� ���� ���� �ƴ���*/ out=local2;
	class group;
	var x1-x4;
run;


proc print data = local2; run; /*���з� 1�� �� Ȯ��, 2�� �� Ȯ���� ����*/

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
