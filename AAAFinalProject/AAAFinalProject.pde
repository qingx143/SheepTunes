/*
Programming 12
Final Project :(
January 4, 2022
*/

import fisica.*;
FWorld world;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int mode = 0;
final int INTRO = 1;
final int SETTING = 2; //music
final int GAME = 3;
final int GAMEOVER = 4;
final int INSTRUCTIONS = 5;

//buttons
Button gameButton;
Button settingsButton;
Button rulesButton;
Button restartButton;

//colours
color grassColour = #3CA370, grassRight = #8FDE5D, grassLeft = #3D6E70;
color dirtColour = #4D3B31, dirtLeft = #B0305C, dirtCLBC = #624F44, dirtCLTC = #A0815E, dirtRight = #422445, dirtCRBC = #3D2C18, dirtCRTC = #89613A;
color leavesColour = #EB564B, trunkColour = #9F4B1E;
color bridgeColour = #F2A65E;
color iceColour = #D6ECFF;
color waterColour = #4DA6FF;
color lavaColour = #80366B;
color spikeColour = #55555E;
color bounceColour = #66FFE3;
color ladderColour = #FF8D50;
color giftColour = #F6D334;
color littleDColour = #FFDD0D, sharkColour = #64E0FF;
color wallColour = #FF0D94;
color thwompColour = #AA37F7;
color batColour = #28DEC2;
color fluffColour = #9D28DE;
color spikes2Colour = #FBFDBA;
color exitColour = #5AB767;
color regenColour = #FFB5B5;
color protect = #F1CCFF;

//images
PImage iceB;
PImage grassBCenter, grassBLeft, grassBRight;
PImage dirtB, dirtR, dirtL, dirtRBC, dirtLBC, dirtRTC, dirtLTC;
PImage treeTrunk, leavesTrunk, leavesLeft, leavesRight, leavesMiddle;
PImage spikes, spikes2;
PImage bridge;
PImage bounce;
PImage wall;

PImage[] idle = new PImage[2];
PImage[] jump = new PImage[1];
PImage[] run = new PImage[3];
PImage[] action;
PImage[] littleDs = new PImage[2];
PImage[] sharks = new PImage[2];

PImage[] lavaBlocks = new PImage[6];
PImage[] waterBlocks = new PImage[4];
PImage lavaBottom;

PImage[] oneOrbs = new PImage[2];
PImage[] twoOrbs = new PImage[2];
PImage[] threeOrbs = new PImage[2];
PImage[] fourOrbs = new PImage[2];
PImage[] fiveOrbs = new PImage[2];
PImage[] sixOrbs = new PImage[2];
PImage[] sevenOrbs = new PImage[2];

PImage immune;

PImage thwompA;
PImage thwompS;
PImage regen;

PImage[] fluffs = new PImage[2];
PImage[] bat = new PImage[2];
PImage sleepyBat;
PImage hammer;
Image heart, heart2, heart3, heart4, heart5;

Gif sheepGif;

//keyboard
boolean wkey, akey, dkey, skey;
boolean upkey, leftkey, rightkey, downkey, spacekey;

//mouse
boolean mouseReleased;
boolean wasPressed;

FPlayer player;
boolean addImages = true;

PImage map;
int gridSize = 32;

int immuneTimer = 0;
boolean immuneAh = false;

//other
float zoom = 1.5;
int lives = 5;
int spikeCounter = 60;
ArrayList<FGameObject> terrain = new ArrayList <FGameObject>();
ArrayList<FGameObject> enemies = new ArrayList <FGameObject>();
ArrayList<FHammer> hammers = new ArrayList <FHammer>();
boolean win = false;
int fluffCount = 0;

Minim minim;
AudioPlayer main;

PFont mainFont;
int orbCount = 0;

