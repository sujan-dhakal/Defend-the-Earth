import processing.core.PApplet;
import processing.core.PImage;

class Meteorites {

  // Instance Variables

  private PApplet p;
  private PImage m;
  public float mx;
  public float my;
  private float mwidth;
  private float mheight;
  private float speed;
  private boolean exploded;

  // Constructor

  Meteorites (PApplet p, PImage m, float mx, float my, float mwidth, float mheight, float speed) {
    this.m=m;
    this.mx=mx;
    this.my=my;
    this.mwidth=mwidth;
    this.mheight=mheight;
    this.speed=speed;
    exploded = false;
    this.p=p;
  }

  // Methods

  public void display() {                              // Displaying meteorites
    if (!exploded) {
      p.imageMode(p.CENTER);
      p.image(m, mx, my, mwidth, mheight);
    }
  }

  public void move() {                                // Moving meteorites
    my=my+speed;
  }

  public float getMx() {
    return mx;
  }

  public float getMy() {
    return my;
  }

  public boolean getExploded() {
    return exploded;
  }

  public void setExploded(boolean b) {
    exploded = b;
  }
}