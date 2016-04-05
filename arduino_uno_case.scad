// Board
ard_w = 53.3;
ard_l = 68.6;
ard_hole_d = 3.2;
ard_hole1_x = 14;
ard_hole1_y = 2.5;
ard_hole2_x = 15.3;
ard_hole2_y = 50.7;
ard_hole3_x = 66.1;
ard_hole3_y = 7.6;
ard_hole4_x = 66.1;
ard_hole4_y = 35.5;
ard_board_t = 1.6;

// Headers
row1_y = 2.54;
row1_x1 = 32;
row1_x2 = 62.5;
row2_y = 50.5;
row2_x1 = 30;
row2_x2 = 62.5;
pin_w = 2.54;
pin_h = 9;

// Jacks
jack1_w = 12;
jack1_l = 16.2;
jack1_h = 10.9;
jack1_x = -6.2;
jack1_y = 31.7;
jack2_w = 8.9;
jack2_l = 14.4;
jack2_h = 10.9;
jack2_x = -1.8;
jack2_y = 3.3;

// Case
wall_t = 2.4;
clearance = 1;
radius = 6;
bot_clearance = 2;
inner_height = 14.1;
lip = wall_t/2;

module arduino() {
    // Board
    color([0, 0.8, 0.4])
    linear_extrude(ard_board_t){
        difference() {
            square([ard_l, ard_w]);
            translate([ard_hole1_x, ard_hole1_y, 0])
            circle(d=ard_hole_d, $fn=100);
            translate([ard_hole2_x, ard_hole2_y, 0])
            circle(d=ard_hole_d, $fn=100);
            translate([ard_hole3_x, ard_hole3_y, 0])
            circle(d=ard_hole_d, $fn=100);
            translate([ard_hole4_x, ard_hole4_y, 0])
            circle(d=ard_hole_d, $fn=100);
        }
    }
    // Headers
    color([0.2, 0.2, 0.2])
    translate([row1_x1-pin_w/2, row1_y-pin_w/2, ard_board_t])
    linear_extrude(pin_h) {
        square([row1_x2-row1_x1+pin_w, pin_w]);
    }
    color([0.2, 0.2, 0.2])
    translate([row2_x1-pin_w/2, row2_y-pin_w/2, ard_board_t])
    linear_extrude(pin_h) {
        square([row2_x2-row2_x1+pin_w, pin_w]);
    }
    // Jacks
    color([0.6, 0.6, 0.6])
    translate([jack1_x, jack1_y, ard_board_t])
    linear_extrude(jack1_h) {
        square([jack1_l, jack1_w]);
    }
    color([0.2, 0.2, 0.2])
    translate([jack2_x, jack2_y, ard_board_t])
    linear_extrude(jack2_h) {
        square([jack2_l, jack2_w]);
    }
}

module case_bottom() {
    difference() {
        union(){
            translate([-wall_t-clearance+radius, -wall_t-clearance])
            difference() {
                minkowski() {
                    linear_extrude((inner_height/2+wall_t)/2+bot_clearance) {
                        square([ard_l+2*clearance+2*wall_t-2*radius, ard_w+2*clearance+2*wall_t]);
                    }
                    cylinder(h=(inner_height/2+wall_t)/2, r=radius, $fn=100);
                }
                translate([0, 0, wall_t])
                minkowski() {
                    linear_extrude((inner_height/2+wall_t)/2+bot_clearance) {
                        square([ard_l+2*clearance-2*(radius-wall_t), ard_w+2*clearance+2*wall_t]);
                    }
                    cylinder(h=(inner_height/2+wall_t)/2, r=radius-wall_t, $fn=100);
                }
            }
            translate([ard_hole1_x, ard_hole1_y, wall_t])
            cylinder(bot_clearance+ard_board_t, ard_hole_d/2-clearance/2, ard_hole_d/2-clearance/2, $fn=100);
            translate([ard_hole1_x, ard_hole1_y, wall_t])
            cylinder(bot_clearance, ard_hole_d, ard_hole_d, $fn=100);
            translate([ard_hole2_x, ard_hole2_y, wall_t])
            cylinder(bot_clearance+ard_board_t, ard_hole_d/2-clearance/2, ard_hole_d/2-clearance/2, $fn=100);
            translate([ard_hole2_x, ard_hole2_y, wall_t])
            cylinder(bot_clearance, ard_hole_d, ard_hole_d, $fn=100);
            translate([ard_hole3_x, ard_hole3_y, wall_t])
            cylinder(bot_clearance+ard_board_t, ard_hole_d/2-clearance/2, ard_hole_d/2-clearance/2, $fn=100);
            translate([ard_hole3_x, ard_hole3_y, wall_t])
            cylinder(bot_clearance, ard_hole_d, ard_hole_d, $fn=100);
            translate([ard_hole4_x, ard_hole4_y, wall_t])
            cylinder(bot_clearance+ard_board_t, ard_hole_d/2-clearance/2, ard_hole_d/2-clearance/2, $fn=100);
            translate([ard_hole4_x, ard_hole4_y, wall_t])
            cylinder(bot_clearance, ard_hole_d, ard_hole_d, $fn=100);
        }
        translate([0, jack1_y-clearance, wall_t+bot_clearance+ard_board_t-clearance])
        rotate([0, -90, 0])
        linear_extrude(wall_t*2) {
            square([jack1_h+2*clearance, jack1_w+2*clearance]);
        }
        translate([0, jack2_y-clearance, wall_t+bot_clearance+ard_board_t-clearance])
        rotate([0, -90, 0])
        linear_extrude(wall_t*2) {
            square([jack2_h+2*clearance, jack2_w+2*clearance]);
        }
    }
    translate([0, 0, wall_t+bot_clearance])
    arduino();
}

arduino();