void initializeStuff() {  
  heart = new Image("HeartImage.png", 80, 15, 30, 30);
  heart2 = new Image("HeartImage.png", 110, 15, 30, 30);
  heart3 = new Image("HeartImage.png", 140, 15, 30, 30);
  heart4 = new Image("HeartImage.png", 170, 15, 30, 30);
  heart5 = new Image("HeartImage.png", 200, 15, 30, 30);
  
  //Button(float _x, float _y, float _w, float _h, float corner, color _base, color borderC, String _text, int tS) {
  gameButton = new Button(350, 325, 200, 200, 10, color(255, 255, 255, 100), color(255, 255, 255, 50), "start", 60);
  restartButton = new Button(350, 400, 200, 50, 3, color(255, 255, 255, 100), color(255, 255, 255, 50), "retry", 30);
  
  //Gif(String b, String a, float _x, float _y, float _w, float _h, int numOfFrames, float s)
  sheepGif = new Gif("Characters/MCSheepIdle(", ").png", 125, 325, 150, 150, 2, 0.01);
}

// setup -----------------------------------------------------------------------------------------------------------------
void setup() {
  size(500, 500);
  Fisica.init(this);
  
  initializeStuff();
  mainFont = createFont("Milky Coffee.otf", 100);
  
  regen = loadImage("HeartImage.png");

  map = loadImage("PlatformerMap21.png");
  grassBCenter = loadImage("Images/SnowBlock.png");
  grassBLeft = loadImage("Images/SnowBlockL.png");
  grassBRight = loadImage("Images/SnowBlockR.png");
  
  immune = loadImage("ImmunityImage.png");

  dirtB = loadImage("Images/DirtBlock.png");
  dirtL = loadImage("Images/DirtBlockL.png");
  dirtR = loadImage("Images/DirtBlockR.png");
  dirtLBC = loadImage("Images/DirtBlockLBC.png");
  dirtRBC= loadImage("Images/DirtBlockRBC.png");
  dirtLTC = loadImage("Images/DirtBlockLTC.png");
  dirtRTC= loadImage("Images/DirtBlockRTC.png");

  iceB = loadImage("Images/IceBlock.png");
  treeTrunk = loadImage("Images/TreeBlock.png");
  leavesTrunk = loadImage("Images/LeavesTrunkBlock.png");
  leavesLeft = loadImage("Images/LeavesLeftBlock.png");
  leavesRight = loadImage("Images/LeavesRightBlock.png");
  leavesMiddle = loadImage("Images/LeavesFloatBlock.png");
  
  fluffs[0] = loadImage("Images/FluffImage(0).png");
  fluffs[1] = loadImage("Images/FluffImage(1).png");
  
  spikes = loadImage("Images/SpikeBlock.png");
  spikes2 = loadImage("Images/Spikes2Image.png");
  bridge = loadImage("Images/BridgeBlock.png");
  bounce = loadImage("Images/BounceBlock.png");
  
  idle[0] = loadImage("Characters/MCSheepIdle(0).png");
  idle[0].resize(32, 32);
  idle[1] = loadImage("Characters/MCSheepIdle(1).png");
  idle[1].resize(32, 32);
  
  jump[0] = loadImage("Characters/MCSheepJump.png");
  jump[0].resize(32, 32);
  
  run[0] = loadImage("Characters/MCSheepRun(0).png");
  run[0].resize(32, 32);
  run[1] = loadImage("Characters/MCSheepRun(1).png");
  run[1].resize(32, 32);
  run[2] = loadImage("Characters/MCSheepRun(2).png");
  run[2].resize(32, 32);
  action = idle;
  
  littleDs[0] = loadImage("Characters/LittleDImage(0).png");
  littleDs[0].resize(32, 32);
  littleDs[1] = loadImage("Characters/LittleDImage(1).png");
  littleDs[1].resize(32, 32);
  
  sharks[0] = loadImage("Characters/SharkImage(0).png");
  sharks[0].resize(32, 32);
  sharks[1] = loadImage("Characters/SharkImage(1).png");
  sharks[1].resize(32, 32);
  
  hammer = loadImage("Images/HammerImage.png");
  
  thwompA = loadImage("Images/ThwompAngry.png");
  thwompA.resize(75, 75);
  thwompS = loadImage("Images/ThwompSleepy.png");
  thwompS.resize(75, 75);
  
  bat[0] = loadImage("Images/BatImage(0).png");
  bat[0].resize(50, 50);
  bat[1] = loadImage("Images/BatImage(1).png");
  bat[1].resize(50, 50);
  
  sleepyBat = loadImage("Images/BatSleepy.png");
  sleepyBat.resize(50, 50);
  
  loadOrbs(oneOrbs, 1);
  loadOrbs(twoOrbs, 2);
  loadOrbs(threeOrbs, 3);
  loadOrbs(fourOrbs, 4);
  loadOrbs(fiveOrbs, 5);
  loadOrbs(sixOrbs, 6);
  loadOrbs(sevenOrbs, 7);
  
  for (int i = 0; i < lavaBlocks.length; i++) {
    lavaBlocks[i] = loadImage("Images/LavaBlock(" + i + ").png");
  }
  lavaBottom = loadImage("Images/LavaBottomBlock.png");
  
  for (int i = 0; i < waterBlocks.length; i++) {
    waterBlocks[i] = loadImage("Images/waterBlock(" + i + ").png");
  }
  
  loadWorld(map);
  loadPlayer();
  
  minim = new Minim(this);
  
  mode = INTRO;
}

