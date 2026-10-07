import javax.swing.JOptionPane;

Block currBlock;
int blockID = 0;
final int MAX_BLOCKS = 3;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  noStroke();
  getUserID();
  loadNextBlock();
}
void draw() {
  background(204);
  if(currBlock != null){
    currBlock.drawScene();
  }
}

/* 
  mouseClicked would be nice but even small drags dont count as a click. mousePressed is 
  on mouse down, which means the light will start before the subject is done a click.
*/  
void mousePressed() {
  currBlock.clicked(mouseX, mouseY);
}

void getUserID(){
  int id = -1;
  while(id < 0){
    try{
      String input = JOptionPane.showInputDialog(null, "User ID:");
      id = Integer.parseInt(input);
    }
    catch (NumberFormatException e){}
  }
  USER_ID = id;
}

void loadNextBlock(){
  blockID++;
  if(blockID > MAX_BLOCKS){
    endStudy();
    return;
  }
  JOptionPane.showMessageDialog(null, "You are about to start block #" + blockID, 
                                "Block Starting", JOptionPane.INFORMATION_MESSAGE);
  currBlock = new Block(this, blockID, 1 << blockID);
  currBlock.setCallback(this::loadNextBlock);
}

void endStudy(){
  currBlock = null;
  JOptionPane.showMessageDialog(null, "Thank you for participating.", 
                                "Study Complete", JOptionPane.INFORMATION_MESSAGE);
  exit();
}
