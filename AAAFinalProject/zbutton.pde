class Button {
  float x, y, w, h, c;
  color base, border, highlight;
  boolean clicked, circle, design;
  String text;
  PImage image;
  int textSize;
  String iconName;

  //rect button ------------------------------------------------------------------------
  Button(float _x, float _y, float _w, float _h, float corner, color _base, color borderC, String _text, int tS) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = corner;
    base = _base;
    border = borderC;
    text = _text;
    textSize = tS;
  }
  
  void show() {
    strokeWeight(3);
    ifClick(x, y, w, h);
      
    buttonDraw();
    textCreate();
  }
  
  //drawing -------------------------------------------------------------------------
  void buttonDraw() {
    strokeWeight(3);
    stroke(border);
    
    if (image != null) {
      image(image, x, y, w, h);
    }
    fill(base);
    tactile(x, y, w, h);
    
    rect(x, y, w, h, c);
  }
  
  void textCreate() {
    fill(255);
    textSize(textSize);
    text(text, x, y - 2);
  }
  
  //technical stuff? ----------------------------------------------------------------
  boolean insideButton(float x, float y, float w, float h) {  
    if (mouseX >= x - w/2 && mouseX <= x + w/2 && mouseY >= y - h/2 && mouseY <= y + h/2) 
      return true;
    return false;
  }
  
  void tactile(float x, float y, float w, float h) {
    if (insideButton(x, y, w, h)) {
      stroke(255);
      if (iconName != null) {
        textSize(20);
        fill(255);
        if (iconName == "settings")
          text(iconName, 580, 40);
        else 
          text(iconName, 600, 40);
      }
    }
  }
  
  void ifClick(float x, float y, float w, float h) {
    if (mouseReleased && insideButton(x, y, w, h)) 
      clicked = true;
    else
      clicked = false;
  }
  
  boolean getClicked() {
    return clicked;
  }
}

//images ------------------------------------------------------------------------------------------------------------------------------
class Image {
  PImage name;
  float x, y, w, h;
    
  Image(String i, float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    name = loadImage(i);
  }
  
  void show() {
    image(name, x, y, w, h);
  }
}
