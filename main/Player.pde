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
  
  Hashtable<Integer, Double> distanceTraveled;
  Hashtable<Integer, Double> averageSpeed;
  Hashtable<Integer, Double> distanceToBall;
  
  public Player() {
    teamid = -1;
    xpos = -1;
    ypos = -1;
    dispColor = color(255,153,51);
    strokeColor = color(220,153,51);
    firstname = "Basket";
    lastname = "Ball";
    distanceToBall = new Hashtable<Integer, Double>();
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
    distanceTraveled = new Hashtable<Integer, Double>();
    averageSpeed = new Hashtable<Integer, Double>();
    distanceToBall = new Hashtable<Integer, Double>();
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
    distanceTraveled = new Hashtable<Integer, Double>();
    averageSpeed = new Hashtable<Integer, Double>();
    distanceToBall = new Hashtable<Integer, Double>();
  }
  
  public void update(float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  public void ballPreprocess(float xpos, float ypos, int moment){
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  float prevY;
  float prevX;
  double totDistance;
  double totDistanceForAvg;
  float gameClockMax;
  
  public void preprocess(float gameClock, float xpos, float ypos, int moment) {
    
    //total distance, starts calculating immediately
    double calcDistance;
    if(moment == 0){
      gameClockMax = gameClock;
      totDistance=0;
      prevY = ypos;
      prevX = xpos;
    }
    float resultX = Math.abs(ypos - prevY);
    float resultY = Math.abs(xpos - prevX);
    calcDistance = Math.sqrt((resultY)*(resultY) + (resultX)*(resultX));
    distanceTraveled.put(moment, calcDistance+totDistance);
    totDistance = totDistance + calcDistance;
    prevY = ypos;
    prevX = xpos;
    
    //avg speed, starts calculating when gameClock starts
    if((gameClockMax - gameClock) < 1){
      averageSpeed.put(moment, (double)0);
      totDistanceForAvg = 0;
    }
    else{
      averageSpeed.put(moment, totDistanceForAvg/(gameClockMax - gameClock));
      totDistanceForAvg = totDistanceForAvg + calcDistance;
    }
    
    //distanceToBall, starts calculating immediately
    resultX = Math.abs(ypos - Ball.ypos);
    resultY = Math.abs(xpos - Ball.xpos);
    double ballDistance = Math.sqrt((resultY)*(resultY) + (resultX)*(resultX));
    distanceToBall.put(moment, ballDistance);
  }
  
  public void changeColor() {
    dispColor = color(0,0,255);
  }
  
  float zpos;
  public void setZ(float zpos){
    this.zpos = zpos;
  }
  
  public void draw() {
    
    if(teamid < 0){
      float scaleBall = (zpos) / 5.0;
      stroke(0);
      strokeWeight(1);
      fill(dispColor);
      ellipse(scaleFactor*(xpos*16 + xOffset), scaleFactor*(ypos*16 + yOffset), scaleBall*scaleFactor*(20), scaleBall*scaleFactor*(20));
    }
    else{
      stroke(strokeColor);
      strokeWeight(scaleFactor*(5));
      fill(dispColor);
      ellipse(scaleFactor*(xpos*16 + xOffset), scaleFactor*(ypos*16 + yOffset), scaleFactor*(20), scaleFactor*(20));
    }
    selectedPlayer();
  }
  
  boolean overEvent() {
    //println("mouseX:" + mouseX);
    if (mouseX > scaleFactor*(xpos*16 + xOffset)-scaleFactor*(15) && mouseX < scaleFactor*(xpos*16 + xOffset)+scaleFactor*(15) &&
       mouseY > scaleFactor*(ypos*16 + yOffset)-scaleFactor*(15) && mouseY < scaleFactor*(ypos*16 + yOffset)+scaleFactor*(15)) {
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
      delay(100);
      if(teamid>0){
        displayData.setPlayerStats(this);
      }
    }
  }
}