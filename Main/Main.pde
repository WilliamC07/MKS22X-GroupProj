interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable{
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable, Collideable {
  float x, y;//Position of the Thing
  float size;

  Thing(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  @Override
  boolean isTouching(Thing other){
    // touches when the sum of the size of the other Thing and this Thing is less than the distance between center
    // division by 2 since size is the width and height, but we want radius
    return dist(this.x, this.y, other.x, other.y) <= (other.size + this.size) / 2;
  }
  
  abstract void display();
}

class Rock extends Thing {
  PImage shape;
  float size;
  Rock(float x, float y) {
    super(x, y, random(20) + 30);
    size = random(20) + 30;
    PImage img1 = loadImage("rock1.png");
    PImage img2 = loadImage("rock2.png");
    if ((int)random(0,2) % 2 == 1){
      shape = img1;
    }
    else{
      shape = img2;
    }
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
  void display(){
    super.display();
    fill(255);
    ellipse(x + size / 6, y + 10, 10, 10);
    ellipse(x + 2 * size / 3, y + 10, 10, 10);
    fill(0);
    ellipse(x + size /6, y + 10, 2, 2);
    ellipse(x + 2 * size/ 3, y + 10, 2, 2);
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

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> collideables;

void setup() {
  size(1000, 400);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  collideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    
    Ball b;
    if (i < 5){
      b = new BallA(50+random(width-100), 50+random(height-100));
      // to be updated with subclasses of Ball
    }
    else{
      b = new BallB(50+random(width-100), 50+random(height-100));
    }    
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    collideables.add(r);
  }

  LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
  thingsToDisplay.add(m);
  thingsToMove.add(m);
  collideables.add(m);
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
