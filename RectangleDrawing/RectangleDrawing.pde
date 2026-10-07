import java.util.function.BiFunction;

int numRects = 8;  // 2, 4, 8
Rectangle startButton;
Rectangle rectangles[];

void setup() {
  size(800, 600);
  rectMode(CENTER);
  noStroke();
  initializeStartButton();
  initializeRects();
}
void draw() {
  background(204);
  fill(startButton.colour);
  rect(startButton.x, startButton.y, startButton.width, startButton.height);
  for(Rectangle r : rectangles)
  {
    fill(r.colour);
    rect(r.x, r.y, r.width, r.height);
  }
}

void initializeStartButton(){
  final int W = 90;
  final int H = 90;
  int x = width / 2;
  int y = height / 2;
  startButton = new Rectangle(x, y, W, H, 0xFFFF0000);
}

void initializeRects(){
  final int RECT_WIDTH = 120;
  final int RECT_HEIGHT = 100;
  final int DIST_FROM_START = 200;
  BiFunction<Integer, Integer, Rectangle> makeRect = (x, y) -> {
    return new Rectangle(x, y, RECT_WIDTH, RECT_HEIGHT, 0xFF3355FF); 
  };
  rectangles = new Rectangle[numRects];  
  rectangles[0] = makeRect.apply(startButton.x, startButton.y - DIST_FROM_START);
  rectangles[1] = makeRect.apply(startButton.x, startButton.y + DIST_FROM_START);
  if(numRects >= 4){
    rectangles[2] = makeRect.apply(startButton.x - DIST_FROM_START, startButton.y); 
    rectangles[3] = makeRect.apply(startButton.x + DIST_FROM_START, startButton.y); 
    
    if(numRects >= 8){
      int offset = Math.round(DIST_FROM_START / (float)Math.sqrt(2));
      rectangles[4] = makeRect.apply(startButton.x + offset, startButton.y + offset);
      rectangles[5] = makeRect.apply(startButton.x + offset, startButton.y - offset);
      rectangles[6] = makeRect.apply(startButton.x - offset, startButton.y + offset);
      rectangles[7] = makeRect.apply(startButton.x - offset, startButton.y - offset);
    }
  }
  
  // TODO: size 4, 8
}

void mouseMoved() { // Move gray circle
  //moveX = mouseX;
  //moveY = mouseY;
}

void mouseDragged() { // Move black circle
  //dragX = mouseX;
  //dragY = mouseY;
}


class Rectangle {
  int x;
  int y;
  int width;
  int height;
  int colour;
 
  Rectangle(int posX, int posY, int width, int height, int colour){
    this.x = posX;
    this.y = posY;
    this.width = width;
    this.height = height;
    this.colour = colour;
  }
}
