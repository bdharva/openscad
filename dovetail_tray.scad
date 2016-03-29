/*
Dovetail Box
by: bdharva, 2016-03-28
*/

// Inner dimensions

w = 30; // width, mm
l = 20; // length, mm
h = 10; // height, mm

// Material properties

t = 2; // thickness, mm

// Tab style

bot_tabs = 9; // count, odd, minimum 3
side_tabs = 5; // count, odd, minimum 3

function wl (i) = ((i + 1) % 2) * w + (i % 2) * l; // odd i = l, even i = w
function lw (i) = ((i + 1) % 2) * l + (i % 2) * w; // odd i = w, even i = l
function hl (i) = ((i + 1) % 2) * h + (i % 2) * l; // odd i = l, even i = h
function lh (i) = ((i + 1) % 2) * l + (i % 2) * h; // odd i = h, even i = l
function hw (i) = ((i + 1) % 2) * h + (i % 2) * w; // odd i = w, even i = h
function wh (i) = ((i + 1) % 2) * w + (i % 2) * h; // odd i = h, even i = w

module bot_tabs (i) {
    for (j = [0:(bot_tabs-(1+2*(i%2)))/2]) {
        translate([wl(i)/2, (-lw(i)/2)+(lw(i)/bot_tabs)*(2*j+(i%2)), 0])
        square([t, lw(i)/bot_tabs]);
    }
}

module side_tabs_1 (i) {
    rotate([0, 0, 90])
    for (j = [0:(side_tabs-(1+2*((i+1) % 2)))/2]) {
        translate([lh(0)/2, -hw(0)/2+hw(0)/side_tabs*(2*j+(i+1)%2), 0])
        square([t, hw(0)/side_tabs]);
    }
    rotate([0, 0, 180])
    for (j = [0:(bot_tabs-(1+2*((i+1)%2)))/2]) {
        translate([h/2, -wl(1)/2+(wl(1)/bot_tabs)*(2*j+(i+1)%2), 0])
        square([t, wl(1)/bot_tabs]);
    }
    rotate([0, 0, 270])
    for (j = [0:(side_tabs-(1+2*((i+1) % 2)))/2]) {
        translate([lh(0)/2, -hw(0)/2+hw(0)/side_tabs*(2*j+(i+1)%2), 0])
        square([t, hw(0)/side_tabs]);
    }
}

module side_tabs_2 (i) {
    rotate([0, 0, 90])
    for (j = [0:(side_tabs-(1+2*((i-1)%2)))/2]) {
        translate([hw(1)/2, -wh(1)/2+wh(1)/side_tabs*(2*j+(i+1)%2), 0])
        square([t, hw(0)/side_tabs]);
    }
    rotate([0, 0, 180])
    for (j = [0:(bot_tabs-(1+2*((i-1)%2)))/2]) {
        translate([wh(i)/2, (hw(i)/2)-(hw(i)/bot_tabs)*(2*j+(i%2)), 0])
        square([t, lw(i)/bot_tabs]);
    }
    rotate([0, 0, 180])
    translate([wh(i)/2, hw(i)/2, 0])
    square([t, t]);
    rotate([0, 0, 180])
    translate([wh(i)/2, -hw(i)/2-t, 0])
    square([t, t]);
    rotate([0, 0, 270])
    for (j = [0:(side_tabs-(1+2*((i-1)%2)))/2]) {
        translate([hw(1)/2, -wh(1)/2+wh(1)/side_tabs*(2*j+(i+1)%2), 0])
        square([t, hw(0)/side_tabs]);
    }
}


module bottom () {
    color([1,1,0])
    linear_extrude(t)
    union() {
        square([w, l], center = true);
        for(i = [0:3]) { rotate([0, 0, 90*i]) bot_tabs(i); }
    }
}

module sides_2d () {
    for(i = [0, 2]) {
        rotate([0, 0, 90*i])
        translate([wl(i)/2+h/2+3*t, 0, 0])
        color([0,0,1])
        linear_extrude(t)
        union() {
            square([h, lw(i)], center = true);
            side_tabs_1(i);
        }
    }
    for(i = [1, 3]) {
        rotate([0, 0, 90*i])
        translate([wl(i)/2+h/2+3*t, 0, 0])
        color([1,0,0])
        linear_extrude(t)
        union() {
            square([h, lw(i)], center = true);
            side_tabs_2(i);
        }
    }
}

bottom();
sides_2d();