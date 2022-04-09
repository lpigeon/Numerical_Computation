clc
clear

fprintf('Simple Fixed-Point Iteration\n');
%x_i=input('Initial point = ? ');
%tol=input('tolerance = ? ');
%iter=input('Iteration = ? ');
x_i = 0; %initail point
tol = 0.001;
iter = 100;
err_n = x_i;
fprintf(1,'\nInitial point = %d\n', x_i);
fprintf(1,'tolerance = %g\n', tol);
fprintf(1,'Max.Iteration = %d\n', iter);

syms g(x) %define g(x)
g(x) = fun2(x) + x; %make fun2(x) to x=g(x) format, so g(x) is exp(-x) and new function y = x
dg = diff(g, x); %differential g(x) is -exp(-x)

while(err_n ~= 100) % repeat enough times to verify the slope of differential g(x)
    dgi = dg(err_n);
    if(abs(dgi) > 1)
        fprintf(1,'Since x_r is divergence, no root exists\n');
        return
    else
        err_n = err_n + 1;
    end
end

x_r = 0;
count = 0;
fprintf(1, '\n\n');
fprintf(1,'iter   x_i   x_r\n');
fprintf(1,'--------------------------------------------------------------------------\n');
        
while(1)
    count = count + 1;
    x_r = g(x_i); % calculate the root
    fprintf(1,'%d %f %f\n',count,x_i,x_r);
    
    if(iter - count == 0)
        fprintf(1,'\nIteration is over\n');
        fprintf(1,'Since x_r is divergence, no root exists\n'); 
        break
    elseif(abs(x_r - x_i) < tol)
        fprintf(1,'\nTolerence is satisfied\n');
        fprintf(1,'Approximate solution x_r= %.7f \n', x_r); 
        break
    else
        x_i = x_r; % update x_i of the new value
    end
end


    
    


