public class Team {
  
  int teamid;
  String name;
  String abbreviation;
  Hashtable<Integer, Player> Players;
  color dispColor;
  color strokeColor;
  
  public Team(TableRow row) {
    
    teamid = row.getInt("teamid");
    name = row.getString("name");
    abbreviation = row.getString("abbreviation");
    
    Players = new Hashtable<Integer, Player>();
  }
  
  public Team(TableRow row, String color1, String color2) {
    
    teamid = row.getInt("teamid");
    name = row.getString("name");
    abbreviation = row.getString("abbreviation");
    dispColor = unhex(color1);
    strokeColor = unhex(color2);
    //dispColor = color1;
    //strokeColor = color2;
    
    Players = new Hashtable<Integer, Player>();
  }
  
  public void addPlayer(TableRow row) {
    Player tempPlayer = new Player(row);
    Players.put(row.getInt("playerid"), tempPlayer);
  }
  
  public void addPlayer(TableRow row, color dispColor, color strokeColor) {
    Player tempPlayer = new Player(row, dispColor, strokeColor);
    Players.put(row.getInt("playerid"), tempPlayer);
  }
  
  public int playerCount() {
    return Players.size();
  }
  
}