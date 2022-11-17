
proc import datafile= "C:\Users\USER\Desktop\�ٺ���\data\iris1.csv" dbms = csv out = iris;
getnames = yes;
guessingrows = max;
run;

ods pdf file = "C:\Users\USER\Desktop\�ٺ���\report.pdf";

proc reg data = iris;
model sepal_length = sepal_width; run;

ods pdf close;




/*IML�ǽ�*/
/*��Ʈ���� ����*/

proc iml;
A = {1 2, 3 4}
C = 3
D = C * A;
print D;
run;


/*��Ŀ���*/
proc iml;
A = {1 2, 3 4};
B = I(nrow(A));
C = A + B;
print B C; run;

proc iml;
A = {1 2. 3 4};
B = {2 0, 2 0};
C = A*B;
print C; run;

/*elementwise�� ������ -> ���� ��ġ�� ���ҳ��� ������*/
proc iml;
A = {1 2. 3 4};
B = {2 0, 2 0};
C = A#B;
print A, B, C; run;

/*elementwise�� ������ -> ���� ��ġ�� ���ҳ��� power ����*/
proc iml;
A = {1 2. 3 4};
B = {2 0, 2 0};
C = A##B;
print A, B, C; run;

proc iml;
A = {1 2, 3 4}
A_trans = A`;
A_eigen = eigval(A)[,1]; /*ù��° ���� �����ϱ� ���ؼ� [,1] �� ����*/
print A; run;


data one;
input x1 x2 x3;
cards;
2 1 1
2 1 0
-1 -2 -1
;
run;

proc iml;
use one; /*one�� �����ͼ�*/
read all into A; /*iml���� A��� ������*/
call eigen (val, vec, A); /*value, vector value�� ���͸� ���� ��Ʈ���� ����*/
print val, vec;
run;

/*�б�����*/

proc iml;
use one;
read all into A;
call eigen (val, vec, A); /*������ ����, �������� ����, */
val = diag(val[,1]); /*�밢��ķ� ����� ���� diag�� ����*/
A_2 = vec * val * inv(vec); /*�б����� ��������P * ���������� �̷���� �밢��� * ��������P�� �ι���*/
print A, A_2;
run;
