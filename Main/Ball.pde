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

  @Override
    void display() {
    if (collided()) {
      fill(collisionColor);
    } else {
      fill(this.ballc);
    }
    ellipse(x, y, this.size, this.size);
  }

  boolean collided() {
    for (Collideable c : collideables) {
      if (c.isTouching(this)) {
        return true;
      }
    }

    return false;
  }

  @Override
    void move() {
    this.x += speed * xDirection;
    this.y += speed * yDirection;

    if (this.x < size / 2 || this.x > width - size / 2) {
      xDirection *= -1;
    }
    if (this.y < size / 2 || this.y > height - size / 2) {
      yDirection *= -1;
    }
  }
}

class BallA extends Ball {
  PImage image;
  BallA(float x, float y, PImage img) {
    super(x, y, color(255, 0, 0));
    image = img;
  }

  @Override
    void display() {
    super.display();
    // add a happy face :)
    // it will be placed ontop of the circle
    // subtract half of size to center the image
    image(image, x - size / 2, y - size / 2, size, size);
  }
}

class BallB extends Ball {
  BallB(float x, float y) {
    super(x, y, color(0, 0, 255));
  }
  @Override
    void display() {
    if (collided()) {
      fill(collisionColor);
      xDirection *= -1;
      yDirection *= -1;
    } else {
      fill(this.ballc);
    }
    ellipse(x, y, this.size, this.size);
  }
}
