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
  
  public Player() {
    xpos = 0;
    ypos = 0;
    dispColor = color(255,153,51);
    strokeColor = color(220,153,51);
  }
  
  public Player(TableRow row) {
    
    playerid = row.getInt("playerid");
    firstname = row.getString("firstname");
    lastname = row.getString("lastname");
    jerseynumber = row.getInt("jerseynumber");
    position = row.getString("position");
    teamid = row.getInt("teamid");
    xpos = 0;
    ypos = 0;
    dispColor = color(0,255,0);
  }
  
  public Player(TableRow row, color dispColor, color strokeColor) {
    
    playerid = row.getInt("playerid");
    firstname = row.getString("firstname");
    lastname = row.getString("lastname");
    jerseynumber = row.getInt("jerseynumber");
    position = row.getString("position");
    teamid = row.getInt("teamid");
    xpos = 0;
    ypos = 0;
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
    //point(xpos*(400.0/94) + 54, ypos*(225.0/50) + 150);
    //ellipse(xpos*(400.0/94) + 50, ypos*(225.0/50) + 150, 5, 5);
    //point(xpos*(423.0/94) + 54, ypos*(225.0/50) + 150);//drawcourt2
    ellipse(scaleFactor*(xpos*16 + xOffset), scaleFactor*(ypos*16 + yOffset), scaleFactor*(20), scaleFactor*(20));
  }
}