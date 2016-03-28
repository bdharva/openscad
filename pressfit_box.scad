/*
Pressfit Box
by: bdharva, 2016-03-28
*/

w = 40;
l = 30;
h = 15;
radius = 5;
thickness = 2;
inset = 0;
shrink_factor = .01;
tolerance = .1;

color([0.95,0.95,0.95])
difference() {
    difference() {
        linear_extrude(height = h)
        minkowski() {
            square([w-2*radius, l-2*radius], center = true);
            circle(r=radius, $fn = 100);
        }
        translate([0,0,thickness])
        linear_extrude(height = h)
        if ( radius > thickness ) {
            minkowski() {
                color([0, 1, 0])
                square([(w-2*thickness)-2*(radius-thickness), (l-2*thickness)-2*(radius-thickness)], center = true);
                circle(r=radius-thickness, $fn = 100);
            }
        } else {
            square([(w-2*thickness)-2*(radius-thickness), (l-2*thickness)-2*(radius-thickness)], center = true);
        }
    }
    translate([0, 0, h-(thickness+inset)])
    linear_extrude(height = h-(thickness+inset))
    minkowski() {
        square([w-thickness-2*(radius-(thickness/2)), l-thickness-2*(radius-(thickness/2))], center = true);
        circle(r=radius-(thickness/2), $fn = 100);
    }
}
color([0.3,0.4,0.5])
// Uncomment to place lid on the box
/*
translate([0, l, h-inset])
rotate([180, 0, 0])
*/
difference() {
    union() {
        translate([0, l, 0])
        linear_extrude(height = thickness)
        minkowski() {
            square([w-thickness-2*(radius-(thickness/2)), l-thickness-2*(radius-(thickness/2))], center = true);
            circle(r=radius-(thickness/2), $fn = 100);
        }
        translate([0, l, thickness])
        linear_extrude(height = thickness/2)
        if ( radius > thickness ) {
            minkowski() {
                square([w-2*thickness-2*(radius-(thickness/2)), l-2*thickness-2*(radius-(thickness/2))], center = true);
                circle(r=radius-(thickness/2), $fn = 100);
            }
        } else {
            square([w-2*thickness, l-2*thickness], center = true);
        }
    }
    translate([0, l, thickness])
    linear_extrude(height = thickness)
    if ( radius > 1.5*thickness ) {
        minkowski() {
            square([w-3*thickness-2*(radius-(thickness/2)), l-3*thickness-2*(radius-(thickness/2))], center = true);
            circle(r=radius-(thickness/2), $fn = 100);
        }
    } else {
        square([w-3*thickness, l-3*thickness], center = true);
    }
}