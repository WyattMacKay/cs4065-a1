public class Trial{
  final int TRIAL_COLOUR = 0xFF33DEFE;
  
  private boolean isRunning = false;
  private long startTime;
  private long endTime;
  public int errorCount = 0;
  
  private Rectangle[] rectangles;
  public int chosenIndex;
 
  public Trial(Rectangle[] rects){
    rectangles = rects;
    chosenIndex = (int)(Math.random() * rects.length);
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
}
