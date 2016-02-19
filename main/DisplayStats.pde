public class DisplayStats {
  
  int shotClock;
  int gameClock;
  int period;
  boolean isDispPlayer;
  Player dispPlayer;
  String homeTeam;
  String visitorTeam;
  String url;
  
  PFont hightech; // Digital Clock Font
  
  PImage webImg;
  
  int sec;
  int minutes;
  
  float gameClockX1;
  float gameClockX2;
  
  public DisplayStats(){ // constructor
  url = "http://i.cdn.turner.com/nba/nba/.element/img/2.0/sect/statscube/players/large/";
  hightech = loadFont("fonts/LCD5x8H-48.vlw");
  shotClock = 0;
  gameClock = 0;
  period = 0;
  isDispPlayer = false;
  gameClockX1 = scaleFactor * xOffset + scaleFactor*(1504/2) - 130;
  gameClockX2 = gameClockX1 + 260;
  }
  
  public void update(TableRow row) {
    shotClock = (int) Math.ceil(row.getFloat(SHOTCLOCK));
    gameClock = (int) Math.ceil(row.getFloat(GAMECLOCK));
    period = row.getInt(PERIOD);
    sec = gameClock % 60;
    minutes = gameClock / 60;
  }
  
  public void draw() {
    drawGameClock();
    if(isDispPlayer){
      image(webImg, 10, 600);
    }
  }
  
  public void setPlayerStats(Player tempPlayer){
    isDispPlayer = true;
    dispPlayer = tempPlayer;
    webImg = loadImage(url + dispPlayer.firstname.toLowerCase() + "_" + dispPlayer.lastname.toLowerCase() + ".png");
  }
  
  public void drawShotClock() {
    fill(0);
    strokeWeight(4);
    stroke(0,69,162);
    quad(scaleFactor * xOffset,20,scaleFactor * xOffset + 128,20,scaleFactor * xOffset + 128,120,scaleFactor * xOffset,120);
  }
  
  public void drawGameClock() {
    drawShotClock();
    fill(0);
    strokeWeight(4);
    stroke(0,69,162);
    quad(gameClockX1,20,gameClockX2,20,gameClockX2,120,gameClockX1,120);

    float clockMid = (gameClockX2 - gameClockX1) / 2;
    fill(#ffe600);
    //noStroke();
    stroke(#ffe600);
    //quad(gameClockX1 + clockMid - 6,55,gameClockX1 + clockMid -3,55,gameClockX1 + clockMid - 3,85,gameClockX1 + clockMid - 6,85);
    //quad(gameClockX1 + clockMid + 6,55,gameClockX1 + clockMid + 3,55,gameClockX1 + clockMid + 3,85,gameClockX1 + clockMid + 6,85);
    quad(gameClockX1 + clockMid - 4,55,gameClockX1 + clockMid - 3,55,gameClockX1 + clockMid - 3,56,gameClockX1 + clockMid - 4,56);
    quad(gameClockX1 + clockMid + 4,84,gameClockX1 + clockMid + 3,84,gameClockX1 + clockMid + 3,85,gameClockX1 + clockMid + 4,85);
    quad(gameClockX1 + clockMid - 4,84,gameClockX1 + clockMid - 3,84,gameClockX1 + clockMid - 3,85,gameClockX1 + clockMid - 4,85);
    quad(gameClockX1 + clockMid + 4,55,gameClockX1 + clockMid + 3,55,gameClockX1 + clockMid + 3,56,gameClockX1 + clockMid + 4,56);
    
    quad(gameClockX1 + clockMid - 4,49,gameClockX1 + clockMid - 3,49,gameClockX1 + clockMid - 3,50,gameClockX1 + clockMid - 4,50);
    quad(gameClockX1 + clockMid + 4,90,gameClockX1 + clockMid + 3,90,gameClockX1 + clockMid + 3,91,gameClockX1 + clockMid + 4,91);
    quad(gameClockX1 + clockMid - 4,90,gameClockX1 + clockMid - 3,90,gameClockX1 + clockMid - 3,91,gameClockX1 + clockMid - 4,91);
    quad(gameClockX1 + clockMid + 4,49,gameClockX1 + clockMid + 3,49,gameClockX1 + clockMid + 3,50,gameClockX1 + clockMid + 4,50);
    
    // game clock
    textFont(hightech,75);
    fill(#ffe600);
    textAlign(CENTER);
    text(sec,gameClockX2 - 60,98);
    
    fill(#ffe600);
    textAlign(CENTER);
    text(minutes,gameClockX2 - 195,98);

    // shot clock
    fill(#ff3d3d);
    textAlign(CENTER);
    text(shotClock,scaleFactor*xOffset + 70,98);
  }
  
}