void loadOrbs(PImage[] orb, int num) {
  for (int i = 0; i < orb.length; i++) {
    orb[i] = loadImage("Images/" + num + "Orb(" + i + ").png");
  }
}

// load world ------------------------------------------------------------------------------------------------------------
void loadWorld(PImage map) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 981);
  for (int y = 0; y < map.height; y++) {
    for (int x = 0; x < map.width; x++) {
      color c = map.get(x, y);
      
      if (c == grassColour || c == grassRight || c == grassLeft) {
        FBox b = new FBox(gridSize, gridSize);
        snowBlocks(c, b);
        blockBasics(c, b, x, y);
        world.add(b);
      }
      
      if (c == dirtColour || c == dirtLeft || c == dirtRight || c == dirtCLBC || c == dirtCLTC || c == dirtCRBC || c == dirtCRTC) {
        FBox b = new FBox(gridSize, gridSize);
        dirtBlocks(c, b);
        blockBasics(c, b, x, y);
        world.add(b);
      }
      
      if (c == iceColour) {
        FBox b = new FBox(gridSize, gridSize);
        elementBlocks(c, b);
        blockBasics(c, b, x, y);
        world.add(b);
      }
      
      if (c == lavaColour && map.get((int) x, (int) y - 1) == lavaColour) {
        FBox b = new FBox(gridSize, gridSize);
        b.attachImage(lavaBottom);
        b.setName("lava");
        b.setFriction(3);
        b.setStatic(true);  
        if (addImages) lavaBottom.resize(32, 32);
        blockBasics(c, b, x, y);
        world.add(b);
      }
      
      else if (c == lavaColour) {
        FLava la = new FLava(x*gridSize, y*gridSize);
        terrain.add(la);
        world.add(la);
      }
      
      if (c == regenColour) {
        FGen gen = new FGen(x*gridSize, y*gridSize);
        enemies.add(gen);
        world.add(gen);
      }
      
      if (c == protect) {
        FProtect pro = new FProtect(x*gridSize, y*gridSize);
        enemies.add(pro);
        world.add(pro);
      }
      
      if (c == waterColour) {
        FWater lw = new FWater(x*gridSize, y*gridSize);
        terrain.add(lw);
        world.add(lw);
      }
      
      if (c == leavesColour || c == trunkColour) {
        FBox b = new FBox(gridSize, gridSize);
        otherBlocks(c, b, x, y);
        blockBasics(c, b, x, y);
        world.add(b);
      }
      
      if (c == spikeColour) {
        FBox b = new FBox(gridSize, gridSize);
        specialBlocks(c, b);
        blockBasics(c, b, x, y);
        world.add(b);
      }
      
      if (c == spikes2Colour) {
        FBox b = new FBox(gridSize, gridSize);
        specialBlocks(c, b);
        blockBasics(c, b, x, y);
        world.add(b);
      }
      
      if (c == fluffColour) {
        Fluffs b = new Fluffs(x*gridSize, y*gridSize);
        terrain.add(b);
        world.add(b);
      }
      
      if (c == giftColour) {
        if (y * gridSize < 640) {
          Orbs b = new Orbs(x*gridSize, y*gridSize, twoOrbs); 
          terrain.add(b);
          world.add(b);
        }
        else if (y * gridSize < 864) {
          Orbs b = new Orbs(x*gridSize, y*gridSize, sixOrbs);
          terrain.add(b);
          world.add(b);
        }
        else if (y * gridSize < 928) {
          Orbs b = new Orbs(x*gridSize, y*gridSize, threeOrbs);
          terrain.add(b);
          world.add(b);
        }
        else if (y * gridSize < 1024) {
          Orbs b = new Orbs(x*gridSize, y*gridSize, sevenOrbs);
          terrain.add(b);
          world.add(b);
        }
        else if (y * gridSize < 1200) {
          Orbs b = new Orbs(x*gridSize, y*gridSize, fourOrbs);
          terrain.add(b);
          world.add(b);
        }
        else if (y * gridSize < 1350) {
          Orbs b = new Orbs(x*gridSize, y*gridSize, oneOrbs);
          terrain.add(b);
          world.add(b);
        }
        else {
          Orbs b = new Orbs(x*gridSize, y*gridSize, fiveOrbs);
          terrain.add(b);
          world.add(b);
        }
      }
      
      if (c == bridgeColour) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      }
      if (c == littleDColour) {
        FShark sha = new FShark(x*gridSize, y*gridSize);
        enemies.add(sha);
        world.add(sha);
      }
      
      if (c == thwompColour) {
        FThwomp tho = new FThwomp(x*gridSize, y*gridSize);
        enemies.add(tho);
        world.add(tho);
      }
      
      if (c == batColour) {
        FBat bat = new FBat(x*gridSize, y*gridSize);
        enemies.add(bat);
        world.add(bat);
      }
      
      if (c == sharkColour) {
        FLittleD ld = new FLittleD(x*gridSize, y*gridSize);
        enemies.add(ld);
        world.add(ld);
      }
      
      if (c == wallColour) {
        FBox b = new FBox(gridSize, gridSize);
        b.setStatic(true);
        b.setName("wall");
        b.setSensor(true);
        blockBasics(c, b, x, y);
        b.setFill(color(0, 0, 0, 0));
        b.setStroke(color(0, 0, 0, 0));
        world.add(b);
      }
      
      if (c == bounceColour) {
        FBox b = new FBox(gridSize, gridSize);
        b.attachImage(bounce);
        b.setName("bounce");
        b.setFriction(3);
        b.setStatic(true);
        b.setRestitution(1.5);
        if (addImages) bounce.resize(32, 32);
        blockBasics(c, b, x, y);
        world.add(b);
      }
    }
  }
}

