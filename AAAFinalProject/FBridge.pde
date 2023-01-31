class FBridge extends FGameObject {
  FBridge(float x, float y) {
    super();
    setPosition(x, y);
    setName("bridge");
    attachImage(bridge);
    setStatic(true);
    if (addImages) bridge.resize(32, 32);
    setFriction(3);
  }
  
  void act() {
    if (isTouching("player")) {
      setStatic(false);
      setSensor(true);
    }
  }
}

//------------------------------------------------------------------------------------------------------------
class Orbs extends FGameObject {
  int orbNum;
  PImage[] orb;
  
  Orbs(float x, float y, PImage[] orb) {
    super();
    orbNum = 0;
    setPosition(x, y);
    setName("orb");
    attachImage(orb[orbNum]);
    setStatic(true);
    setSensor(true);
    this.orb = orb;
    if (addImages) orb[orbNum].resize(32, 32);
  }
  
  void act() {
    attachImage(orb[orbNum]);
    if (frameCount % 15 == 0)
      orbNum++;
    if (orbNum == orb.length)
      orbNum = 0;
    if (isTouching("player")) {
      orbCount++;
      world.remove(this);
    }
    if (addImages) orb[orbNum].resize(32, 32);
  }
}

//------------------------------------------------------------------------------------------------------------
class Fluffs extends FGameObject {
  int fluffNum;
  
  Fluffs(float x, float y) {
    super();
    fluffNum = 0;
    setPosition(x, y);
    setName("orb");
    attachImage(fluffs[fluffNum]);
    setStatic(true);
    setSensor(true);
    if (addImages) fluffs[fluffNum].resize(20, 20);
  }
  
  void act() {
    attachImage(fluffs[fluffNum]);
    if (frameCount % 15 == 0)
      fluffNum++;
    if (fluffNum == fluffs.length)
      fluffNum = 0;
    if (isTouching("player")) {
      fluffCount++;
      world.remove(this);
    }
    if (addImages) fluffs[fluffNum].resize(20, 20);
  }
}
