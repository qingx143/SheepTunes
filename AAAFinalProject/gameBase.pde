void intro() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  
  fill(255);
  textFont(mainFont);
  textSize(70);
  text("Sheep Tunes!", 250, 120);
  
  gameButton.show();
  buttonChange(gameButton, 3);
  //settingsButton.show();
  //buttonChange(settingsButton, 2);
  //rulesButton.show();
  //buttonChange(rulesButton, 5);
  sheepGif.show();
  
  textAlign(CORNER, CORNER);
  rectMode(CORNER);
  imageMode(CORNER);
}

//instructions ------------------------------------------------------------------------------------------------------------------------
void instructions() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  
  textAlign(CORNER, CORNER);
  rectMode(CORNER);
  imageMode(CORNER);
}

//settings ----------------------------------------------------------------------------------------------------------------------------
void setting() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  
  fill(255);
  textFont(mainFont);
  textSize(70);
  text("Settings", 250, 120);
  
  textAlign(CORNER, CORNER);
  rectMode(CORNER);
  imageMode(CORNER);
}

//game --------------------------------------------------------------------------------------------------------------------------------
void game() {
  background(0);
  drawWorld();
  actWorld();
  textFont(mainFont);
  textSize(20);
  text("lives =", 25, 35);
  text("fluffs = " + fluffCount, 25, 60);
  text("orbs collected = " + orbCount, 25, 85);
  println(immuneAh);
  if (immuneAh)
    text("immunity timer = " + (int) spikeCounter/60, 300, 35);
  if (spikeCounter <= 60) {
    text("immunity timer = " + 0, 300, 35);
    immuneAh = false;
  }
  if (lives >= 1) heart.show();
  if (lives >= 2) heart2.show();
  if (lives >= 3) heart3.show();
  if (lives >= 4) heart4.show();
  if (lives >= 5) heart5.show();
  if (lives <= 0) mode = GAMEOVER;
  if (orbCount >= 7) 
    mode = GAMEOVER;
}

//gameover ----------------------------------------------------------------------------------------------------------------------------
void gameover() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  
  fill(255);
  textFont(mainFont);
  textSize(70);
  if (orbCount >= 7)
    win = true;
  if (win) {
    text("Congrats!", 250, 120);
    textSize(30);
    text("You collected all the orbs!", 250, 250);
  }
  if (!win) {
    text("Game Over", 250, 120);
    textSize(30);
    text("You failed to collect \n them all :(", 250, 250);
  }
  
  restartButton.show();
  if (restartButton.getClicked())
    reset();
  buttonChange(restartButton, 1);
  
  textAlign(CORNER, CORNER);
  rectMode(CORNER);
  imageMode(CORNER);
}

void reset() {
  while (terrain.size() > 0) {
    world.remove(terrain.get(0));
    terrain.remove(0);
  }
  
  while (enemies.size() > 0) {
    world.remove(enemies.get(0));
    enemies.remove(0);
  }
  lives = 5;
  fluffCount = 0;
  loadWorld(map);
  loadPlayer();
  win = false;
  orbCount = 0;
}

//show buttons -------------------------------------------------------------------------
void buttonChange(Button buttonNew, int modeChange) {
  buttonNew.show();
  if (modeChange != 0 && buttonNew.getClicked()) {
    mode = modeChange;
  }
}
