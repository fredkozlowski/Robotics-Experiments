l1 = 40.152;
l2 = 30;
l3 = 44.398;
l4 = 40;
theta1 = 33.3;
theta2 = 130;
w2 = 1;
w1 = 0;
a2 = 1;
a1 = 0;

syms theta3 theta4
E1 = l2*cosd(theta2) + l3*cosd(theta3) - l4*cosd(theta4) -l1*cosd(theta1) == 0;
E2 = l2*sind(theta2) + l3*sind(theta3) - l4*sind(theta4) -l1*sind(theta1) == 0;

[theta3, theta4] = solve(E1,E2,theta3, theta4)
vpa(theta3)
vpa(theta4)

theta3 = vpa(theta3(1, :))
theta4 = vpa(theta4(1, :))


syms w3 w4
E3 = l2*cosd(theta2)*w2 + l3*cosd(theta3)*w3 - l4*cosd(theta4)*w4 -l1*cosd(theta1)*w1 == 0;
E4 = -l2*sind(theta2)*w2 - l3*sind(theta3)*w3 + l4*sind(theta4)*w4 +l1*sind(theta1)*w1 == 0;

[w3, w4] = solve(E3,E4, w3, w4)

syms a3 a4
E5 = l2*cosd(theta2)*a2 -l2*sind(theta2)*w2*w2 + l3*cosd(theta3)*a3 - l3*sind(theta3)*w3*w3 - l4*cosd(theta4)*a4 +l4*sind(theta4)*w4*w4 == 0; 
E6 = -l2*sind(theta2)*a2 -l2*cosd(theta2)*w2*w2 - l3*sind(theta3)*a3 - l3*cosd(theta3)*w3*w3 + l4*sind(theta4)*a4 +l4*cosd(theta4)*w4*w4 == 0; 

[a3, a4] = solve(E5,E6, a3, a4)


