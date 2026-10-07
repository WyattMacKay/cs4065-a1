public class Trial{
  final int TRIAL_COLOUR = 0xFF33DEFE;
  private final int DEFAULT_RECT_COLOUR = 0xFF3355FF;
  private final SoundFile SUCCESSFUL_CLICK_SOUND; 
  
  private boolean isRunning = false;
  private long startTime;
  private long endTime;
  public int errorCount = 0;
  
  private Rectangle[] rectangles;
  public int chosenIndex;
 
  public Trial(PApplet parent, Rectangle[] rects){
    rectangles = rects;
    chosenIndex = (int)(Math.random() * rects.length);
    SUCCESSFUL_CLICK_SOUND = new SoundFile(parent, "ping.mp3");
  }
 
  public void startTrial(){
    startTime = System.nanoTime();
    isRunning = true;
    rectangles[chosenIndex].colour = TRIAL_COLOUR;
  }
  public void endTrial(){
    endTime = System.nanoTime();
    isRunning = false;
    rectangles[chosenIndex].colour = DEFAULT_RECT_COLOUR;
  }
  public long getDuration(){
   return (endTime - startTime) / 1000000;  // in ms 
  }
  public boolean isRunning(){
    return isRunning;
  }
  // returns whether click successfully ended trial
  public boolean trialClick(int x, int y){
    int source = getContainingRectIndex(x, y);
    if(source == chosenIndex){
      endTrial();
      SUCCESSFUL_CLICK_SOUND.play();
      return true;  
    }
    errorCount++; 
    return false;
  }
   // -1 is none
  private int getContainingRectIndex(int x, int y){
    int source = -1;
    for(int i = 0; i < rectangles.length && source == -1; i++){
      if(rectangles[i].containsPoint(x, y)){
        source = i;
      }
    }
    return source;
  }
}
