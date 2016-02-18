import controlP5.*;

import java.util.Hashtable;
//import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Comparator;
import java.util.Iterator;
import java.io.File;

Table teamTable;
Table playerTable;
Table gamesTable;
Table oneEventTable;
Iterator eventCount;
ArrayList<String> gameEvents;

int maxMoment = -1;
int gameid = 0;

int xOffset = 48;
int yOffset = 120;

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

HScrollbar hs1;
ControlP5 cp5;

void setup()
{
  frameRate(50);
  size(1600, 1000);
  background(255, 255, 255);
  Ball = new Player();
  drawCourt2();
  loadTeam();
  loadPlayers();
  loadGames();
  loadOneGame();
  cp5 = new ControlP5(this);
  hs1 = new HScrollbar(0, height - 20, width, 30, 10);
  
  List l = Arrays.asList("a", "b", "c", "d", "e", "f", "g", "h");
  cp5.addScrollableList("dropdown")
    .setPosition(100, 100)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(l)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;
  cp5.get(ScrollableList.class, "dropdown").close();
}


int moment = 0;
int teamRed = -1;
void draw()
{
  
  background(255, 255, 255);
  //drawCourt();
  drawCourt2();
  int newMoment=0;
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
      if(teamRed == teamID){
        tempPlayer.changeColor();
      }
      tempPlayer.draw();
    }
    //newMoment = row.getInt(MOMENT);
  }
  if(!hs1.isLocked()) {
    moment++;
    //moment = newMoment;
    hs1.moveToMoment();
  }
  //println(moment);
  
  hs1.update();
  hs1.display();
}

/*void drawCourt3(){
  //scale by 16 per feet
  fill(255,233,92);
  stroke(0,0,0);
  strokeWeight(1);
  ellipseMode(CENTER);
  rect (0, 0, 1504, 800);                 // court
  arc (84, 400, 760, 760, radians(292), radians(428));   // left 3 point
  arc (1504 - 84, 400, 760, 760, radians(112), radians(248));      // right 3 point
  line (0, 752, 228, 752);    // left bottom line
  line (0, 48, 228, 48);      // left top line
  line (1504, 752, 1504 - 228, 752);    // right bottom line
  line (1504, 48, 1504 - 228, 48);      // right top line
  fill (12, 129, 200);                  // center circle     
  ellipse (752, 400,192,192);
  line (752, 0, 752, 800);          // center line
  fill (153, 0, 0);                  // Color for outsideKey
  rect (0, 272, 304, 256);                  // left outside rectangle/key
  rect (1504-304, 272, 304, 256);                // right outside rectangle/key
  fill (12, 129, 200);                  // Color for Key
  rect (0, 304, 304, 192);                  // left rectangle/key
  rect (1504-304, 304, 304, 192);                // right rectangle/key
  fill (0);                        // net color 
  ellipse(84, 400, 30, 30);    // left net
  ellipse (1504 - 84, 400, 30, 30);      // right net
  fill (255,233,92);                     // fill
  arc (304, 400, 192, 192, radians(270), radians(450));    // tipoff free throw area left
  arc (1504-304, 400, 192, 192, HALF_PI, PI+HALF_PI);      // tipoff  free throw right
}*/

