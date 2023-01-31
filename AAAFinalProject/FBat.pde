class FBat extends FGameObject {
  float x, y;
  boolean encounter;
  int batNum;
  
  FBat(float x, float y) {
    super();
    this.x = x;
    this.y = y;
    setPosition(x, y);
    setName("bat");
    attachImage(sleepyBat);
    batNum = 0;
    setRotatable(false);
    setStatic(true);
    setFriction(3);
    encounter = false;
  }
  
  void act() {
    if (player.getX() >= x - 60 && player.getX() <= getX() + 60 && player.getY() >= getY() - 60 && player.getY() <= getY() + 60) {
      encounter = true;
    }
    if (encounter) {
      if (player.getX() < x) x -= 0.5;
      if (player.getX() > x) x += 0.5;
      if (player.getY() < y) y -= 0.5;
      if (player.getY() > y) y += 0.5;
      setStatic(false);
      setPosition(x, y);
      attachImage(bat[batNum]);
      if (frameCount % 8 == 0)
        batNum++;
      if (batNum == bat.length)
        batNum = 0;
    }
    
    if (isTouching("fluffyBullet")) {
      world.remove(this);
      enemies.remove(this);
    }
    
    if (isTouching("player") && !immuneAh) {
      lives--;
      encounter = false;
      world.remove(this);
    }
  }
}

//------------------------------------------------------------------------------------------------------------
class FGen extends FGameObject {
  float x, y;
  FGen(float x, float y) {
    super();
    setPosition(x, y);
    setName("heartGen");
    attachImage(regen);
    setStatic(true);
    setSensor(true);
    if (addImages) regen.resize(32, 32);
  }
  
  void act() {
    attachImage(regen);
    if (isTouching("player") && lives < 5) {
      lives++;
      world.remove(this);
    }
    if (addImages) regen.resize(32, 32);
  }
}

//------------------------------------------------------------------------------------------------------------
class FProtect extends FGameObject {
  float x, y;
  FProtect(float x, float y) {
    super();
    setPosition(x, y);
    setName("protect");
    attachImage(immune);
    setStatic(true);
    setSensor(true);
    if (addImages) immune.resize(32, 32);
  }
  
  void act() {
    attachImage(immune);
    if (isTouching("player")) {
      immuneAh = true;
      spikeCounter = 600;
      world.remove(this);
    }
    if (addImages) immune.resize(32, 32);
  }
}
