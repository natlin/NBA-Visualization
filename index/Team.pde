public class Team {
  
  int teamid;
  String name;
  String abbreviation;
  Hashtable<Integer, Player> Players;
  
  public Team(TableRow row) {
    
    teamid = row.getInt("teamid");
    name = row.getString("name");
    abbreviation = row.getString("abbreviation");
    
    Players = new Hashtable<Integer, Player>();
  }
  
  public void addPlayer(TableRow row) {
    Player tempPlayer = new Player(row);
    Players.put(row.getInt("playerid"), tempPlayer);
  }
  
  public int playerCount() {
    return Players.size();
  }
  
}