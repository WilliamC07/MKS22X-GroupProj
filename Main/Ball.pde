class Ball extends Thing implements Moveable {
  float speed, xDirection, yDirection;
  color ballc;
  Ball(float x, float y) {
    super(x, y, 50);
    speed = random(10);
    this.xDirection = random(2) == 0 ? 1 : -1;
    this.yDirection = random(2) == 0 ? 1 : -1;
    this.ballc = color(random(256),random(256),random(256));
  }

  void display() {
      // check for collision
      boolean collided = false;
      for(Collideable c : collideables){
        if(c.isTouching(this)){
          collided = true;
        }
      }
      
      if(collided){
        fill(255, 0, 0);
      }else{
        fill(this.ballc);
      }
      ellipse(x,y, this.size, this.size);
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
