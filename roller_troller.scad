/*
Hollow Roller Troller
by: bdharva, 2016-03-28
*/

// Cylinder parameters
height = 30;
diameter = 5;

// Rounded cube parameters
cube_d = 15;
sphere_d = 10;

// Shell paramters
thickness = 2;

// Hollow roller troller
difference() {
    // Hollow rounded cube
    difference() {
        // Outer rounded cube
        intersection() {
            color([0,0,1])
            sphere(sphere_d, $fn = 100);
            color([1,0,0])
            cube(size = cube_d, center = true);
        }
        // Inner rounded cube
        intersection() {
            color([1,1,0])
            sphere(sphere_d-thickness, $fn = 100);
            color([1,1,0])
            cube(size = cube_d-thickness, center = true);
        }
    }
    // Three-axis cylinders
    union() {
        rotate([0,90,0])
        color([0,1,0])
        cylinder(height,diameter,diameter, center = true, $fn = 100);
        rotate([90,0,0])
        color([0,1,0])
        cylinder(height,diameter,diameter, center = true, $fn = 100);
        color([0,1,0])
        cylinder(height,diameter,diameter, center = true, $fn = 100);
    }
}