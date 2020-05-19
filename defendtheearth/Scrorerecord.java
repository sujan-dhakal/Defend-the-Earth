class Scorerecord {

  // Instance Variables

  private String playerName;
  private int playerscore;

  // Constructor

  public Scorerecord (String playerName, int playerscore) {
    this.playerName=playerName;
    this.playerscore=playerscore;
  }

  // Methods

  public String getName() {
    return playerName;
  }

  public int getPlayerscore() {
    return playerscore;
  }

  public void setName(String playerName) {
    this.playerName=playerName;
  }

  public void setPlayerscore(int playerscore) {
    this.playerscore=playerscore;
  }

  public String toString() {
    return playerName + " " + playerscore;
  }
}