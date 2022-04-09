clc
clear

fprintf('Newton-Raphson method\n');
%x_n=input('Inital point = ?');
%tol_x=input('x tolerance = ? ');
%tol_y=input('y tolerance = ? ');
x_n = 1.5;
tol_x = 0.001;
tol_y = 0.00001;
iter = 100;
count = 0;

fprintf(1,'\nInitial point = %g\n',x_n);
fprintf(1,'x tolerance = %g\n',tol_x);
fprintf(1,'y tolerance = %g\n',tol_y);
fprintf(1,'Max.Iteration = %d\n', iter);

syms f(x) %define f(x)
f(x) = fun(x); 
df = diff(f, x); %differential f(x) is 3*x^2 - 2*x -1

fprintf(1, '\n\n');
fprintf(1,'iter  x_n  x_r  x_r\n');
fprintf(1,'--------------------------------------------------------------------------\n');

while(1)
    count = count + 1;
    x_r = x_n - (f(x_n) / df(x_n)); % calculate the root
    fprintf(1,'%d %f %f \n',count, x_n, x_r);
    
    if(iter - count == 0) %max iteration
        fprintf(1,'\nIteration is over\n');
        fprintf(1,'Since x_r is divergence, no root exists\n'); 
        break
    elseif(abs(x_r - x_n) < tol_x || abs(f(x_r)) < tol_y) % finish all process when the error is small enough
        fprintf(1,'\nTolerence is satisfied\n');
        fprintf(1,'Approximate solution x_r = %.7f \n', x_r); 
        break
    else
        x_n = x_r; % update x_n of the new value
    end
end


