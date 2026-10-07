import processing.sound.SoundFile;
import java.util.function.BiFunction;

public class Block{
  private final int MAX_TRIALS = 20;
  
  public final int ID;
  private final PApplet PARENT;
  private final int NUM_RECTS;  // 2, 4, 8
  
  private int trialCount = 0;
  private Trial trial;
  private Runnable callback;

  Rectangle startButton;
  Rectangle rectangles[];
  
  public Block(PApplet parent, int id, int numRects){
    PARENT = parent;
    ID = id;
    NUM_RECTS = numRects;
    initializeStartButton();
    initializeRects();
  }
  public void drawScene(){
    fill(startButton.colour);
    rect(startButton.x, startButton.y, startButton.w, startButton.h);
    for(Rectangle r : rectangles)
    {
      fill(r.colour);
      rect(r.x, r.y, r.w, r.h);
    }
  }
  
  private void printTrialStats(Trial t){
    // user#, block#, trial#, elapsedTime, numberOferrors
    String out = String.format("%d, %d, %d, %d, %d", USER_ID, ID, trialCount, t.getDuration(), t.errorCount);
    System.out.println(out);
  }
  
  public void clicked(int x, int y){
    if(trial == null || !trial.isRunning()){
      if(startButton.containsPoint(x, y)){
        trial = new Trial(PARENT, rectangles);
        trial.startTrial();
      }
      return;
    }// else
    boolean trialFinished = trial.trialClick(x, y);
    if(trialFinished){
      trialCount++;
      printTrialStats(trial);
      if(trialCount >= MAX_TRIALS){
        finishBlock();
      }
    }
  }
  public void setCallback(Runnable r){
    callback = r; 
  }
  private void finishBlock(){
     if(callback != null){
       callback.run();
     }
  }
  
  
//---------------------------------------- Basic Rect logic-----------------------------------------
  private void initializeStartButton(){
    final int W = 90;
    final int H = 90;
    int x = width / 2;
    int y = height / 2;
    startButton = new Rectangle(x, y, W, H, 0xFFFF0000);
  }

  private void initializeRects(){
    final int RECT_WIDTH = 120;
    final int RECT_HEIGHT = 100;
    final int DIST_FROM_START = 200;
    BiFunction<Integer, Integer, Rectangle> makeRect = (x, y) -> {
      return new Rectangle(x, y, RECT_WIDTH, RECT_HEIGHT, DEFAULT_RECT_COLOUR); 
    };
    rectangles = new Rectangle[NUM_RECTS];  
    rectangles[0] = makeRect.apply(startButton.x, startButton.y - DIST_FROM_START);
    rectangles[1] = makeRect.apply(startButton.x, startButton.y + DIST_FROM_START);
    if(NUM_RECTS >= 4){
      rectangles[2] = makeRect.apply(startButton.x - DIST_FROM_START, startButton.y); 
      rectangles[3] = makeRect.apply(startButton.x + DIST_FROM_START, startButton.y); 
      
      if(NUM_RECTS >= 8){
        int offset = Math.round(DIST_FROM_START / (float)Math.sqrt(2));
        rectangles[4] = makeRect.apply(startButton.x + offset, startButton.y + offset);
        rectangles[5] = makeRect.apply(startButton.x + offset, startButton.y - offset);
        rectangles[6] = makeRect.apply(startButton.x - offset, startButton.y + offset);
        rectangles[7] = makeRect.apply(startButton.x - offset, startButton.y - offset);
      }
    }
  }
}
