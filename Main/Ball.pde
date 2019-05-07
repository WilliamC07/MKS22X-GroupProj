abstract class Ball extends Thing implements Moveable {
  float speed, xDirection, yDirection;
  color ballc, collisionColor;
  Ball(float x, float y, color collisionColor) {
    super(x, y, 50);
    speed = random(10);
    this.xDirection = random(2) == 0 ? 1 : -1;
    this.yDirection = random(2) == 0 ? 1 : -1;
    this.ballc = color(random(256), random(256), random(256));
    this.collisionColor = collisionColor;
  }

  void display() {
    if (collided()) {
      fill(collisionColor);
    } else {
      fill(this.ballc);
    }
    ellipse(x, y, this.size, this.size);
  }
  
  boolean collided(){
    for (Collideable c : collideables) {
      if (c.isTouching(this)) {
        return true;
      }
    }
    
    return false;
  }

  void move() {
    this.x += speed * xDirection;
    this.y += speed * yDirection;

    if (this.x < 0 || this.x > width) {
      xDirection *= -1;
    }
    if (this.y < 0 || this.y > height) {
      yDirection *= -1;
    }
  }
}

class BallA extends Ball {
  BallA(float x, float y){
    super(x, y, color(255, 0, 0));
  }
}

class BallB extends Ball {
  BallB(float x, float y){
    super(x, y, color(0, 0, 255));
  }
}