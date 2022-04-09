clc
clear

n=3; % number of unknown values
a=[4 3 0;
   3 4 -1;
   0 -1 4];
b=[10, 8, 10]';
x=zeros(3,1); % setting up initial values x
tol=0.01; % erroes
fprintf('Gass Seidal method\n\n');
iter=0; % iteration initial number 0

while(1)
    iter=iter+1; 
    fprintf(' %2d ', iter-1);
    
    for i=1:n
        fprintf(' %10.4f ', x(i,1));
    end
    
    fprintf('\n');
    x_prev=x; % saving x before updating
    
    for i=1:n % rows
        temp=0;
        for j=1:n % columns
            if i~=j % non-diagonal elements
                temp=temp+a(i,j)*x(j,1); 
                % 1 row, a12*x2+a13*x3 
                % 2 row, a21*x1+a23*x3, x1 is updated one from upper line
                % 3 row, a31*x1+a32*x2, x1,x2 are updated ones from upper line
            end
        end
        x(i,1)=(-temp+b(i,1))/(a(i,i));
        % 1 row, (-a12*x2-a13*x3+b1)/a11
        % 2 row, (-a21*x1-a23*x3+b2)/a22, x1 is updated one from upper line
        % 3 row, (-a31*x1-a32*x2+b3)/a33, x1,x2 are updated ones from upper line
    end
    
    if abs(x-x_prev)  < tol %determine iteration
        break
    end
end
%print the results
for i=1:n
    fprintf(' %10.4f ', x(i,1));
end
    fprintf('\n');
