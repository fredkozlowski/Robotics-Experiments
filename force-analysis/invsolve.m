l1 = 40.152;
l2 = 30;
l3 = 44.398;
l4 = 40;
theta1 = 33.3;
theta2 = 130;
theta3 = 46.58;
theta4 = 123.93;
w1 = 0;
w2 = 1;
w3 = 0.073187;
w4 = 0.76359;
v1x = 0;
v2x = w2*l2/2*cosd(theta2-90);
v3x = v2x*2+w3*l3/2*cosd(theta3-90);
v4x = w4*l4/2*cosd(theta4-90);
v1y = 0;
v2y = w2*l2/2*sind(theta2-90);
v3y = v2y*2+w3*l3/2*sind(theta3-90);
v4y = w4*l4/2*sind(theta4-90);
alpha1 = 0;
alpha2 = 1;
alpha3 = 0.2246;
alpha4 = 0.72695;
a1x = 0;
a2x = alpha2 * l2/2*cosd(theta2-90);
a3x = a2x * 2 + alpha3 * l3/2 * cosd(theta3-90) - w3*w3 * l3/2;
a4x = alpha4 * l4/4*cosd(theta4-90);
a1y = 0;
a2y = alpha2 * l2/2*sind(theta2-90);
a3y = a2y * 2 + alpha3 * l3/2 * sind(theta3-90) - w3*w3 * l3/2;
a4y = alpha4 * l4/4*sind(theta4-90);
m2 = 0.003;
m3 = 0.004;
m4 = 0.0047;
i2 = m2/12*(0.01^2 + l2^2);
i3 = m3/12*(0.01^2 + l3^2);
i4 = m4/12*(0.01^2 + l4^2);

syms M2 P12x P12y P32x P32y P43x P43y P14x P14y
E1 = P12x + P32x == m2 * a2x;
E2 = P12y + P32y == m2 * a2y;
E3 = P12x * l2/2 * sind(theta2) - P12y * l2/2 * cosd(theta2) - P32x * l2/2 * sind(theta2) + P32y * l2/2 * cosd(theta2) + M2 == i2 * alpha2;

E4 = -P32x + P43x == m3 * a3x;
E5 = -P32y + P43y == m3 * a3y;
E6 = P43x * l3/2 * sind(theta3) + P43y * l3/2 * cosd(theta3) - P32x * l3/2 * sind(theta3) + P32y * l3/2 * cosd(theta3) + 5 * l3/2 == i3 * alpha3;

E7 = -P43x + P14x == m4 * a4x;
E8 = -P43y + P14y == m4 * a4y;
E9 = P43x * l4/2 * sind(theta4) - P43y * l4/2 * cosd(theta4) + P14x * l4/2 * sind(theta4) - P14y * l4/2 * cosd(theta4) == i4 * alpha4;

[M2, P12x, P12y, P32x, P32y, P43x, P43y, P14x, P14y] = vpasolve(E1,E2,E3,E4,E5,E6,E7,E8,E9, M2, P12x, P12y, P32x, P32y, P43x, P43y, P14x, P14y)
