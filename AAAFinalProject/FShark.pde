class FShark extends FGameObject {
  int direction;
  int speed;
  int frame;
  
  FShark(float x, float y) {
    super();
    setPosition(x, y);
    setName("Shark");
    setRotatable(false);
    direction = L;
    speed = 50;
    frame = 0;
  }
  
  void act() {
    animate(sharks);
    collide();
    move();
    if (isTouching("fluffyBullet")) {
      world.remove(this);
      enemies.remove(this);
    }
  }
  
  void animate(PImage[] sharks) {
    if (frame >= sharks.length) frame = 0;
    if (frameCount % 10 == 0) {
      if (direction == R) attachImage(reverseImage(sharks[frame]));
      if (direction == L) attachImage(sharks[frame]);
      frame++;
    }
  }
  
  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction * 5, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY() - 30) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      }
      else if (spikeCounter <= 0) {
        println("howdyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        lives--;
        spikeCounter = 60;
      }
    }
  }
  
  void move() {
    setVelocity(speed * direction, getVelocityY());
  }
}
