// Shaft params

inner_r = 10;
outer_r = 40;
top_h = 40;
bottom_h = 10;
bump = 10;
offset = 2;

// Slope params

slope_r = outer_r - inner_r;
scale_x = 1;
scale_y = (top_h - bottom_h)/slope_r;
scale_z = 1;

// Blade params

inflow_s = 6;
outflow_s = 3;
blades = 6;
blade_t = 8;
twist = 180;

// Blade cut params

b_slope_r = outer_r - (inner_r + inflow_s);
b_scale_x = 1;
b_scale_y = (top_h - (bottom_h + outflow_s))/b_slope_r;
b_scale_z = 1;

// Through hole

hole_d = 5;

// Make shit

difference(){
    difference(){
        union(){
            union(){
                rotate_extrude($fn=100) {
                    difference(){
                        square([outer_r, top_h]);
                        translate([inner_r+slope_r*scale_x, bottom_h+slope_r*scale_y, 0])
                        scale([scale_x,scale_y,scale_z])
                        circle(slope_r, $fn=100);
                    }
                }
                translate([0,0,top_h])
                cylinder(h=bump, r=inner_r-offset, center=true, $fn=100);
            }
            for (i = [0:blades-1]) {
                translate([0, 0, bottom_h])
                linear_extrude(height = top_h-bottom_h, convexity = 10, twist = twist, $fn=200)
                rotate([0, 30, i*360/blades])
                translate([-blade_t/2, 0, 0])
                square([blade_t, outer_r]);
            }
            rotate([0,0,720/blades])
            for (i = [0:blades-1]) {
                translate([0, 0, bottom_h])
                linear_extrude(height = (top_h-bottom_h)/2, convexity = 10, twist = twist/2, $fn=200)
                rotate([0, 30, 180/blades+i*360/blades])
                translate([-blade_t/2, 0, 0])
                square([blade_t, outer_r]);
            }
        }
        translate([0,0,top_h])
        rotate_extrude($fn=100) {
            translate([b_slope_r*b_scale_x+inner_r+inflow_s,0,0])
            scale([b_scale_x,b_scale_y,b_scale_z])
            circle(b_slope_r, $fn=100);
        }
    }
    translate([0, 0, .5*(top_h+bump)])
    cylinder(d=hole_d, 2*(top_h+bump), center=true, $fn=100);
}