void blockBasics(color c, FBox b, float x, float y) {
  b.setPosition(x*gridSize, y*gridSize);
  b.setGrabbable(false);
  b.setStatic(true);
  b.setFillColor(c);
  b.setStrokeColor(c);
}

void snowBlocks(color c, FBox b) {
  if (c == grassColour) {
    b.attachImage(grassBCenter);
    b.setName("snow");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) grassBCenter.resize(32, 32);
  }

  if (c == grassLeft) {
    b.attachImage(grassBLeft);
    b.setName("snow");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) grassBLeft.resize(32, 32);
  }

  if (c == grassRight) {
    b.attachImage(grassBRight);
    b.setName("snow");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) grassBRight.resize(32, 32);
  }
}

void dirtBlocks(color c, FBox b) {
  if (c == dirtColour) {
    b.attachImage(dirtB);
    b.setName("dirt");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) dirtB.resize(32, 32);
  }
  if (c == dirtLeft) {
    b.attachImage(dirtL);
    b.setName("dirt");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) dirtL.resize(32, 32);
  }
  if (c == dirtRight) {
    b.attachImage(dirtR);
    b.setName("dirt");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) dirtR.resize(32, 32);
  }
  if (c == dirtCRTC) {
    b.attachImage(dirtRTC);
    b.setName("wall");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) dirtRTC.resize(32, 32);
  }
  if (c == dirtCRBC) {
    b.attachImage(dirtRBC);
    b.setName("wall");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) dirtRBC.resize(32, 32);
  }
  if (c == dirtCLBC) {
    b.attachImage(dirtLBC);
    b.setName("wall");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) dirtLBC.resize(32, 32);
  }
  if (c == dirtCLTC) {
    b.attachImage(dirtLTC);
    b.setName("wall");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) dirtLTC.resize(32, 32);
  }
}

