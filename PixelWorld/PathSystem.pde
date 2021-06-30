import gab.opencv.*;


class PathSystem {
  PImage src;
  OpenCV opencv;

  ArrayList<Contour> contours;
  ArrayList<PVector> points;


  PathSystem(PApplet thePApplet, PImage img) {
    src = img;
    opencv = new OpenCV(thePApplet, src);

    init(0);
  }

  public ArrayList<PVector> getPath() {
    return this.points;
  }


  private void init(int T) {
    opencv.gray();
    opencv.threshold(T);

    contours = opencv.findContours();
    //println("found " + contours.size() + " contours");
    points = new ArrayList();

    for (Contour contour : contours) {
      for (PVector p : contour.getPolygonApproximation().getPoints()) {
        points.add(p);
      }
    }
  }

  int T = 0;
  int max = 0;
  int lastT = 0;
  private void findMax(PApplet thePApplet) {
    if (keyPressed) {
      if (keyCode == UP  ) T++;
      if (keyCode == DOWN) T--;

      T = constrain(T, -1, 255);
    }

    if (lastT == T)  return;
    lastT = T;
    opencv = new OpenCV(thePApplet, src);
    init(T);
    contours = opencv.findContours();
    PS.init(Path.getPath());
  }


  void show() {
    textSize(32);
    fill(225, 200);
    text("T: " + T, 20, 30);
    text("N: " + contours.size(), 20, 70);

    noFill();
    strokeWeight(1);
    for (Contour contour : contours) {
      stroke(90, 255, 255, 100);
      contour.draw();

      //stroke(255, 0, 0);
      //beginShape();
      //for (PVector point : contour.getPolygonApproximation().getPoints()) {
      //  vertex(point.x, point.y);
      //}
      //endShape();
    }

    //stroke(0);
    //for (PVector v : points) {
    //  point(v.x, v.y);
    //}
  }
}
