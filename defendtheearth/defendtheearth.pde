/*
 * Sujan Dhakal
 * Final Project
 * CS104- Introduction to Game Programming
 * Professor Joann Ordille
 * December 10, 2017
 */


import ddf.minim.*;                          // Library import for sound
import javax.swing.JOptionPane;
import java.lang.*;

Ship ship;                                   // Defining ship object
Bullet[] bullet;                             // Defining bullet object
Meteorites[] met;                            // Defining met object
Scoretrack scoretrack;                       // Defining scoretrack object
Scorerecord scorerecord;                     // Defining scorerecord object

PImage space;                                // Space Image
PImage gamShip;                              // Ship Image
PImage gbullet;                              // Bullet Image
PImage gm;                                   // Meteorite Image
PImage gmb;                                  // Bullet Meteorite Explosion image
PImage gms;                                  // Earth Explosion Image

int numBullet=0;                             
int playerScore=0;                           // Initial player score
int metSpeed=2;                              // Initial Meteorites speed
int mcounter;                                

boolean gameBegin=false;                     // boolean for game begin
boolean gameOver=false;                      // boolean for game over
boolean gameWon=false;                       // boolean for game won
boolean showHighscores= false;               // boolean for showing high scores
boolean highscoresRecorded=true;             // boolean for recording high scores

String playerNames;                          // player name
String[] highScores;                         // highscore of a player

AudioSnippet bulletSound;                    // sound  for bullet
Minim minim;
AudioSnippet blastSound;                     // sound for meteotite and bullet explosion
Minim blast;


void setup() {                                // setup function
  size(500, 500);                            // windows size

  space=loadImage("space.png");              // loading space image

  gamShip=loadImage("gship.png");            // loading ship image
  ship = new Ship(this, gamShip, (4*width)/5, (4*height)/5, width/5, height/5);                  // passing values for ship to the class

  gbullet=loadImage("gbullet.png");          // loading bullet image
  bullet= new Bullet[100];                   // array for bullet


  gm=loadImage("m.png");                      // loading meteorite image
  met = new Meteorites [1000];                // array for meteorites

  gmb=loadImage("mb.png");                    // loading meteorites and bullet explosion image

  minim= new Minim(this);                       
  bulletSound=minim.loadSnippet("b.mp3");       // loading sound for bullet

  blast= new Minim(this);
  blastSound=blast.loadSnippet("m.mp3");         // loading sound for meteorite and bullet explosion

  gms=loadImage("ms.png");                       // loading earth explosion image

  scoretrack= new Scoretrack();                  
  scoretrack.write();                             // writing data from scoretrack

  playerNames=JOptionPane.showInputDialog("Enter Player's Name");        // Dailog box to input player name
}