void drawCourt2(){ // offset
  //scale by 16 per feet
  fill(255,233,92);
  stroke(0,0,0);
  strokeWeight(1);
  ellipseMode(CENTER);
  rect (0 + xOffset, 0 + yOffset, 1504, 800);                 // court
  arc (84+xOffset, 400 + yOffset, 760, 760, radians(292), radians(428));   // left 3 point
  arc (1504+xOffset - 84, 400 + yOffset, 760, 760, radians(112), radians(248));      // right 3 point
  line (0 + xOffset, 752 + yOffset, 228 + 48, 752 + yOffset);    // left bottom line
  line (0 + xOffset, 48 + yOffset, 228 + 48, 48 + yOffset);      // left top line
  line (1504 + xOffset, 752 + yOffset, 1504 +48- 228, 752 + yOffset);    // right bottom line
  line (1504 + xOffset, 48 + yOffset, 1504 +48- 228, 48 + yOffset);      // right top line
  fill (12, 129, 200);                  // center circle     
  ellipse (752+xOffset, 400 + yOffset,192,192);
  line (752+xOffset, 0 + yOffset, 752+48, 800 + yOffset);          // center line
  fill (153, 0, 0);                  // Color for outsideKey
  rect (0+xOffset, 272 + yOffset, 304, 256);                  // left outside rectangle/key
  rect (1504+xOffset-304, 272 + yOffset, 304, 256);                // right outside rectangle/key
  fill (12, 129, 200);                  // Color for Key
  rect (0+xOffset, 304 + yOffset, 304, 192);                  // left rectangle/key
  rect (1504+xOffset-304, 304 + yOffset, 304, 192);                // right rectangle/key
  fill (0);                        // net color 
  ellipse(84+xOffset, 400 + yOffset, 30, 30);    // left net
  ellipse (1504+xOffset - 84, 400 + yOffset, 30, 30);      // right net
  fill (255,233,92);                     // fill
  arc (305+xOffset, 400 + yOffset, 192, 192, -HALF_PI, HALF_PI);    // tipoff free throw area left
  arc (1504+xOffset-304, 400 + yOffset, 192, 192, HALF_PI, PI+HALF_PI);      // tipoff  free throw right
}

/*void drawCourt(){
  
  fill(255,255,255);
  stroke(0,0,0);
  strokeWeight(1);
  ellipseMode(CENTER);
  
  rect (50, 150, 400, 225);                 // court
  arc (435, 263, 190, 190, HALF_PI, PI+HALF_PI);      // right 3 point
  arc (65, 263, 190, 190, radians(270), radians(450));   // left 3 point
  fill (12, 129, 200);                  // center circle
  ellipse (246, 256, 50, 50);            
  line (246, 150, 246, 375);
  fill (12, 129, 200);                  // half-court
  rect (50, 238, 75, 50);                  // left rectangle/key
  rect (375, 238, 75, 50);                // right rectangle/key
  fill (0);                        // net  
  //ellipse (57, 263, 10, 10);                // left net
  //ellipse (443, 263, 10, 10);                // right net
  ellipse (70, 263, 10, 10);                // left net
  ellipse (430, 263, 10, 10);                // right net
  rect (52, 135, 10, 10);                  // left player1
  rect (65, 135, 10, 10);                  // left player2
  rect (78, 135, 10, 10);                  // left player3
  rect (91, 135, 10, 10);                  // left player4
  rect (104, 135, 10, 10);                // left player5
  rect (214, 126, 65, 20);                // subbing area
  rect (438, 135, 10, 10);                // right player1
  rect (425, 135, 10, 10);                // right player2
  rect (412, 135, 10, 10);                // right player3
  rect (399, 135, 10, 10);                // right player4
  rect (386, 135, 10, 10);                // right player5
  fill (255);                        // white fill
  arc (375, 263, 50, 50, HALF_PI, PI+HALF_PI);      // tipoff  free throw right
  arc (125, 263, 50, 50, radians(270), radians(450));    // tipoff free throw area left
  
}*/

Hashtable<Integer, Team> Teams = new Hashtable<Integer, Team>();

void loadTeam() {
  
  teamTable = loadTable("data/team.csv", "header");

  //println(teamTable.getRowCount() + " total rows in table"); 

  for (TableRow row : teamTable.rows()) {
    
    Team tempTeam = new Team(row);
    Teams.put(row.getInt("teamid"), tempTeam);
    
  }
  //println(Teams.size());
  
}


void loadPlayers() {
  //println("Bucks Player count: " + Teams.get(1610612749).playerCount());
  
  playerTable = loadTable("data/players.csv", "header");

  //println(playerTable.getRowCount() + " total rows in table"); 

  for (TableRow row : playerTable.rows()) {
    
    Team tempTeam = Teams.get(row.getInt("teamid"));
    tempTeam.addPlayer(row);
    
  }
  
  //println("Bucks Player count: " + Teams.get(1610612749).playerCount());
  
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
  //println(moment);
  //println(maxMoment);
}