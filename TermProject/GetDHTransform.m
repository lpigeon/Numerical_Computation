function T = GetDHTransform( link_length_m, link_twist_rad, joint_offset_m, joint_angle_rad )

l = link_length_m;
a = link_twist_rad;
d = joint_offset_m;
th = joint_angle_rad;

T = [cos(th)  -sin(th)*cos(a)   sin(th)*sin(a)  l*cos(th);
     sin(th)   cos(th)*cos(a)  -cos(th)*sin(a)  l*sin(th);
          0            sin(a)           cos(a)          d;
          0                0                0           1];


end

% T 행렬의 1행 4열은 x 좌표
% T 행렬의 2행 4열은 y 좌표
% T 행렬의 3행 4열은 z 좌표
