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
  Rock(float x, float y) {
    super(x, y);
  }

  void display() { 
    /* ONE PERSON WRITE THIS */
    fill(92, 0, 0);
    ellipse(x,y, 20, 20);
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
      this.x = this.x + this.speedx;
      this.y = this.y + this.speedy;
    }
  }

class Ball extends Thing implements Moveable {
  float slope;
  
  Ball(float x, float y) {
    super(x, y);
    slope = .002;
  }

  void display() {
      /* ONE PERSON WRITE THIS */
      ellipse(x,y,50,50);
    }
    
  void move() {
    this.x = this.x + this.x * slope;
    this.y = this.y + this.y * slope;
    
    // check for out of bounds
    if(this.x > width || this.x < 0 || this.y > height || this.y < 0){
      this.slope = -this.slope;
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
