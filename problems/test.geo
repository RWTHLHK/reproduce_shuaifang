//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {1, 0, 0, 1.0};
//+
Point(3) = {-0.4, 0.9, 0, 1.0};
//+
Recursive Delete {
  Point{1}; Point{2}; 
}
//+
Recursive Delete {
  Point{3}; 
}
//+
Point(1) = {-0, 0, 0, 1.0};
//+
Point(2) = {0.5, 0, 0, 1.0};
//+
Point(3) = {1, 0, 0, 1.0};
//+
Point(4) = {1, 0.5, 0, 1.0};
//+
Point(5) = {1, 1, 0, 1.0};
//+
Point(6) = {0.5, 1, 0, 1.0};
//+
Point(7) = {0, 1, 0, 1.0};
//+
Point(8) = {0, 0.5, 0, 1.0};
//+
Point(9) = {0.5, 0.5, 0, 1.0};
//+
Point(10) = {-0, 0.5, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 5};
//+
Line(5) = {5, 6};
//+
Line(6) = {6, 7};
//+
Line(7) = {7, 8};
//+
Line(8) = {8, 9};
//+
Line(9) = {9, 10};
//+
Line(10) = {10, 1};
//+
Line(11) = {9, 6};
//+
Line(12) = {9, 4};
//+
Line(13) = {9, 2};

//+
Curve Loop(1) = {7, 8, 11, 6};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {11, -5, -4, -12};
//+
Plane Surface(2) = {2};
//+
Curve Loop(3) = {1, -13, 9, 10};
//+
Plane Surface(3) = {3};
//+
Curve Loop(4) = {13, 2, 3, -12};
//+
Plane Surface(4) = {4};
//+
Physical Curve("bottom", 15) = {1, 2};
//+
Physical Curve("right", 16) = {3, 4};
//+
Physical Curve("top", 17) = {6, 5};
//+
Physical Curve("left", 18) = {7, 10};
//+
Physical Surface("block", 19) = {1, 2, 4, 3};
//+
Physical Curve("crack_interface1", 20) = {8};
//+
Physical Curve("crack_interface2", 21) = {9};
//+
Show "*";
//+
Transfinite Curve {1, 2, 3, 4, 5, 6, 7, 8, 10, 9, 13, 11, 12} = 51 Using Progression 1;
//+
Transfinite Surface {1};
//+
Transfinite Surface {2};
//+
Transfinite Surface {3};
//+
Transfinite Surface {4};
