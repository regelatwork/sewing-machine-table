e = 0.1;
scale = 31.84/26.42;
width = 55.5;
length = 29.16;
gap = 43.5 / scale;

echo(scale);
module sphere_corners(rad, height) {
    sphere(rad, $fn = 20);
    translate([height - 2 * rad,0,0])
      sphere(rad, $fn = 20);
}
module rounded_flat(r,w,l) {
  translate([r,r,r])
    hull() {
      translate([0,l - 2 * r,0])
        sphere_corners(r,w);
      sphere_corners(r,w);
    }
  //cube([30.89, 23.28, 1]);
}

module rounded_box(r,w,l,h) {
  translate([r,r,r]) 
    hull() {
      sphere_corners(r,w);
      translate([0, l - 2 * r, 0])
        sphere_corners(r,w);
      translate([0, 0, h - 2 * r])
        sphere_corners(r,w);
      translate([0, l - 2 * r, h - 2 * r])
        sphere_corners(r,w);
    }
}

module rounded_table(r,w,l) {
  difference() {
    rounded_flat(r,w,l);
    translate([-e/2 , -e/2, r])
      cube([w + e, l + e, r + e]);
  }
}

module drawer() {
  rounded_box(r=0.5,w=6.45,l=3,h=6.45);
  translate([6.45/2 - 1, -0.5, 6.45/2 - 0.75])
    difference() {
      rounded_box(r=0.5,w=2,l=3,h=1.5);
      translate([-e,-e,0.75])
        cube([4,4,4]);
    }
}

module cabinet() {
  rounded_box(r=1,w=9.45,l=length - 2,h=24.7 - 7.45);
  for(i = [0 : 1]) {
    translate([1.5,-0.5,1.5 + 7.45 * i])
      drawer();
  }
}

module conical_flat(r1,r2,w,l,h) {
  translate([r2,r2,0])
  hull()
  for (i = [0, 1]) {
    for (j = [0, 1]) {
      translate([i * (w - 2 * r2), j * (l - 2 * r2), 0])
        cylinder(r2=r2, r1=r1, h=h, $fn=20);
    }
  }
}

module cover() {
  cube([37,1,2]);

  intersection() {
    cube([8,5,8]);
    translate([2,0,-1.1])
    rotate(-45, [0,1,0])
    cube([4,1,8]);
  }
  translate([30.15, 0, 0])
  intersection() {
    cube([8,1.1,8]);

    translate([2,0,1.1])
    rotate(45, [0,1,0])
    cube([4,1,8]);
  }
}

module dog_ear(v) {
  for(p = v) {
    translate([p[0],p[1],0])
      cylinder(r=5,h=0.14);
  }
}

scale(scale)
  for (x = [1,width - 3]) {
    for (y = [1, length - 3]) {
      dog_ear([[x,y]]);
    }
  }
scale(scale)
//rotate(180,[1,0,0])
//translate([0,-length,-1])
translate([-1,-1,-1])
difference() {
union() {
  translate([1,1,e])
    cabinet();
  translate([width - 9.45 - 1,1,e])
    cabinet();
  translate([9,2,1-e])
    cover();
  translate([9,length - 3,1-e])
    cover();
%  translate([0,length + 2,0])
  conical_flat(r2=1.1,r1=0.6,w=34,l=20,h=0.5);
%  translate([36,length + 2,0])
  conical_flat(r2=0.1,r1=0.6,w=33-2*e,l=18-2*e,h=0.5);
}
  rounded_table(r=1,w=width,l=length);
}