class FLava extends FGameObject {
  int lavaNum;
  
  FLava(float x, float y) {
    super();
    lavaNum = (int) (random(0, 6));
    setPosition(x, y);
    setName("lava");
    attachImage(lavaBlocks[lavaNum]);
    setStatic(true);
    if (addImages) lavaBlocks[lavaNum].resize(32, 32);
    setFriction(3);
  }
  
  void act() {
    attachImage(lavaBlocks[lavaNum]);
    if (frameCount % 8 == 0)
      lavaNum++;
    if (lavaNum == lavaBlocks.length)
      lavaNum = 0;
    if (isTouching("player")) {
      player.setPosition(40, 640);
    }
  }
}

//------------------------------------------------------------------------------------------------------------
class FWater extends FGameObject {
  int waterNum;
  
  FWater(float x, float y) {
    super();
    waterNum = (int) (random(0, 3));
    setPosition(x, y);
    setName("water");
    attachImage(waterBlocks[waterNum]);
    setStatic(true);
    setSensor(true);
    if (addImages) waterBlocks[waterNum].resize(32, 32);
    setFriction(3);
  }
  
  void act() {
    attachImage(waterBlocks[waterNum]);
    if (frameCount % 8 == 0)
      waterNum++;
    if (waterNum == waterBlocks.length)
      waterNum = 0;
  }
}
