class FThwomp extends FGameObject {
  float x, y;
  FThwomp(float x, float y) {
    super(64, 64);
    this.x = x;
    this.y = y;
    setPosition(x + 16, y + 16);
    attachImage(thwompS);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
    setFriction(3);
  }
  
  void act() {
    if (player.getX() >= x - 30 && player.getX() <= getX() + 30 && player.getY() >= getY() - 28 && player.getY() <= getY() + 150) {
      setStatic(false);
      attachImage(thwompA);
    }
    if (isTouching("player") && player.getY() >= getY() && player.getX() >= x - 31 && player.getX() <= getX() + 31)
      player.setPosition(40, 640);
  }
}
