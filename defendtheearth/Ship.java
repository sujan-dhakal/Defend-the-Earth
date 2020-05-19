import processing.core.PApplet;
import processing.core.PImage;

class Ship {

  // Instance Variables

  private PApplet p;
  private PImage gameShip;
  private float shipx;
  private float shipy;
  private float shipwidth;
  private float shipheight;

  // Constructor

  Ship (PApplet p, PImage gameShip, float shipx, float shipy, float shipwidth, float shipheight) {
    this.gameShip=gameShip;
    this.shipx=shipx;
    this.shipy=shipy;
    this.shipwidth=shipwidth;
    this.shipheight=shipheight;
    this.p=p;
  }

  // Methods

  public void display() {                                              // Displaying ship
    shipx=p.constrain(shipx, p.width/10, p.width-(p.width/10));
    p.image(gameShip, shipx, shipy, shipwidth, shipheight);
  }

  public void update() {                                                // moving ship
    if (p.keyPressed) {
      if (p.key==p.CODED) {
        if (p.keyCode==p.RIGHT) {
          shipx=shipx+4;
        } else if (p.keyCode==p.LEFT) {
          shipx=shipx-4;
        }
      }
    }
  }

  public float getShipx() {
    return shipx;
  }
}