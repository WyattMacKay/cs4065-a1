import java.util.function.BiFunction;

int numRects = 2;
Rectangle startButton;
Rectangle rectangles[];

void setup() {
  size(800, 600);
  rectMode(CENTER);
  noStroke();
  initializeStartButton();
  initializeRects();
}

void initializeStartButton(){
  final int W = 120;
  final int H = 60;
  int x = width / 2;
  int y = height / 2;
  startButton = new Rectangle(x, y, W, H, 0xFFFF0000);
}

void initializeRects(){
  final int RECT_WIDTH = 120;
  final int RECT_HEIGHT = 100;
  final int DIST_FROM_START = 150;
  BiFunction<Integer, Integer, Rectangle> makeRect = (x, y) -> {
    return new Rectangle(x, y, RECT_WIDTH, RECT_HEIGHT, 0xFF1111FF); 
  };
  rectangles = new Rectangle[numRects];  
  rectangles[0] = makeRect.apply(startButton.x, startButton.y - DIST_FROM_START);
  rectangles[1] = makeRect.apply(startButton.x, startButton.y + DIST_FROM_START);
  // TODO: size 4, 8
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
