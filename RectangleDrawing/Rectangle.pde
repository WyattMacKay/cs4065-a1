public class Rectangle {
  int x;
  int y;
  int w;
  int h;
  int colour;
 
  public Rectangle(int posX, int posY, int w, int h, int colour){
    this.x = posX;
    this.y = posY;
    this.w = w;
    this.h = h;
    this.colour = colour;
  }
  boolean containsPoint(int x, int y){
    final int WIDTH_RANGE = w / 2;
    final int HEIGHT_RANGE = h / 2;
    return (x >= this.x - WIDTH_RANGE && x <= this.x + WIDTH_RANGE && y >= this.y - HEIGHT_RANGE && y <= this.y + HEIGHT_RANGE);  
  }
}
