class FGameObject extends FBox {
  final int L = -1;
  final int R = 1;

  FGameObject() {
    super(gridSize, gridSize);
  }
  
  FGameObject(float w, float h) {
    super(w, h);
  }
  
  void act() {
  }
  
  boolean isTouching(String n) {
    ArrayList<FContact> collisions = getContacts();
    for (int i = 0; i < collisions.size(); i++) {
      FContact fc = collisions.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }
}
