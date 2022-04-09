function a=gauss(n,a)

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
    for i_t=i+1:n
        %만약 맨위, 맨앞열의 계수가 0 이면 싱귤러 상황, 
        if a(i,i)==0
            fprintf('matrix is singular\n');
            break;
        end
        %다음열 계수들 변형시키는 계산
        r=a(i_t,i)/a(i,i);
        for j_t=i:n+1
            a(i_t,j_t)=a(i_t,j_t)-r*a(i,j_t);
        end
    end
    % 다음 행으로 넘어가서 반복
end

%만약에 맨끝행, 맨끝열의 값이 0 이 나오면 싱귤러 상황, 답 없음
if (a(n,n)==0)
    fprintf('matrix is singular\n');
end

%맨 끝의 답 먼저 계산
a(n,n+1)= a(n,n+1)/a(n,n);
%나머지 답 계산
for n_back=n-1:-1:1
    va=a(n_back,n+1);
    for k=n_back+1:n
        va=va-a(n_back,k)*a(k,n+1);
    end
    a(n_back,n+1)=va/a(n_back,n_back);
end