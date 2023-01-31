class Gif {
  String before, after;
  float x, y, w, h;
  float speed;
  int frames;
  PImage[] gifShow;
  int f;
  
  Gif(String b, String a, float _x, float _y, float _w, float _h, int numOfFrames, float s) {
    before = b;
    after = a;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    f = 0;
    speed = s;
    gifShow = new PImage[numOfFrames];
    for (int i = 0; i < numOfFrames; i++) {
      gifShow[i] = loadImage(before + i + after);
    }
  }
  
  void show() {
    image(gifShow[f], x, y, w, h);
      if (frameCount % 8 == 0)
        f++;
      if (f == gifShow.length)
        f = 0;
  }
}
