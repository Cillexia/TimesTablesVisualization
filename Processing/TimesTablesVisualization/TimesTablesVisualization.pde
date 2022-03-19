/**
* Times Tables Visualization:
* A cillexia project by Christian Bietsch
* Website: www.cillexia.net
*/
// ========== Radius ==========
float rMax = 300;          // maximum radius of the ring
float rStep = rMax*0.002;  // step size when inflating the ring
float r;                   // radius of the ring

// ========== Dots and Strings ==========
int dMax = 200;            // total dots on ring
int sMax = dMax-1;         // total strings
float dStep = 0.4;         // step size when adding dots
float d;                   // current amount of dots

// ========== Factor ==========
float fStep = 0.0025;     // added each frame to f
float f;                  // factor

// ========== INFO ==========
String INFO_WEBSITE = "cillexia.net";
String INFO_NAME = "Times Tables Visualization";
String INFO_AUTHOR = "Christian Bietsch";
int INFO_SIZE = 32;
color INFO_COLOR = color(120);
String LOGO = "cillexia_logo_128x128.png";
PImage logo;

void setup() {
  size(800, 800);
  frameRate(60);
  
  // LOGO
  logo = loadImage(LOGO);
}

void draw() {
  translate(width*0.5, height*0.5);
  background(0);
  
  final boolean inflateRing = r < rMax;
  final boolean addStrings = d < dMax;
  
  // draw ring
  stroke(255);
  noFill();
  circle(0, 0, r*2);
  
  // draw dots on ring
  if (!inflateRing) {
    for (int i = 0; i < d; i++) {
      PVector v = vector(i);
      noStroke();
      fill(255);
      circle(v.x, v.y, r*0.025);
    }
  }
  
  // draw lines
  if (!inflateRing) {
    for (int i = 1; i < d; i++) {
      PVector a = vector(i);
      PVector b = vector(i * f);
      stroke(255);
      line(a.x, a.y, b.x, b.y);
    }
  }
  
  // INFO
  if (inflateRing) {
    fill(INFO_COLOR);
    textSize(INFO_SIZE*0.6);
    textAlign(CENTER, CENTER);
    text("Inflating Ring "+int(map(r, 0, rMax, 0, 100))+"%", 0, height*0.41);
  } else if (!inflateRing && addStrings) {
    fill(INFO_COLOR);
    textSize(INFO_SIZE*0.6);
    textAlign(CENTER, CENTER);
    text("Populating Ring with Dots and Strings "+int(map(d, 0, dMax, 0, 100))+"%", 0, height*0.41);
  } else if (!inflateRing && !addStrings) {
    fill(INFO_COLOR);
    textSize(INFO_SIZE*0.6);
    textAlign(CENTER, CENTER);
    text("Factor "+nf(f, 0, 2), 0, height*0.41);
  }
  INFO();
  
  // calculate next frame
  if (inflateRing) r = min(r + rStep, rMax);
  if (!inflateRing && addStrings) d = min(d + dStep, dMax);
  if (!inflateRing && !addStrings) f += fStep;
}

void INFO() {
  // NAME
  fill(INFO_COLOR);
  textSize(INFO_SIZE*1.2);
  textAlign(CENTER, CENTER);
  text(INFO_NAME, 0, -height*0.455);
  textSize(INFO_SIZE*0.6);
  text(dMax+" Dots "+sMax+" Strings", 0, -height*0.409);
  
  // AUTHOR
  fill(INFO_COLOR);
  textSize(INFO_SIZE*0.4);
  textAlign(LEFT, CENTER);
  text("Animation by "+INFO_AUTHOR, -width*0.4625, height*0.47);
  
  // cillexia
  fill(INFO_COLOR);
  textSize(INFO_SIZE);
  textAlign(CENTER, CENTER);
  text(INFO_WEBSITE, 0, height*0.465);
  
  // LOGO
  tint(INFO_COLOR);
  image(logo, width*0.5-logo.width, height*0.5-logo.height);
}

PVector vector(float index) {
  float angle = map(index % d, 0, d, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}
