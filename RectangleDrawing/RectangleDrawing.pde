import processing.sound.SoundFile;

import java.util.function.BiFunction;

final int DEFAULT_RECT_COLOUR = 0xFF3355FF;
SoundFile successfulClickSound; 

int numRects = 8;  // 2, 4, 8
Rectangle startButton;
Rectangle rectangles[];
Trial trial;


void setup() {
  size(800, 600);
  rectMode(CENTER);
  noStroke();
  successfulClickSound = new SoundFile(this, "ping.mp3");
  initializeStartButton();
  initializeRects();
}
void draw() {
  background(204);
  fill(startButton.colour);
  rect(startButton.x, startButton.y, startButton.w, startButton.h);
  for(Rectangle r : rectangles)
  {
    fill(r.colour);
    rect(r.x, r.y, r.w, r.h);
  }
}

/* 
  mouseClicked would be nice but even small drags dont count as a click. mousePressed is 
  on mouse down, which means the light will start before the subject is done a click.
*/  
void mousePressed() {
  if(trial == null || !trial.isRunning()){
    if(startButton.containsPoint(mouseX, mouseY)){
      trial = new Trial(rectangles);
      trial.startTrial();
    }
    return;
  }// else
  int source = getContainingRectIndex(mouseX, mouseY);
  if(source == trial.chosenIndex){
    trial.endTrial();
    successfulClickSound.play();
    printTrialStats(trial);
  }
  else{
    trial.errorCount++; 
  }
}

// -1 is none
int getContainingRectIndex(int x, int y){
  int source = -1;
  for(int i = 0; i < rectangles.length && source == -1; i++){
    if(rectangles[i].containsPoint(x, y)){
      source = i;
    }
  }
  return source;
}

void printTrialStats(Trial t){
  // user#, block#, trial#, elapsedTime, numberOferrors
  String out = String.format("%d, %d, %d, %d, %d", 0, 0, 0, t.getDuration(), t.errorCount);
  System.out.println(out);
}

//---------------------------------------- Basic Rect logic-----------------------------------------

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
    return new Rectangle(x, y, RECT_WIDTH, RECT_HEIGHT, DEFAULT_RECT_COLOUR); 
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
}
