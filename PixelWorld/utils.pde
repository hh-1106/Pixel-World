void setFont() {
  //String[] fontList = PFont.list();
  //printArray(fontList);
  PFont font = createFont("Mouse.otf", 48);
  textFont(font);
  textAlign(LEFT, CENTER);
}

boolean isGlitch = false;
void glitch(float w, float h, color c) {
  if (!isGlitch) return;

  fill(
    hue(c)+random(-30, 30)
    , random(200, 250)
    , brightness(c)
    );

  rect(0, 0, w*2, h*2);
}
