import java.util.function.BiFunction;

Block currBlock;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  noStroke();
  currBlock = new Block(this, 1, 8);
}
void draw() {
  background(204);
  currBlock.drawScene();
}

/* 
  mouseClicked would be nice but even small drags dont count as a click. mousePressed is 
  on mouse down, which means the light will start before the subject is done a click.
*/  
void mousePressed() {
  currBlock.clicked(mouseX, mouseY);
}
