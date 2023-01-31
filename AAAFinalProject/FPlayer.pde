class FPlayer extends FGameObject {
  int frame;
  int direction;
  int cooldown, threshold;
  
  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(40, 640); //40, 640
    setName("player");
    setFillColor(color(0, 0, 225, 0));
    setRotatable(false);
    threshold = 10;
    cooldown = 0;
  }
  
  void act() {
    handleInput();
    spikeCounter--;
    animate();
    if ((isTouching("spikes") && spikeCounter <= 0) || (isTouching("hammer") && spikeCounter <= 0)) {
      spikeCounter = 60;
      lives--;
    }
    if (isTouching("fluff")) fluffCount++;
    
    cooldown++;
    if (cooldown >= threshold && spacekey && fluffCount > 0) {
      cooldown = 0;
      fluffCount--;
      enemies.add(new Bullet(getX(), getY()));
    }
  }
  
  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(reverseImage(action[frame]));
      if (direction == L) attachImage(action[frame]);
      frame++;
    }
  }
  
  void handleInput() {
    float left_vy = player.getVelocityY();
    if (abs(left_vy) < 0.1) 
      action = idle;
      
    if ((akey || leftkey) && isTouching("water")) {
      player.setVelocity(-50, left_vy);
      action = run;
      direction = L;
    }
    else if (akey || leftkey) {
      player.setVelocity(-150, left_vy);
      action = run;
      direction = L;
    }
    
    if ((dkey || rightkey) && isTouching("water")) {
      player.setVelocity(50, left_vy);
      action = run;
      direction = R;
    }
    
    else if (dkey || rightkey) {
      player.setVelocity(150, left_vy);
      action = run;
      direction = R;
    }
    
    float left_vx = player.getVelocityX();
    
    if (((wkey && !contact()) || (upkey && !contact())) && isTouching("water")) 
      player.setVelocity(left_vx, -100);
      
    else if ((wkey && !contact()) || (upkey && !contact())) 
      player.setVelocity(left_vx, -300);
      
    if ((skey || downkey)) 
      player.setVelocity(left_vx, 200);
      
    if (abs(left_vy) > 0.1)
      action = jump;
  }
  
  boolean contact() {
    ArrayList<FContact> contacts = player.getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains("trunk") && (!fc.contains("snow") || !fc.contains("hammer") || !fc.contains("wall") || fc.contains("ice") || !fc.contains("bridge") || !fc.contains("leaves"))) return true;
      else if (fc.contains("snow") || fc.contains("hammer") || fc.contains("ice") || fc.contains("wall") || fc.contains("bridge") || fc.contains("leaves")) return false;
    }
    if (contacts.size() <= 0)
      return true;
    return false;
  }
}

//------------------------------------------------------------------------------------------------------------
class Bullet extends FGameObject {
  float x, y;
  int bulletLives;
  
  Bullet(float x, float y) {
    super();
    this.x = x;
    this.y = y;
    bulletLives = 1;
    setPosition(x, y);
    setName("fluffyBullet");
    attachImage(fluffs[1]);
    fluffs[1].resize(20, 20);
    setSensor(true);
    if (player.direction == R) setVelocity(500, -200);
    if (player.direction == L) setVelocity(-500, -200);
    world.add(this);
  }
  
  void act() {
    if (dist(x, y, player.getX(), player.getY()) >= 5000)
      world.remove(this);
    if (isTouching("Shark") || isTouching("LittleDNo2") || isTouching("bat"))
      world.remove(this);
  }
}
