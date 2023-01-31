class FLittleD extends FShark {
  int hammerTimer = 60;
  FLittleD(float x, float y) {
    super(x, y);
    setName("LittleDNo2");
  }
  
  void act() {
    super.animate(littleDs);
    super.collide();
    super.move();
    
    if (isTouching("fluffyBullet")) {
      world.remove(this);
      enemies.remove(this);
    }
    
    hammerTimer--;
    
    if (hammerTimer <= 0) {
      hammers.add(new FHammer(getX(), getY()));
      hammerTimer = 60;
    }
  }
}

//------------------------------------------------------------------------------------------------------------
class FHammer extends FGameObject {
  float x, y;
  int hammerLives;
  FHammer(float x, float y) {
    super();
    this.x = x;
    this.y = y;
    setPosition(x, y);
    setName("hammer");
    attachImage(hammer);
    hammer.resize(20, 20);
    setFill(255);
    setAngularVelocity(30);
    setSensor(true);
    setVelocity(0, -500);
    hammerLives = 1;
    world.add(this);
  }
  
  void act() {
    if (isTouching("ice") || isTouching("snow") || isTouching("leaves")) {
      hammerLives--;
    }
  }
}
