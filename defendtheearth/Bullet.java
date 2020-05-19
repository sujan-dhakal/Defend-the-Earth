import processing.core.PApplet;                  
import processing.core.PImage;

class Bullet {      

  // Instant variables

  private PApplet p;                       
  private Ship ship;
  private PImage bullet;
  private float bulletx;
  private float bullety;
  private float bulletwidth;
  private float bulletheight;
  private float speed;
  private boolean exploded;

  // Constructor

  Bullet (PApplet p, Ship ship, PImage bullet, float bulletx, float bullety, float bulletwidth, float bulletheight, float speed) {
    this.ship=ship;
    this.bullet=bullet;
    this.bulletx=bulletx;
    this.bullety=bullety;
    this.bulletwidth=bulletwidth;
    this.bulletheight=bulletheight;
    this.speed=speed;
    exploded = false;
    this.p=p;
  }

  // Methods

  public void display() {                                  // Displaying bullet
    if (!exploded) {
      p.imageMode(p.CENTER);
      bulletx=p.constrain(bulletx, 0, p.height);
      p.image(bullet, bulletx, bullety, bulletwidth, bulletheight);
    }
  }

  public void move() {                                    // Moving bullet
    bullety=bullety-speed;
  }

  public float getBulletx() {
    return bulletx;
  }

  public float getBullety() {
    return bullety;
  }

  public boolean getExploded() {
    return exploded;
  }

  public void setExploded(boolean b) {
    exploded = b;
  }
}