void elementBlocks(color c, FBox b) {
  if (c == iceColour) {
    b.attachImage(iceB);
    b.setName("ice");
    b.setFriction(0);
    b.setStatic(true);
    if (addImages) iceB.resize(32, 32);
  }
}

void otherBlocks(color c, FBox b, float x, float y) {
  if (c == trunkColour) {
    b.attachImage(treeTrunk);
    b.setName("trunk");
    b.setFriction(3);
    b.setStatic(true);
    b.setSensor(true);
    if (addImages) treeTrunk.resize(32, 32);
  }
  
  if (c == leavesColour && map.get((int) x, (int) y + 1) == trunkColour) {
    b.attachImage(leavesTrunk);
    b.setName("leaves");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) leavesTrunk.resize(32, 32);
  }
  
  else if (c == leavesColour && map.get((int) x + 1, (int) y) == leavesColour && map.get((int) x - 1, (int) y) == leavesColour) {
    b.attachImage(leavesMiddle);
    b.setName("leaves");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) leavesMiddle.resize(32, 32);
  }
  
  else if (c == leavesColour && map.get((int) x - 1, (int) y) == leavesColour) {
    b.attachImage(leavesRight);
    b.setName("leaves");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) leavesRight.resize(32, 32);
  }
  
  else if (c == leavesColour && map.get((int) x + 1, (int) y) == leavesColour) {
    b.attachImage(leavesLeft);
    b.setName("leaves");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) leavesLeft.resize(32, 32);
  }
}

void specialBlocks(color c, FBox b) {
  if (c == spikeColour || c == spikes2Colour) {
    if (c == spikeColour) b.attachImage(spikes);
    if (c == spikes2Colour) b.attachImage(spikes2);
    b.setName("spikes");
    b.setFriction(3);
    b.setStatic(true);
    if (addImages) spikes.resize(32, 32);
    spikes2.resize(32, 32);
  }
}

// other -----------------------------------------------------------------------------------------------------------------
void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(#496590);
  clicks();
  if (mode == INTRO) 
    intro();
  else if (mode == SETTING) 
    setting();
  else if (mode == GAME) 
    game();
  else if (mode == GAMEOVER) 
    gameover();
  else if (mode == INSTRUCTIONS)
    instructions();
  else 
    println("Error: Mode = " + mode);
  
  //println(player.getX(), player.getY());
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX() * zoom + width/2, -player.getY() * zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    terrain.get(i).act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).act();
  }
  for (int i = 0; i < hammers.size(); i++) {
    hammers.get(i).act();
    if (hammers.get(i).hammerLives == 0) {
      world.remove(hammers.get(i));
      hammers.remove(i);
    }
  }
}
