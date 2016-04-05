// Gear

module halftooth(teeth, mod, pres_angle) {
    outer_d = (teeth+2)*mod;
    pitch_d = mod*teeth;
    root_d = (teeth-2)*mod;
    q_a_cir_pitch = (360/4)/teeth;
    pitch_p_d_cir = 4*mod;
    t = mod / 4;
    intersection() {
        difference() {
            rotate([0, 0, -q_a_cir_pitch])
            translate([0, pitch_d/2, 0])
            rotate([0, 0, pres_angle])
            translate([-pitch_p_d_cir/2, 0, 0])
            circle(d=pitch_p_d_cir, $fn=100);
            circle(d=root_d-1, $fn=100);
        }
        square(outer_d/2);
        circle(d=outer_d, $fn=100);
    }
}

module tooth(teeth, mod, pres_angle) {
    union() {
        halftooth(teeth, mod, pres_angle);
        mirror([1, 0, 0])
        halftooth(teeth, mod, pres_angle);
    }
}

module gear(teeth, mod, pres_angle) {
    pitch_d = mod*teeth;
    root_d = (teeth-2)*mod;
    ang_cir_pitch = 360/teeth;
    union() {
        circle(d=root_d, $fn=100);
        for (i=[0:teeth-1]) {
            rotate([0, 0, ang_cir_pitch*i])
            tooth(teeth, mod, pres_angle);
        }
    }
}

module makegear(teeth, mod, pres_angle, height, center_hole, cuff_h, cuff_t) {
    union() {
        linear_extrude(height) {
            difference() {
                gear(teeth, mod, pres_angle);
                circle(center_hole/2, $fn=100);
            }
        }
        translate([0, 0, height])
        linear_extrude(cuff_h) {
            difference() {
                circle(center_hole/2+cuff_t, $fn=100);
                circle(center_hole/2, $fn=100);
            }
        }
    }
}

// Gear Inputs
teeth = 48;
mod = 0.5;
pres_angle = 14.5;
height = 2;
center_hole = 4; //diameter
cuff_h = 1;
cuff_t = 2;
makegear(teeth, mod, pres_angle, height, center_hole, cuff_h, cuff_t);