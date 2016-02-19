public class Player {
  
  int playerid;
  String firstname;
  String lastname;
  int jerseynumber;
  String position;
  int teamid;
  float xpos;
  float ypos;
  color dispColor;
  color strokeColor;
  boolean over;
  
  public Player() {
    xpos = -1;
    ypos = -1;
    dispColor = color(255,153,51);
    strokeColor = color(220,153,51);
    firstname = "Basket";
    lastname = "Ball";
  }
  
  public Player(TableRow row) {
    
    playerid = row.getInt("playerid");
    firstname = row.getString("firstname");
    lastname = row.getString("lastname");
    jerseynumber = row.getInt("jerseynumber");
    position = row.getString("position");
    teamid = row.getInt("teamid");
    xpos = -1;
    ypos = -1;
    dispColor = color(0,255,0);
  }
  
  public Player(TableRow row, color dispColor, color strokeColor) {
    
    playerid = row.getInt("playerid");
    firstname = row.getString("firstname");
    lastname = row.getString("lastname");
    jerseynumber = row.getInt("jerseynumber");
    position = row.getString("position");
    teamid = row.getInt("teamid");
    xpos = -1;
    ypos = -1;
    this.dispColor = dispColor;
    this.strokeColor = strokeColor;
  }
  
  public void update(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  public void changeColor() {
    dispColor = color(0,0,255);
  }
  
  public void draw() {
    
    stroke(strokeColor);
    strokeWeight(scaleFactor*(5));
    fill(dispColor);
    ellipse(scaleFactor*(xpos*16 + xOffset), scaleFactor*(ypos*16 + yOffset), scaleFactor*(20), scaleFactor*(20));
    selectedPlayer();
  }
  
  boolean overEvent() {
    //println("mouseX:" + mouseX);
    if (mouseX > scaleFactor*(xpos*16 + xOffset)-scaleFactor*(10) && mouseX < scaleFactor*(xpos*16 + xOffset)+scaleFactor*(10) &&
       mouseY > scaleFactor*(ypos*16 + yOffset)-scaleFactor*(10) && mouseY < scaleFactor*(ypos*16 + yOffset)+scaleFactor*(10)) {
      return true;
    } else {
      return false;
    }
  }
  
  public void selectedPlayer() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      println("player: " + firstname + " " + lastname);
      if(teamid>0){
        displayData.setPlayerStats(this);
      }
    }
  }
}