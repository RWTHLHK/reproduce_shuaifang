//+
Point(1) = {0, 0, 0, 1e-2};
//+
Point(2) = {1, 0, 0, 1e-2};
//+
Point(3) = {1, 1, 0, 1e-2};
//+
Point(4) = {0, 1, 0, 1e-2};
//+
Point(5) = {0, 0.5, 0, 1e-2};
//+
Point(6) = {0.5, 0.5, 0, 1e-2};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 5};
//+
Line(5) = {5, 1};
//+
Line(6) = {5, 6};
//+
Line(7) = {5, 6};
//+
Curve Loop(1) = {1, 2, 3, 4, 6, -7, 5};
//+
Plane Surface(1) = {1};
//+
Physical Curve("bottom", 8) = {1};
//+
Physical Curve("top", 9) = {3};
//+
Physical Curve("right", 10) = {2};
//+
Physical Curve("left1", 11) = {4};
//+
Physical Curve("left2", 12) = {5};
//+
Physical Curve("crack_interface1", 13) = {6};
//+
Physical Curve("crack_interface2", 14) = {7};
//+
Physical Surface("block", 0) = {1};
//+
Transfinite Curve {1, 2, 3} = 101 Using Progression 1;
//+
Transfinite Curve {4, 5} = 51 Using Progression 1;
