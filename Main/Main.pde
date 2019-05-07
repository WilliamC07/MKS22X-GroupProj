interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  float size;
  PImage shape;
  Rock(float x, float y) {
    super(x, y);
    PImage img1 = loadImage("rock1.jpg");
    PImage img2 = loadImage("rock2.jpg");
    if ((int)random(0,2) % 2 == 1){
      shape = img1;
    }
    else{
      shape = img2;
    }
    size = random(20) + 30;
  }

  void display() { 
    /* ONE PERSON WRITE THIS */
    image(shape, x, y, size, size);
  }
  void makeTriangle(float x, float y){
    triangle(x - 20, y + 20, x, y, x + 20, y + 20);
}
  void makePentagon(float x, float y){
    makeTriangle(x,y);
    rect(x - 20, y + 20, 40, 40);
}
  void makeTrapezoid(float x, float y){
    rect(x, y, 20, 20);
    triangle(x, y, x, y + 20, x - 20, y + 20);
    triangle(x + 20, y, x + 20, y + 20, x + 40, y + 20);
}
  void makeHexagon(float x, float y){
    makeTrapezoid(x, y);
    rect(x, y + 20, 20, 20);
    triangle(x, y + 40, x - 20, y + 20, x, y + 20);
    triangle(x + 20, y + 20, x + 20, y + 40, x + 40, y + 20);
}
}

public class LivingRock extends Rock implements Moveable {
  float speedx;
  float speedy;
  LivingRock(float x, float y) {
    super(x, y);
    speedx = 5;
    speedy = 2;
  }
  void move() {
      /* ONE PERSON WRITE THIS */
      if (this.x < 0 || this.x > width) this.speedx = -this.speedx;
      if (this.y < 0 || this.y > height) this.speedy = -this.speedy;
      this.x = this.x +  this.speedx;
      // if u want motion modeled by function this.y += f(x) * this.speedy
      // below makes it look like its vibrating
      //attempt at spiral of archimedes
      //this.y += -0.5 * (float) (Math.pow(Math.cos(Math.pow(x*x + y*y, 0.5)), -2) / (Math.pow(x*x + y*y, 0.5)));
      //this.y = this.y  +    3 * (float) Math.sin(y) * this.speedy + this.speedy;
      this.y = this.y + this.speedy;
    }
  }

class Ball extends Thing implements Moveable {
  float speed, xDirection, yDirection;
  
  Ball(float x, float y) {
    super(x, y);
    speed = random(20);
    this.xDirection = random(2) == 0 ? 1 : -1;
    this.yDirection = random(2) == 0 ? 1 : -1;
  }

  void display() {
      /* ONE PERSON WRITE THIS */
      ellipse(x,y,50,50);
    }
    
  void move() {
    this.x += speed * xDirection;
    this.y += speed * yDirection;
    
    if(this.x < 0 || this.x > width){
      xDirection *= -1;
    }
    if(this.y < 0 || this.y > height){
      yDirection *= -1;
    }
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 400);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
  thingsToDisplay.add(m);
  thingsToMove.add(m);
}

void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
