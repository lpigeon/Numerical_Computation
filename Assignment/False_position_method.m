clc
clear
fprintf('False position method\n');
%x_l=input('lower bound = ? ');
%x_u=input('upper bound = ? ');
%tol_x=input('x tolerance = ? ');
%tol_y=input('y tolerance = ? ');
x_l = 1;
x_u = 2;
tol_x = 0.001;
tol_y = 0.00001;
% function values at the end of the interval
y_l=fun(x_l);
y_u=fun(x_u);
% check out the sign on f(a) and f(b)
if( y_l*y_u > 0 )
    fprintf(1,'Since ya*yb is positive, no root exists\n');
    return
    
else
    fprintf(1, '\n\n');
    fprintf(1,'iter x_l x_u x_r y_l y_u y_r\n');
    fprintf(1,'--------------------------------------------------------------------------\n');
    iter=0;
    x_r=0;
end

while(1)
    iter=iter+1;
    x_r=(x_l*y_u - x_u*y_l) / (y_u - y_l); % calculate the root
    y_r=fun(x_r); % calculate the function value of the root
    fprintf(1,'%d %f %f %f %f %f %f\n',iter, x_l, x_u,x_r, y_l,y_u,y_r);
    if (y_l*y_r<0) % decide the side (right)
        if(abs(x_r-x_u)<tol_x || abs(y_r)<tol_y ) % finish all process when the error is small enough
            fprintf(1,'\nTolerence is satisfied\n');
            fprintf(1,'Approximate solution x_r= %.7f \n', x_r); 
            break 
        else
            x_u=x_r; % update the upper x of the new section (root=>upper x, new root will be left hand side)
            y_u=y_r; % update the upper function value of the new section (the y of the root => upper y)
        end
    else % decide the side (left)
        if(abs(x_l-x_r)<tol_x || abs(y_r)<tol_y ) % finish all process when the error is small enough
            fprintf(1,'\nTolerence is satisfied\n');
            fprintf(1,'Approximate solution x_r= %.7f \n', x_r);
            break
        else
            x_l=x_r; % update the lower x of the new section (root=>lower x)
            y_l=y_r; % update the lower function value of the new section (the y of the root => lower y)
        end 
    end 
end