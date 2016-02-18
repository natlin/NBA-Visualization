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

int maxMoment = -1;
int gameid = 0;

int xOffset =560;
int yOffset = 200;
float scaleFactor = 0.75;

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

PFont f1, f2;

HScrollbar hs1;
ControlP5 cp5;

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
  loadOneGame();
  f1 = createFont("Helvetica", 20);
  f2 = createFont("Helvetica", 12);
  
  cp5 = new ControlP5(this);
  hs1 = new HScrollbar(0, height - 20, width, 30, 10);
  
  List l = Arrays.asList("a", "b", "c", "d", "e", "f", "g", "h");
  cp5.addScrollableList("dropdown")
    .setPosition(1304, 100)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;
  cp5.get(ScrollableList.class, "dropdown").close();
  
  MenuList m = new MenuList( cp5, "menu", 360, 368 );
  
  m.setPosition(10, 10);
  
  for (TableRow row : teamTable.rows()) {
    String subline = row.getString("name");
    String headline = row.getString("abbreviation");
    String copy = row.getString("teamid");
    
    m.addItem(makeItem(headline, subline, copy, loadImage("/icons/" + headline + "2.png")));
  }
  
}


int moment = 0;
int teamRed = -1;
void draw()
{
  background(255, 255, 255);
  drawCourt();
  for(int i = moment * 11; i < (moment + 1) * 11; i++) {
    TableRow row;
    int teamID;
    try{
      row = oneEventTable.getRow(i);
      teamID = row.getInt(TEAMID);
      if(teamRed < 0){
        teamRed = teamID;
      }
    }
    catch(Exception e){
      break;
    }
    if(teamID < 0){
      Ball.update(row.getFloat(XPOS), row.getFloat(YPOS));
      Ball.draw();
    }
    else {
      Team tempTeam = Teams.get(teamID);
      Player tempPlayer = tempTeam.Players.get(row.getInt(PLAYERID));
      tempPlayer.update(row.getFloat(XPOS), row.getFloat(YPOS));
      /*if(teamRed == teamID){
        tempPlayer.changeColor();
      }*/
      tempPlayer.draw();
    }
  }
  if(!hs1.isLocked()) {
    moment++;
    hs1.moveToMoment();
  }
  
  hs1.update();
  hs1.display();
}

void drawCourt(){ // offset
  //scale by 16 per feet w/o scaleFactor
  fill(255,233,92);
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
  fill (255,233,92);                     // fill
  arc (scaleFactor*(305+xOffset), scaleFactor*(400 + yOffset), scaleFactor*(192), scaleFactor*(192), -HALF_PI, HALF_PI);    // tipoff free throw area left
  arc (scaleFactor*(1504+xOffset-304), scaleFactor*(400 + yOffset), scaleFactor*(192), scaleFactor*(192), HALF_PI, PI+HALF_PI);      // tipoff  free throw right
}

Hashtable<Integer, Team> Teams = new Hashtable<Integer, Team>();

void loadTeam() {
  int i=0;
  teamTable = loadTable("data/team.csv", "header");
  colorTable = loadTable("color.csv", "header");

  for (TableRow row : teamTable.rows()) {
    TableRow colorRow = colorTable.getRow(i);
    Team tempTeam = new Team(row, colorRow.getString("color1"), colorRow.getString("color2"));
    Teams.put(row.getInt("teamid"), tempTeam);
    //println("team: " + row.getString("abbreviation") + " color1: " + colorRow.getString("color1")+ " color2: " + colorRow.getString("color2"));
    i++;
  }
  
}


void loadPlayers() {
  
  playerTable = loadTable("data/players.csv", "header");

  for (TableRow row : playerTable.rows()) {
    
    Team tempTeam = Teams.get(row.getInt("teamid"));
    color tempDispColor = tempTeam.dispColor;
    color tempStrokeColor = tempTeam.strokeColor;
    
    tempTeam.addPlayer(row, tempDispColor, tempStrokeColor);
    
  }
  
}

void loadGames() {
  gamesTable = loadTable("data/games.csv", "header");
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

void loadOneGame(){  
  //sketchPath("/data/games/0041400101");
  gameid = 41400101;
  final File folder = new File(sketchPath("/data/games/00" + gameid + "/"));
  listFilesForFolder(folder);
  eventCount = gameEvents.iterator();
  loadOneEvent();
}

void loadOneEvent() {
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
  
  //oneEventTable = loadTable("/data/games/00" + gameid + "/" + (String)eventCount.next());
  oneEventTable = loadTable("data/games/0041400101/2.csv");
  TableRow row = oneEventTable.getRow(oneEventTable.getRowCount() - 1);
  maxMoment = row.getInt(MOMENT);
}