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

  abstract void move();
}


// happy face ball
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
  
  @Override
  void move(){
    this.x += speed * xDirection;
    this.y += speed * yDirection;
    // when we reach the edge of the screen become small and disappear
    if (this.x < size / 2 || this.x > width - size / 2) {
      this.size -= 5;
    }
    if (this.y < size / 2 || this.y > height - size / 2) {
      this.size -= 5;
    }
    
    // once we disappear, teleport to a random spot on the screen and return
    // back to size and opposite direction
    if(size <= 5){
      size = 50;
      // focus more on appear at the middle
      this.x = width / 4 + random(width / 2);
      this.y = height / 4 + random(height / 2);
      this.xDirection *= -1 * random(.5, 1.5);
      this.yDirection *= -1 * random(.5, 1.5);
      
      // cap the speed
      if(abs(xDirection) > 3){
        xDirection = xDirection > 0 ? 3 : -3;
      }
      if(abs(yDirection) > 3){
        yDirection = yDirection > 0 ? 3 : -3; 
      }
    }
  }
}


// regular ball with unique motion
class BallB extends Ball {
  float rad = 0;
  float baselineY = 0;
  float baselineX = 0;
  boolean fromTop = false;
  
  BallB(float x, float y) {
    super(x, y, color(0, 0, 255));
    this.baselineY = this.y;
    this.baselineX = this.x;
  }
  
  @Override
  void display(){
    super.display();
    fill(255);
    text("i love u",x-20,y);
    text("3000", x-10, y+15);
  }
  
  @Override
  void move(){
    this.rad += .02;
    
    if(fromTop){
      this.x = this.baselineX + 100 * sin(rad);
      this.y += 2;
    }else{
      // left to right
      this.x += 2;
      this.y = this.baselineY + 100 * sin(rad);
    }
    
    // go off screen means we appear on the top of the screen down or left side
    if (this.x > width + size && !fromTop) {
      fromTop = !fromTop;
      this.y = 0 - size;
      this.x = random(width);
    }
    if(this.y > height + size && fromTop){
      fromTop = !fromTop;
      this.y = random(height);
      this.x = 0 - size;
    }
  }
}
