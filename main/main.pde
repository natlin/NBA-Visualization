import controlP5.*;

import java.util.Hashtable;
//import java.util.ArrayList;
import java.util.*;
import java.util.Map.Entry;
import java.util.Arrays;
import java.util.List;
import java.util.Comparator;
import java.util.Iterator;
import java.io.File;

Table teamTable;
Table playerTable;
Table gamesTable;
Table oneEventTable;
Table colorTable;
Iterator eventCount;
ArrayList<String> gameEvents;
List<String> l;

int maxMoment = -1;
int gameid = 0;

int homeTeam = -1;
int visitorTeam = -1;

PFont vsFont;

int xOffset =560;
int yOffset = 200;
float scaleFactor = 0.75;

float tempXCenter;
float tempXOffset;
float tempYCenter;
float tempYOffset;

int vsScreenCounter = 0;

Player Ball;

int GAMEID = 0;
int TEAMID = 1;
int PLAYERID = 2;
int XPOS = 3;
int YPOS = 4;
int HEIGHT = 5;
int MOMENT = 6;
int GAMECLOCK = 7;
int SHOTCLOCK = 8;
int PERIOD = 9;

boolean isPlaying = false;

PFont f1, f2;

PImage homeImg;
PImage visitorImg;

PImage smallHomeImg;
PImage smallVisitorImg;

HScrollbar hs1;
ControlP5 cp5;
DisplayStats displayData;

