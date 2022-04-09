function x=luf(n,a)

for i=1:n-1
    %맨 앞열의 계수가 가장 큰 행을 찾아서 i_max 라는 변수에 그 행값을 적어넣음
    i_max=i;
    for j=i+1:n
        if( abs(a(i_max,i)) < abs( a(j,i)) )
        i_max=j;
        end
    end
    %맨 앞열의 계수가 가장 큰 행을 맨 위로 올림
    if i_max ~= i
        for j_temp=1:n+1
            mat_temp=a(i,j_temp);
            a(i,j_temp)=a(i_max,j_temp);
            a(i_max,j_temp)=mat_temp;
        end
    end
end

l = eye(3,3);
A = a(1:3,1:3);
C = a(1:3,4);

for i=1:n-1
    for i_t=i+1:n
        %만약 맨위, 맨앞열의 계수가 0 이면 싱귤러 상황, 
        if A(i,i)==0
            fprintf('matrix is singular\n');
            break;
        end
        %다음열 계수들 변형시키는 계산
        r=A(i_t,i)/A(i,i);
        l(i_t,i) = r;
        for j_t=i:n
            A(i_t,j_t)=A(i_t,j_t)-r*A(i,j_t);
        end
    end
    % 다음 행으로 넘어가서 반복
end

%만약에 맨끝행, 맨끝열의 값이 0 이 나오면 싱귤러 상황, 답 없음
if (A(n,n)==0)
    fprintf('matrix is singular\n');
end

%foward elimination to find out y
y(1,1)= C(1,1);
for n_front=2:n
    vy = C(n_front,1);
    for k = 1:n_front-1
        vy = vy - l(n_front,k)*y(k,1);
    end
    y(n_front,1) = vy;
end

%backward elimination to find out x
x(n,1)= y(n,1)/A(n,n);
for n_back=n-1:-1:1
    vx=y(n_back,1);
    for k=n_back+1:n
        vx=vx-A(n_back,k)*x(k,1);
    end
    x(n_back,1)=vx/A(n_back,n_back);
end