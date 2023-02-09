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
Line(3) = {4, 4};
//+
Line(4) = {3, 4};
//+
Line(5) = {4, 5};
//+
Line(6) = {5, 1};
//+
Line(7) = {5, 6};
//+
Curve Loop(1) = {6, 1, 2, 4, 5};
//+
Plane Surface(1) = {1};
//+
Physical Curve("bottom", 8) = {1};
//+
Physical Curve("top", 9) = {4};
//+
Physical Curve("right", 10) = {2};
//+
Physical Curve("left1", 11) = {5};
//+
Physical Curve("left2", 12) = {6};
//+
Physical Curve("crack_interface1", 13) = {7};
//+
Transfinite Curve {1, 2, 4} = 101 Using Progression 1;
//+
Transfinite Curve {5, 6} = 51 Using Progression 1;