void setup()
{
  //frameRate(150);
  size(1600, 900);
  background(255, 255, 255);
  Ball = new Player();
  drawCourt();
  loadTeam();
  loadPlayers();
  loadGames();
  //loadOneGame();
  f1 = createFont("Helvetica", 20);
  f2 = createFont("Helvetica", 12);
  
  tempXCenter = scaleFactor*(1504) / 2.0;
  tempXOffset = scaleFactor*(0 + xOffset);
  tempYCenter = scaleFactor*(800) / 2.0;
  tempYOffset = scaleFactor*(0 + yOffset);
  
  l = new ArrayList<String>();
  displayData = new DisplayStats();
  cp5 = new ControlP5(this);
  hs1 = new HScrollbar(0, height - 20, width, 30, 10);
  
  MenuList m = new MenuList( cp5, "menu", 360, 368 );
  
  m.setPosition(10, 10);
  
  for (TableRow row : teamTable.rows()) {
    String subline = row.getString("name");
    String headline = row.getString("abbreviation");
    String copy = row.getString("teamid");
    
    m.addItem(makeItem(headline, subline, copy, loadImage(sketchPath()+"/icons/" + headline + "2.png")));
  }

  cp5.addScrollableList("games")
     .setPosition(10, 400)
     .setSize(360, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     //.addItems(l)
     //.setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
     ;
  cp5.get(ScrollableList.class, "games").close();
  
  PImage[] imgs = {loadImage(sketchPath()+"/icons/button_a2.png"),loadImage(sketchPath()+"/icons/button_b2.png"),loadImage(sketchPath()+"/icons/button_c2.png"),loadImage(sketchPath()+"/icons/button_d2.png")};
  cp5.addButton("play")
     //.setValue(128)
     .setPosition(125,522)
     .setImages(imgs)
     .setSwitch(true)
     .setOff()
     .updateSize()
     ;
     
  PImage[] imgs2 = {loadImage(sketchPath()+"/icons/next_a.png"),loadImage(sketchPath()+"/icons/next_b.png"),loadImage(sketchPath()+"/icons/next_c.png")};
  cp5.addButton("nextEvent")
     //.setValue(1)
     .setPosition(205,522)
     .setImages(imgs2)
     //.setSwitch(true)
     //.setOff()
     .updateSize()
     ;
  
}


int moment = 0;
void draw()
{
  background(255, 255, 255);
  fill(0,140);
  rect(380,0,5,860);
  fill(0,40);
  rect(0,0,380,860);
  drawCourt();
  for(int i = moment * 11; i < (moment + 1) * 11; i++) {
    TableRow row;
    int teamID;
    try{
      row = oneEventTable.getRow(i);
      teamID = row.getInt(TEAMID);
    }
    catch(Exception e){
      break;
    }
    if(teamID < 0){
      Ball.update(row.getFloat(XPOS), row.getFloat(YPOS));
      Ball.setZ(row.getFloat(HEIGHT));
      displayData.update(row);
      Ball.draw();
    }
    else {
      Team tempTeam = Teams.get(teamID);
      Player tempPlayer = tempTeam.Players.get(row.getInt(PLAYERID));
      tempPlayer.update(row.getFloat(XPOS), row.getFloat(YPOS));
      tempPlayer.draw();
    }
  }
  if(!hs1.isLocked() && isPlaying) {
    moment++;
    hs1.moveToMoment();
  }
  
  /*if(homeTeam != -1 && visitorTeam != -1){
    Team tempTeam = Teams.get(homeTeam);
    tempTeam.checkSelectedPlayer();
    tempTeam = Teams.get(visitorTeam);
    tempTeam.checkSelectedPlayer();
  }*/
  if(gameid != 0){
    displayData.draw();
  }
  if(homeTeam>0){
    imageMode(CENTER);
    image(smallHomeImg, 90, 468);
    imageMode(CENTER);
    image(smallVisitorImg, 270, 468);
  }
  
  hs1.update();
  hs1.display();
  if(vsScreenCounter > 0){
    fill(255,255,255,215);
    rect(385,0,1600,860);
    
    /*
    imageMode(CENTER);
    image(homeImg, tempXCenter + tempXOffset - 300, tempYCenter + tempYOffset);
    imageMode(CENTER);
    image(visitorImg, tempXCenter + tempXOffset + 300, tempYCenter + tempYOffset);
    */
    if(vsScreenCounter > 26){
      imageMode(CENTER);
      image(homeImg, tempXCenter + tempXOffset - 260 - (vsScreenCounter - 26)*12, tempYCenter + tempYOffset);
      imageMode(CENTER);
      image(visitorImg, tempXCenter + tempXOffset + 260 + (vsScreenCounter - 26)*12, tempYCenter + tempYOffset);
    }
    else if(vsScreenCounter > 13){
      imageMode(CENTER);
      image(homeImg, tempXCenter + tempXOffset - 260, tempYCenter + tempYOffset);
      imageMode(CENTER);
      image(visitorImg, tempXCenter + tempXOffset + 260, tempYCenter + tempYOffset);
    }
    else{
      imageMode(CENTER);
      image(homeImg, tempXCenter + tempXOffset - 260 - 156 + (vsScreenCounter)*12, tempYCenter + tempYOffset);
      imageMode(CENTER);
      image(visitorImg, tempXCenter + tempXOffset + 260 +156- (vsScreenCounter)*12, tempYCenter + tempYOffset);
    }
      
    fill(0);
    textAlign(CENTER,CENTER);
    textFont(vsFont);
    text("VS", tempXCenter + tempXOffset, tempYCenter + tempYOffset);
    
    vsScreenCounter--;
  }
}

void drawCourt(){ // offset
  //scale by 16 per feet w/o scaleFactor
  //fill(255,233,92); //OLD COURT COLOR
  fill(#FFEF85);
  stroke(0,0,0);
  strokeWeight(1);
  ellipseMode(CENTER);
  rect ( scaleFactor*(0 + xOffset), scaleFactor*(0 + yOffset), scaleFactor*(1504), scaleFactor*(800));                 // court
  arc (scaleFactor*(84+xOffset), scaleFactor*(400 + yOffset), scaleFactor*(760), scaleFactor*(760), radians(292), radians(428));   // left 3 point
  arc (scaleFactor*(1504+xOffset - 84), scaleFactor*(400 + yOffset), scaleFactor*(760), scaleFactor*(760), radians(112), radians(248));      // right 3 point
  line (scaleFactor*(0 + xOffset), scaleFactor*(752 + yOffset), scaleFactor*(228 + xOffset)/*48*/, scaleFactor*(752 + yOffset));    // left bottom line
  line (scaleFactor*(0 + xOffset), scaleFactor*(48 + yOffset), scaleFactor*(228 + xOffset)/*48*/, scaleFactor*(48 + yOffset));      // left top line
  line (scaleFactor*(1504 + xOffset), scaleFactor*(752 + yOffset), scaleFactor*(1504 +xOffset/*48*/- 228), scaleFactor*(752 + yOffset));    // right bottom line
  line (scaleFactor*(1504 + xOffset), scaleFactor*(48 + yOffset), scaleFactor*(1504 +xOffset/*48*/- 228), scaleFactor*(48 + yOffset));      // right top line
  fill (12, 129, 200);                  // center circle     
  ellipse (scaleFactor*(752+xOffset), scaleFactor*(400 + yOffset),scaleFactor*(192),scaleFactor*(192));
  if(homeTeam>0){
    image(homeImg, scaleFactor*(752+xOffset), scaleFactor*(400 + yOffset));
  }
  line (scaleFactor*(752+xOffset), scaleFactor*(0 + yOffset), scaleFactor*(752+xOffset/*48*/), scaleFactor*(800 + yOffset));          // center line
  fill (153, 0, 0);                  // Color for outsideKey
  rect (scaleFactor*(0+xOffset), scaleFactor*(272 + yOffset), scaleFactor*(304), scaleFactor*(256));                  // left outside rectangle/key
  rect (scaleFactor*(1504+xOffset-304), scaleFactor*(272 + yOffset), scaleFactor*(304), scaleFactor*(256));                // right outside rectangle/key
  fill (12, 129, 200);                  // Color for Key
  rect (scaleFactor*(0+xOffset), scaleFactor*(304 + yOffset), scaleFactor*(304), scaleFactor*(192));                  // left rectangle/key
  rect (scaleFactor*(1504+xOffset-304), scaleFactor*(304 + yOffset), scaleFactor*(304), scaleFactor*(192));                // right rectangle/key
  fill (0);                        // net color 
  ellipse(scaleFactor*(84+xOffset), scaleFactor*(400 + yOffset), scaleFactor*(24), scaleFactor*(24));    // left net
  ellipse (scaleFactor*(1504+xOffset - 84), scaleFactor*(400 + yOffset), scaleFactor*(24), scaleFactor*(24));      // right net
  //fill (255,233,92);                     // fill half circle color
  fill(#FFEF85);
  arc (scaleFactor*(305+xOffset), scaleFactor*(400 + yOffset), scaleFactor*(192), scaleFactor*(192), -HALF_PI, HALF_PI);    // tipoff free throw area left
  arc (scaleFactor*(1504+xOffset-304), scaleFactor*(400 + yOffset), scaleFactor*(192), scaleFactor*(192), HALF_PI, PI+HALF_PI);      // tipoff  free throw right
}

Hashtable<Integer, Team> Teams = new Hashtable<Integer, Team>();

void loadTeam() {
  int i=0;
  teamTable = loadTable(sketchPath()+"/data/team.csv", "header");
  colorTable = loadTable(sketchPath()+"/color.csv", "header");

  for (TableRow row : teamTable.rows()) {
    TableRow colorRow = colorTable.getRow(i);
    Team tempTeam = new Team(row, colorRow.getString("color1"), colorRow.getString("color2"));
    Teams.put(row.getInt("teamid"), tempTeam);
    //println("team: " + row.getString("abbreviation") + " color1: " + colorRow.getString("color1")+ " color2: " + colorRow.getString("color2"));
    i++;
  }
  
}


void loadPlayers() {
  
  playerTable = loadTable(sketchPath()+"/data/players.csv", "header");

  for (TableRow row : playerTable.rows()) {
    
    Team tempTeam = Teams.get(row.getInt("teamid"));
    color tempDispColor = tempTeam.dispColor;
    color tempStrokeColor = tempTeam.strokeColor;
    
    tempTeam.addPlayer(row, tempDispColor, tempStrokeColor);
    
  }
  
}

void loadGames() {
  gamesTable = loadTable(sketchPath()+"/data/games.csv", "header");
}

void listFilesForFolder(final File folder) {
  gameEvents = new ArrayList<String>();
  final File[] fileNames = folder.listFiles();
  Arrays.sort(fileNames, new Comparator<File>() {
    public int compare(final File s1, final File s2) {
      int n1 = extractNumber(s1.getName());
      int n2 = extractNumber(s2.getName());
      return n1 - n2;
    }
    private int extractNumber(String name) {
      int i = 0;
      try {
        int e = name.lastIndexOf('.');
        String number = name.substring(0,e);
        i = Integer.parseInt(number);
      }
      catch(Exception e){
        i = 0;
      }
      return i;
    }
  });
  
  for (final File fileEntry : fileNames) {
    /*if (fileEntry.isDirectory()) {
      listFilesForFolder(fileEntry);
    } else {*/
      gameEvents.add(fileEntry.getName());
    //}
  }
}

void loadOneGame(int id){  
  //sketchPath("/data/games/0041400101");
  //gameid = 41400101;
  gameid = id;
  TableRow tempRow = gamesTable.findRow(String.valueOf(id), "gameid");
  homeTeam = tempRow.getInt("hometeamid");
  visitorTeam = tempRow.getInt("visitorteamid");
  final File folder = new File(sketchPath("/data/games/00" + gameid + "/"));
  listFilesForFolder(folder);
  eventCount = gameEvents.iterator();
  Team tempHomeTeam = Teams.get(homeTeam);
  Team tempVisitorTeam = Teams.get(visitorTeam);
  homeImg = loadImage(sketchPath()+"/icons/" + tempHomeTeam.abbreviation + ".png");
  smallHomeImg = homeImg.copy();
  smallHomeImg.resize(0,60);
  visitorImg = loadImage(sketchPath()+"/icons/" + tempVisitorTeam.abbreviation + ".png");
  smallVisitorImg = visitorImg.copy();
  smallVisitorImg.resize(0,60);
  vsFont = loadFont(sketchPath()+"/fonts/AgencyFB-Bold-52.vlw");
  vsScreenCounter = 39;
  loadOneEvent();
}

void loadOneEvent() {
  moment = 0;
  /* Test for FreeThrow Right
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();*/
  
  /* Test for FreeThow Left
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();
  eventCount.next();*/
  
  oneEventTable = loadTable(sketchPath()+"/data/games/00" + gameid + "/" + (String)eventCount.next());
  //oneEventTable = loadTable("data/games/0041400101/2.csv");
  for(TableRow row : oneEventTable.rows()){
    int tempTeamID = row.getInt(TEAMID);
    if(tempTeamID<0){
      Ball.ballPreprocess(row.getFloat(XPOS), row.getFloat(YPOS), row.getInt(MOMENT));
      continue;
    }
    Team tempTeam = Teams.get(tempTeamID);
    Player tempPlayer = tempTeam.Players.get(row.getInt(PLAYERID));
    tempPlayer.preprocess(row.getFloat(GAMECLOCK), row.getFloat(XPOS), row.getFloat(YPOS), row.getInt(MOMENT));
  }
  
  TableRow row = oneEventTable.getRow(oneEventTable.getRowCount() - 1);
  maxMoment = row.getInt(MOMENT);
  displayData.isDispPlayer = false;
  isPlaying = true;
}