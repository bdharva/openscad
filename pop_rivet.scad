module shaft() {
    
    cylinder(h=1, d=12, $fn=100);

    translate([0, 0, 1])
    cylinder(h=.8, d1=12, d2=10, $fn=100);

    translate([0, 0, 1.8])
    cylinder(h=8.4, d=5.7, $fn=100);

    translate([0, 0, 10.2])
    cylinder(h=1.3, d1=5.3, d2=4.7, $fn=100);

    translate([0, 0, 11.5])
    cylinder(h=1.3, d1=4.7, d2=5.3, $fn=100);
    
    translate([0, 0, 12.8])
    cylinder(h=4.4, d1=5.3, d2=1.3, $fn=100);

    translate([0, 0, 17.2])
    cylinder(h=4.4, d1=5.3, d2=1.3, $fn=100);

    translate([0, 0, 1.8])
    linear_extrude(5.5){
        union(){
            square([7.8, 2], center=true);
            rotate([0, 0, 90])
            square([7.8, 2], center=true);
        }
    }

    for(i=[0:1]){
        translate([0, 0, 7.3])
        rotate([0, 0, 90*i])
        linear_extrude(1.5, scale=[1, 0.4]){
            square([7.8, 2], center=true);
        }
    }

    for(i=[0:1]){
        translate([0, 0, 8.8])
        rotate([0, 0, 90*i])
        linear_extrude(1.5, scale=[.88, 1]){
            square([7.8, .8], center=true);
        }
    }
    
    for(i=[0:1]){
        translate([0, 0, 10.3])
        rotate([0, 0, 90*i])
        linear_extrude(6.5){
            square([6.864, .8], center=true);
        }
    }

    for(i=[0:1]){
        translate([0, 0, 16.8])
        rotate([0, 0, 90*i])
        linear_extrude(4.75, scale=[0.2, .25]){
            square([6.864, .8], center=true);
        }
    }
    
}

module donut(){
    difference(){
        union(){
            difference(){
                union(){
                    linear_extrude(1.3){
                        difference(){
                            circle(d=20, $fn=100);
                            union(){
                                square(12.4, center=true);
                                rotate([0, 0, 45])
                                square([7, 22], center=true);
                                rotate([0, 0, -45])
                                square([7, 22], center=true);
                            }
                        }
                        
                    }
                    translate([0, 0, 1.3])
                    cylinder(h=1.3, d=20, $fn=100);
                    translate([0, 0, 2.6])
                    cylinder(h=8.9, d=7.8, $fn=100);
                }
                translate([0, 0, -1])
                cylinder(h=30, d=5.8, $fn=100);
            }
            difference(){
                translate([0, 0, 7.3])
                cylinder(h=4.2, d=6, $fn=100);
                translate([0, 0, 7.2])
                cylinder(h=4.4, d1=5.3, d2=1.3, $fn=100);
            }
        }
        for(i=[0:1]){
            rotate([0, 0, 90*i])
            linear_extrude(7.3){
                square([8,2.3], center=true);
            }
        }
        for(i=[0:1]){
            translate([0, 0, 7.3])
            rotate([0, 0, 90*i])
            linear_extrude(1.5, scale=[1, 0.478]){
                square([8, 2.3], center=true);
            }
        }
        
        linear_extrude(20){
            square([8,1.1], center=true);
        }
        rotate([0, 0, 90])
        linear_extrude(20){
            square([8,1.1], center=true);
        }
    }
}

shaft();
//translate([0, 0, 5.6])
//translate([0, 0, 12])
color([1, 0, 0])
donut();