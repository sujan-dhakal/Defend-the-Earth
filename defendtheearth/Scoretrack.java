import java.io.*;

class Scoretrack {
  String filename="/Users/mac/Desktop/sujandhakal- final project/defendtheearth/score.txt";
  Scorerecord[] scorerecord= new Scorerecord [10];
  int scoresNumber = 0;

  public Scoretrack() {
    String scores;
    File file= new File (filename);

    try {
      FileReader fr= new FileReader (file);
      BufferedReader br= new BufferedReader (fr);
      scores= br.readLine();

      while (scores!=null) {
        String[] s=scores.split(";");
        scorerecord[scoresNumber]= new Scorerecord(s[0], Integer.parseInt(s[1]));
        scoresNumber++;
        System.out.println(scores);
        scores=br.readLine();
      }
      fr.close();
    }

    catch(IOException e) {
      System.out.println("No txt file");
      e.printStackTrace();
      System.exit(1);            // Exits from a Java Program.  By convention,
    }                            // 0 is success and other numbers indicate failures.
    selectionSort();
  }

  public String toString() {
    String result=" ";
    for (int i=0; i<scoresNumber; i++) {
      result= result + scorerecord[i]+ "\n";
    }
    return result;
  }

  public void write() {
    try {
      FileWriter fw= new FileWriter(filename);
      BufferedWriter bw= new BufferedWriter(fw);
      for (int i=0; i<scoresNumber; i++) {
        String result2= scorerecord[i].getName() + ";"+ scorerecord[i].getPlayerscore();
        System.out.println(result2);
        bw.write(result2, 0, result2.length());
        bw.newLine();
      }
      bw.close();
      fw.close();
    }
    catch(IOException e) {
      System.out.println("No txt fine");
      e.printStackTrace();
      System.exit(1);
    }
  }

  public void selectionSort() {            // for sorting high scores in descending order

    for (int i=0; i<scoresNumber; i++) {
      int most=scorerecord[i].getPlayerscore();
      int mostLocation=i;

      for (int j=i+1; j<scoresNumber; j++) {
        if (most<scorerecord[j].getPlayerscore() ) {
          most=scorerecord[j].getPlayerscore();
          mostLocation=j;
        }
      }
      Scorerecord k= scorerecord[mostLocation];
      scorerecord[mostLocation]= scorerecord[i];
      scorerecord[i]=k;
    }
  }

  public void playertrack (String name, int score) {
    if (scoresNumber<scorerecord.length) {
      scorerecord[scoresNumber]= new Scorerecord(name, score);
      scoresNumber++;
    } else if (scorerecord[scorerecord.length-1].getPlayerscore() < score) {
      scorerecord[scorerecord.length-1]= new Scorerecord(name, score);
    }
    selectionSort();
  }

  Scorerecord[] getScore() {
    return scorerecord;
  }
}