void draw() {                                // draw function
  if (!gameBegin) {                          // to display instructions before the game
    imageMode(CENTER);
    image(space, width/2, height/2, width, height);
    image(gamShip, (4*width)/5, (4*height)/5, width/5, height/5);
    textSize(15);
    textAlign(CENTER);
    fill(0, 255, 0);
    text("Welcome to the DEFEND THE EARTH GAME.", width/2, height/10+20);
    text("Your task is to destroy Meteorites coming down to the earth.", width/2, height/10+40);
    text("If a meteorite passes you and goes down to the earth,", width/2, height/10+60);
    text("the earth will blow up, and you will die. So protect your earth.", width/2, height/10+80);
    textSize(20);
    fill(255, 0, 0);
    text("To play, move left and right arrow.", width/2, height/10+110);
    text ("To fire bullets, press Space.", width/2, height/10+140);
    fill(125, 0, 125);
    textSize(25);
    text("If you want to play, press 'c/C'", width/2, height/10+180);
    text("For exiting the game, press 'e/E'", width/2, height/10+220);
    noFill();
  }

  if (keyPressed) {                        // Player Command to start the game
    if (key=='c' || key=='C') {            // Continue game
      gameBegin=true;
    } else if (key=='e' || key=='E') {       // Exit game
      exit();
    }
  }

  if (gameBegin) {                                    // game begins
    imageMode(CENTER);                            
    image(space, width/2, height/2, width, height);    // space image

    ship.display();
    ship.update();

    ScoreofPlayer();

    if (keyPressed && key == ' ') {                        // firing bullets, press space to fire bullets
      Bullet counter = new Bullet (this, ship, gbullet, ship.getShipx(), (height-(height/50))-(height/ 5.5), 20, 20, 10);
      bulletSound.rewind();                                // rewinding bullet sound
      bulletSound.play();                                  // playing bullet sound
      bullet[numBullet]=counter;                           // bullet counter
      numBullet++;
      keyPressed=false;      

      if (numBullet==99) {                                 // looping number of bullets so that number of bullets never expires
        numBullet=0;
      }
    }

    if (int (random(0, 50))==0) {                            // randoming the fall of meteorites
      met[mcounter]= new Meteorites (this, gm, random(70, width-70), -20, width/10, width/10, metSpeed);
      mcounter++;
      if (playerScore>500) {                                  // increasing the falling speed of meteorites as the score goes on increasing 
        metSpeed=7;
      } else if (playerScore>200) {
        metSpeed=6;
      } else if (playerScore>100) {
        metSpeed=5;
      } else if (playerScore>50) {
        metSpeed=4;
      } else if (playerScore>20) {
        metSpeed=3;
      }
    }

    for (int i=0; i<numBullet; i++) {                            // calling bullet methods
      if (bullet[i]!=null) {
        bullet[i].display();

        bullet[i].move();
      }
    }

    for (int i=0; i<met.length; i++) {                          // calling meteorites methods
      if (met[i]!=null) {                                      
        met[i].display();
        met[i].move();
      }
    }

    for (int i=0; i<numBullet; i++) {                              // condition for collision
      for (int j=0; j<met.length; j++) {
        if (bullet[i]!=null && met[j]!=null) {                        
          if (bullet[i].getExploded() == false && met[j].getExploded() == false) {
            if (bullet[i].getBulletx()>(met[j].getMx()-25) && bullet[i].getBulletx()<(met[j].getMx()+25) && bullet[i].getBullety()<(met[j].getMy()+25) && bullet[i].getBullety()>(met[j].getMy()-25)) {
              met[j].setExploded(true);                                   // meteorite explosion true
              bullet[i].setExploded(true);                                // bullet explosion 
              image(gmb, met[j].getMx(), met[j].getMy(), 90, 90);          // explosion image
              blastSound.rewind();                                        // rewinding blast sound
              blastSound.play();                                          // playing blast sound
              playerScore++;                                              // increasing player's scores when a bullet hits meteorite
              met[j]=null;                                                // deleting hit meteorite
              bullet[i]=null;                                             // deleting hit bullet
            }
          }
        }
      }
    }

    for (int i=0; i<met.length; i++) {                                 // Game Over condition, if a meteorite passes down to the earth
      if (met[i]!=null) {
        if (met[i].getMy()>height) {
          textAlign(CENTER, CENTER);
          textSize(50);
          image(space, width/2, height/2, width, height);
          image(gms, width/2, 4*height/5, width, height);
          text("Game Over", width/2, 1.7*height/5); 
          gameOver=true;
        }
      }
    }

    if (gameOver) {                                                  
      textAlign(CENTER);
      textSize (20);
      fill(0, 255, 125);
      text("Do you want to play again?", width/2, height/10);
      text ("Press Y for yes and N for No.", width/2, 60+height/10);
      text ("Press H for viewing highscores.", width/2, 100+height/10);
      if (keyPressed) {
        if (key=='Y' || key == 'y') {                                     // Yes to Restart game
          scoretrack.playertrack(playerNames, playerScore);               // passing player's name and scores to the Scoretrack class
          scoretrack.write();                                             
          playerScore=0;                                                  // making score zero again for new game
          showHighscores=false;                                           
          gameOver=false;
          gameWon=false;
          gameBegin=true;
          setup();                                                        // calling setup
        } else if (key=='N' || key=='n') {                                // No to Exit the game    
          scoretrack.playertrack(playerNames, playerScore);               //passing player's name and scores to the Scoretrack class
          scoretrack.write();                                            
          exit();                                                         // game exit
        } else if (key == 'H' || key=='h') {                              // H to view highscores
          if (highscoresRecorded==true) {                                 
            scoretrack.playertrack(playerNames, playerScore);               
            scoretrack.write();
            highscoresRecorded=false;
            showHighscores=true;
          }
        }
      }
    }

    if (playerScore==1000) {                                                // condition for winning game                                 
      gameWon=true;
    }

    if (gameWon) {                                            
      image(space, width/2, height/2, width, height);
      image (gamShip, (4*width)/5, (4*height)/5, width/5, height/5);
      textSize (20);
      fill(255, 0, 255);
      text("CONGRATULATIONS.", width/2, height/10);
      text("YOU WON. YOU SAVED THE EARTH.", width/2, 60+height/10);
      text ("Press R for replay and E to Exit.", width/2, 90+height/10);
      text ("Press H for viewing highscores.", width/2, 140+height/10);
      if (keyPressed) {
        if (key=='R' || key == 'r') {                                        // R to replay game
          scoretrack.playertrack(playerNames, playerScore);
          scoretrack.write();
          playerScore=0;
          showHighscores=false;
          gameOver=false;
          gameWon=false;
          gameBegin=true;
          setup();                                                            // calling setup
        } else if (key=='E' || key=='e') {                                    // E to exit game
          scoretrack.playertrack(playerNames, playerScore);
          scoretrack.write();
          exit();
        } else if (key == 'H' || key=='h') {                                  // H to view highscores
          if (highscoresRecorded==true) {
            scoretrack.playertrack(playerNames, playerScore);
            scoretrack.write();
            highscoresRecorded=false;
          }
          showHighscores=true;
        }
      }
    }

    if (showHighscores==true) {                                              // High scores showing
      highscoresRecorded=false;
      image(space, width/2, height/2, width, height);
      highScores=loadStrings("score.txt");
      for (int i=0; i<highScores.length; i++) {
        fill(255, 0, 0);
        textSize(15);
        textAlign(CENTER, CENTER);
        text(highScores[i], width/2, 30*(i+2));
        if (gameOver) {
          text ("Press Y for to play and N to Exit.", width/2, height-100);          // Condition to play or exit game
          if (keyPressed) {
            if (key=='Y' || key == 'y') {                                               // Yes to Replay game (after gameover)
              showHighscores=false;
              playerScore=0;
              gameOver=false;
              gameWon=false;
              gameBegin=true;
              highscoresRecorded=true;
              setup();
            } else if (key=='N' || key=='n') {                                           // No to Exit the game    (after gameover)
              exit();
            }
          }
        }
        if (gameWon) {
          text ("Press R for replay and E to Exit.", width/2, height-100);              // R to replay game (after gameWon)
          if (keyPressed) {
            if (key=='R' || key == 'r') {  
              showHighscores=false;
              playerScore=0;
              gameOver=false;
              gameWon=false;
              gameBegin=true;
              highscoresRecorded=true;
              setup();
            } else if (key=='E' || key=='e') {                                           // E to exit game (after gameWon)
              exit();
            }
          }
        }
      }
    }
  }
}

void ScoreofPlayer() {                                                                 // function to display player's current score
  fill(255, 0, 0);
  textSize(15);
  text ("Score:", 390, 50);
  text (playerScore, 450, 50);
}