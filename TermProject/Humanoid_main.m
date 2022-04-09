clc
clear
close all

% 이 코드는 수치계산으로 로봇 다리 관절 값을 구하고 난 뒤 그 관절 값을 아래 theta 행렬에 입력하면 다리의 모양이 그려지는 코드임
% theta 는 다리 관절의 각도 행렬이며 순서 대로 각각 Hip pitch, Hip roll, Hip yaw, Knee, Ankle pitch, Ankel roll 관절 값을 나타냄 

%초기값 및 허용 오차
th1 = 0; th2 = 0; th3 = 0; th4 = 0; th5 = 0; th6 = 0;
tol = 0.001;
%그래프를 위한 변수와 종료 변수
pose = 1; 
stair = 0;
point = 1;
finish = 1;

while(finish)
    %목표 위치값
    T1 = [1 0 0 0; 0 1 0 0; 0 0 1 -0.54; 0 0 0 1];
    T2 = [1 0 0 0; 0 1 0 -0.12; 0 0 1 -0.54; 0 0 0 1];
    T3 = [1 0 0 0; 0 1 0 -0.14; 0 0 1 -0.45; 0 0 0 1];
    T4 = [1 0 0 0.15; 0 1 0 -0.14; 0 0 1 -0.45; 0 0 0 1];
    T5 = [1 0 0 0.15; 0 1 0 0; 0 0 1 -0.45; 0 0 0 1];
    T6 = [1 0 0 0.15; 0 1 0 0.12; 0 0 1 -0.5; 0 0 0 1];
    T7 = [1 0 0 0; 0 1 0 0.12; 0 0 1 -0.54; 0 0 0 1];
    
    %목표 위치값을 3차원 배열로 종합
    Pose_T(:,:,1) = T1;
    Pose_T(:,:,2) = T2;
    Pose_T(:,:,3) = T3;
    Pose_T(:,:,4) = T4;
    Pose_T(:,:,5) = T5;
    Pose_T(:,:,6) = T6;
    Pose_T(:,:,7) = T7;
    
    %theta배열 정의 및 theta값 저장
    theta = [th1; th2; th3; th4; th5; th6];
    th1_p = th1; th2_p = th2; th3_p = th3; th4_p = th4; th5_p = th5; th6_p = th6;
    theta_p = [th1_p; th2_p; th3_p; th4_p; th5_p; th6_p];
    
    % GetDHTransform( 링크의 길이(m), 링크의 비틀림 각도(rad), 조인트의 옵셋 길이(m), 조인트의 구동 각도(rad))
    Tg0 = [0 -1 0 0;0 0 1 0;-1 0 0 0;0 0 0 1];
    T01 = GetDHTransform( 0.0,  pi/2,   0.0,   theta(1)); % Hip pitch  변환
    T12 = GetDHTransform( 0.0,   -pi/2,   0.0,   theta(2)+pi/2); % Hip roll 변환
    T23 = GetDHTransform( 0.0,   -pi/2,   -0.225,   theta(3)-pi/2); % Hip yaw 변환
    T34 = GetDHTransform( 0.225,  0,   0.0,   theta(4)+pi/2); % Knee 변환
    T45 = GetDHTransform( 0.0,   pi/2,   0.0,   theta(5)); % Ankel pitch 변환
    T56 = GetDHTransform( 0.15,   0.0,   0.0,   theta(6)); % Ankle roll 변환
    T6f = [0 0 -1 0;0 1 0 0;1 0 0 0;0 0 0 1]; % plate 변환

    %연속 변환
    Tg1 = Tg0*T01; % 좌표계 회전변환 및 Hip pitch 변환
    Tg2 = Tg1*T12; % 원점에서 =>  Hip roll 변환
    Tg3 = Tg2*T23; % 원점에서 => Hip yaw 변환
    Tg4 = Tg3*T34; % 원점에서 => Knee 변환
    Tg5 = Tg4*T45; % 원점에서 => Ankel pitch 변환
    Tg6 = Tg5*T56; % 원점에서 => Ankle roll변환
    Tgf = Tg6*T6f; % plate 좌표계 회전 변환
    
    %6개의 theta에 대한 자코비안 정의
    J = GetJacobian(th1,th2,th3,th4,th5,th6);
  
    %연립방정식 함수 정의
    F = Tgf - Pose_T(:,:,pose);
    F_M = [F(1,1); F(2,2); F(3,3); F(1,4); F(2,4); F(3,4)];
    
    %오차 적용 범위 지정
    F_tol = F(1:3,1:4);
    
    %theta 값 업데이트
    theta = theta_p - J\F_M;
    %theta 값 보정
    if(theta(1) > 1.0e+14 * 4.3550)
        theta = theta / 1.0e+15;
    end
    th1 = theta(1); th2 = theta(2); th3 = theta(3); th4 = theta(4); th5 = theta(5); th6 = theta(6);
    
    %목표위치에 도달
    if(abs(F_tol) < tol)
        % 목표 위치 확인용
        %fprintf('Pose %d',pose)
        %Tgf
        %theta
        
        % 원점
        origin_pos = zeros(3);

        % Knee 의 위치
        knee_pos = [Tg3(1,4), Tg3(2,4), Tg3(3,4)];

        % Ankle 의 위치
        anke_pos = [Tg4(1,4), Tg4(2,4), Tg4(3,4)];

        % Foot 의 위치
        foot_pos = [Tgf(1,4), Tgf(2,4), Tgf(3,4)];

        % position 
        f_l=0.15;
        f_w=0.1;
        foot_l_up=[f_l;f_w;0];
        foot_l_bt=[-f_l;f_w;0];
        foot_r_up=[f_l;-f_w;0];
        foot_r_bt=[-f_l;-f_w;0];

        foot_rotation_l_up=Tgf(1:3,1:3)*foot_l_up;
        foot_rotation_l_bt=Tgf(1:3,1:3)*foot_l_bt;
        foot_rotation_r_up=Tgf(1:3,1:3)*foot_r_up;
        foot_rotation_r_bt=Tgf(1:3,1:3)*foot_r_bt;

        foot_position_l_up = foot_rotation_l_up' + foot_pos;
        foot_position_l_bt = foot_rotation_l_bt' + foot_pos;
        foot_position_r_up = foot_rotation_r_up' + foot_pos;
        foot_position_r_bt = foot_rotation_r_bt' + foot_pos;

        face_foot=[foot_position_l_up; foot_position_l_bt; foot_position_r_up; foot_position_r_bt];
        face=[1 2 4 3];

        %그래프 그리기
       
        % subplot(19,19,point)
        axis([-1.0 1.0 -1.0 1.0 -1.0 1.0])
        line([origin_pos(1) knee_pos(1)],[origin_pos(2) knee_pos(2)],[origin_pos(3) knee_pos(3)],'Linewidth',5,'Color','r') % 허벅지 그리기 
        line([knee_pos(1) anke_pos(1)],[knee_pos(2) anke_pos(2)],[knee_pos(3) anke_pos(3)],'Linewidth',5,'Color','bl') % 종아리 그리기
        line([anke_pos(1) foot_pos(1)],[anke_pos(2) foot_pos(2)],[anke_pos(3) foot_pos(3)],'Linewidth',5,'Color','k') % 발 그리기
        patch('Faces',face,'Vertices',face_foot,'Facecolor',[0.8 0.8 1]);
        view(45,30)
        grid on
        point = point + 1;
        pose = pose + 1;
        
        %50개의 계단을 올라간 뒤에 1번위치로 이동
        if(stair == 50)
            finish = 0; %종료
        elseif(pose == 8)
            stair = stair + 1;
            pose = 1;
            fprintf("Stair %d Complete \n",stair)
        end
    end
end
   


