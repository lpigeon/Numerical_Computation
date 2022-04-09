clc
clear

a=[0 -1 2 4;
-2 2 -1 -1;
-2 4 3 15];
%a=[-2 1 0 2;
%1 0 1 3;
%0 -1 2 1];
n=3;
%변수의 개수n 과 원래 행열 a를입력 받으면 Gauss Elimination 된 형태의 행렬 a_new를 계산
a_new = luf(n,a);
fprintf('final Solution\n');
fprintf('----------------\n');
fprintf(' i x(i) \n');
fprintf('----------------\n');

for i=1:1:n
    fprintf(' %d %f \n', i,a_new(i,1));
end
fprintf('----------------\n');