// Shaft params

wall_t = 1.2;
inner_r = 2.4;
outer_r = 15;
top_h = 15;
bottom_h = wall_t;
hole_r = inner_r-wall_t;

// Slope params

slope_r = outer_r - inner_r;
scale_x = 1;
scale_y = (top_h - bottom_h)/slope_r;
scale_z = 1;

// Blade params

inflow_s = 8;
outflow_s = 2;
blades = 8;
half_blades = true;
blade_t = wall_t;
twist = 60;

// Blade cut params

b_slope_r = outer_r - (inner_r + inflow_s);
b_scale_x = 1;
b_scale_y = (top_h - (bottom_h + outflow_s))/b_slope_r;
b_scale_z = 1;

// Shell params

shell_r = 10;
airgap2 = (outer_r-inner_r)/2;

// Knob params

airgap = 1;
knob_g = 4;
knob_r1 = inner_r+inflow_s/2-knob_g/2;
knob_r2 = inner_r+inflow_s/2+knob_g/2;
knob_h1 = knob_g;
knob_h2 = knob_g;

// Make shit

module impeller() {
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
                }
                for (i = [0:blades-1]) {
                    translate([0, 0, bottom_h])
                    linear_extrude(height = top_h-bottom_h, convexity = 10, twist = twist, $fn=200)
                    rotate([0, 30, i*360/blades])
                    translate([-blade_t/2, 0, 0])
                    square([blade_t, outer_r]);
                }
                if (half_blades == true) {
                    rotate([0,0,720/blades])
                    for (i = [0:blades-1]) {
                        translate([0, 0, bottom_h])
                        linear_extrude(height = (top_h-bottom_h)/2, convexity = 10, twist = twist/2, $fn=200)
                        rotate([0, 30, 180/blades+i*360/blades])
                        translate([-blade_t/2, 0, 0])
                        square([blade_t, outer_r]);
                    }
                }
            }
            translate([0,0,top_h])
            rotate_extrude($fn=100) {
                translate([b_slope_r*b_scale_x+inner_r+inflow_s,0,0])
                scale([b_scale_x,b_scale_y,b_scale_z])
                circle(b_slope_r, $fn=100);
            }
        }
        translate([0, 0, .5*top_h])
        cylinder(r=hole_r, 2*top_h, center=true, $fn=100);
    }
}

module knob() {
    union() {
        translate([0, 0, top_h+airgap])
        cylinder(h=knob_h1, r1=knob_r1, r2=knob_r2, $fn=100);
        translate([0, 0, top_h+airgap+knob_h1])
        rotate_extrude($fn=100) {
            scale([1, knob_h2/knob_r2, 1])
            difference() {
                circle(r=knob_r2);
                translate([-knob_r2, -knob_r2, 0])
                square([2*knob_r2, knob_r2]);
                rotate([0, 0, -90])
                translate([-knob_r2, -knob_r2, 0])
                square([2*knob_r2, knob_r2]);
            }
        }
    }
}

module cylinder_blank() {
    union() {
        difference() {
            difference() {
                cylinder(h=top_h+airgap+knob_h1, r=outer_r+airgap2+wall_t, $fn=100);
                translate([0, 0, -wall_t])
                cylinder(h=top_h+airgap+knob_h1, r=outer_r+airgap2, $fn=100);
            }
            cylinder(h=top_h*2, r=knob_r2+knob_g/2, $fn=100);
        }
        translate([0, 0, top_h+airgap])
        difference() {
            cylinder(h=knob_h1, r1=knob_r1+knob_g/2+wall_t, r2=knob_r2+knob_g/2+wall_t, $fn=100);
            translate([0, 0, -1])
            cylinder(h=knob_h1+2, r1=knob_r1+knob_g/2-1, r2=knob_r2+knob_g/2+1, $fn=100);
        }
    }
}

module square_blank() {
    union() {
        difference() {
            difference() {
                linear_extrude(top_h+airgap+knob_h1) {
                    minkowski() {
                        square(outer_r*2+airgap2*2+wall_t*2-shell_r*2, center=true);
                        circle(shell_r, $fn=100);
                    }
                }
                translate([0, 0, -wall_t])
                cylinder(h=top_h+airgap+knob_h1, r=outer_r+airgap2, $fn=100);
            }
            cylinder(h=top_h*2, r=knob_r2+knob_g/2, $fn=100);
        }
        translate([0, 0, top_h+airgap])
        difference() {
            cylinder(h=knob_h1, r1=knob_r1+knob_g/2+wall_t, r2=knob_r2+knob_g/2+wall_t, $fn=100);
            translate([0, 0, -1])
            cylinder(h=knob_h1+2, r1=knob_r1+knob_g/2-1, r2=knob_r2+knob_g/2+1, $fn=100);
        }
    }
}

module rounded_inner() {
    rad1 = knob_r2+knob_g/2;
    rad2 = outer_r+airgap2-rad1;
    top = top_h+airgap+knob_h1-wall_t;
    rotate_extrude($fn=100) {
        difference() {
            translate([rad1, 0, 0])
            square([rad2, top]);
            translate([rad1, 0, 0])
            scale([1, top/rad2, 1])
            circle(rad2);
        }
    }
}
module rounded_outer() {
    rad1 = knob_r2+knob_g/2+wall_t;
    rad2 = outer_r+airgap2+wall_t-rad1;
    top = top_h+airgap+knob_h1;
    rotate_extrude($fn=100) {
        difference() {
            translate([rad1, 0, 0])
            square([rad2+1, top+1]);
            translate([rad1, 0, 0])
            scale([1, top/rad2, 1])
            circle(rad2);
        }
    }
}
module square_shell() {
    union() {
        square_blank();
        rounded_inner();
    }
}
module cylinder_shell() {
    union() {
        cylinder_blank();
        rounded_inner();
    }
}
module rounded_shell() {
    difference() {
        union() {
            cylinder_shell();
            rounded_inner();
        }
        rounded_outer();
    }
}

!impeller();
knob();
square_shell();