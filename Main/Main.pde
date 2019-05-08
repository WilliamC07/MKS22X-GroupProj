interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable {
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
    boolean isTouching(Thing other) {
    // touches when the sum of the size of the other Thing and this Thing is less than the distance between center
    // division by 2 since size is the width and height, but we want radius
    return dist(this.x, this.y, other.x, other.y) <= (other.size + this.size) / 2;
  }

  abstract void display();
}

class Rock extends Thing {
  PImage shape;
  float size;
  Rock(float x, float y, PImage img) {
    super(x, y, random(20) + 30);
    size = random(20) + 30;
    shape = img;
  }

  void display() { 
    // subtract half of size to center the image
    image(shape, x - size / 2, y - size / 2, size, size);
  }
}

public class LivingRock extends Rock implements Moveable {
  float t;
  float a;
  boolean backward;
  LivingRock(float x, float y, PImage img) {
    super(x, y, img);
    t = 0;
    a = random(1, 5);
  }
  void display() {
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
    if (this.x < 0 || this.x > width || this.y < 0 || this.y > height){
      this.backward = true;
    }
    if (this.t <= 0){
      this.t = 0.1;
      this.backward = false;
    }
    this.t = this.t + 0.1;
    if (backward){
      if (this.t > 0) this.t = this.t - 0.2;
      this.x = this.x - sqrt(abs(t)) * cos(abs(t)) * abs(a);
      this.y = this.y - sqrt(abs(t)) * sin(abs(t)) * abs(a);
    }
    else{
      this.x = this.x + sqrt(abs(t)) * cos(abs(t)) * abs(a);
      this.y = this.y + sqrt(abs(t)) * sin(abs(t)) * abs(a);
    }

    // if u want motion modeled by function this.y += f(x) * this.speedy
    // below makes it look like its vibrating
    //attempt at spiral of archimedes
    //this.y += -0.5 * (float) (Math.pow(Math.cos(Math.pow(x*x + y*y, 0.5)), -2) / (Math.pow(x*x + y*y, 0.5)));
    //this.y = this.y  +    3 * (float) Math.sin(y) * this.speedy + this.speedy;
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
  PImage img1 = loadImage("rock1.png");
  PImage img2 = loadImage("rock2.png");
  PImage ballA = loadImage("smiley.png");
  for (int i = 0; i < 10; i++) {

    Ball b;
    if (i < 5) {
      b = new BallA(50+random(width-100), 50+random(height-100), ballA);
      // to be updated with subclasses of Ball
    } else {
      b = new BallB(50+random(width-100), 50+random(height-100));
    }    
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r;
    if ((int)random(0, 2) % 2 == 1) {
      r = new Rock(50+random(width-100), 50+random(height-100), img1);
    } else {
      r = new Rock(50+random(width-100), 50+random(height-100), img2);
    }
    thingsToDisplay.add(r);
    collideables.add(r);
  }
  LivingRock m;
  if ((int)random(0, 2) % 2 == 1) {
    m = new LivingRock(50+random(width-100), 50+random(height-100), img1);
  } else {
    m = new LivingRock(50+random(width-100), 50+random(height-100), img2);
  }
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
