clc
clear

fprintf('Modified False position method\n');
%x_l=input('lower bound = ? ');
%x_u=input('upper bound = ? ');
%tol_x=input('x tolerance = ? ');
%tol_y=input('y tolerance = ? ');
x_l = 1;
x_u = 2;
tol_x = 0.001;
tol_y = 0.00001;

fprintf(1,'\nlower bound = %d\n',x_l);
fprintf(1,'upper bound = %d\n',x_u);
fprintf(1,'x tolerance = %g\n',tol_x);
fprintf(1,'y tolerance = %g',tol_y);

% function values at the end of the interval
y_l=fun(x_l);
y_u=fun(x_u);

% check out the sign on f(a) and f(b)
if( y_l*y_u > 0 )
    fprintf(1,'Since ya*yb is positive, no root exists\n');
    return
else
    fprintf(1, '\n\n');
    fprintf(1,'iter  x_l  x_u  x_r  y_l  y_u  y_r\n');
    fprintf(1,'--------------------------------------------------------------------------\n');
    iter=0;
    x_r=0;
end

while(1)
    iter = iter + 1;
    x_r=(x_l*y_u - x_u*y_l) / (y_u - y_l); % calculate the root
    y_r=fun(x_r); % calculate the function value of the root
    fprintf(1,'%d %f %f %f %f %f %f\n',iter, x_l, x_u, x_r, y_l, y_u, y_r);
    temp = y_l;
    
    if(y_r * y_l < 0)
        if (abs(x_r - x_u) < tol_x || abs(y_r) < tol_y)
            fprintf(1,'\nTolerence is satisfied\n');
            fprintf(1,'Approximate solution x_r= %.7f \n', x_r); % finish all process when the error is small enough
            break
        else
            x_u = x_r;
            y_u = y_r;
            if(y_r * temp > 0)
                y_l = y_l / 2; 
            end
        end
    else
        if (abs(x_r - x_l) < tol_x || abs(y_l) < tol_y)
            fprintf(1,'\nTolerence is satisfied\n');
            fprintf(1,'Approximate solution x_r= %.7f \n', x_r); % finish all process when the error is small enough
            break
        else
            x_l = x_r;
            y_l = y_r;
            if(y_r * temp > 0)
                y_u = y_u / 2;
            end
        end
    end
end
            
    
    
            
            
            
            
            
            
            
            
            
    