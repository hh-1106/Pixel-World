QTreeSystem       QTS;        // 四叉树系统
ParticleSystem     PS;        // 粒子系统
PathSystem       Path;        // 物体边缘检测系统

PImage            img;        


void settings() {
  img = loadImage("back.png");
  size(img.width*2, img.height, P2D);
}

void setup() {

  rectMode(CENTER);
  colorMode(HSB);

  Path = new PathSystem(this, img);
  PS   = new ParticleSystem();
  QTS  = new QTreeSystem();

  PS.init(Path.getPath());

  frameRate(60);
  setFont();
}


void draw() {

  // 细分粒度
  int cap = floor(map(pow(mouseX, 0.1), 0, pow(width, 0.1), 10000, 0.9));
  // 重构四叉树
  QTS.refactor(cap);

  // 寻找画面物体边缘
  Path.findMax(this);
  // 插入到四叉树
  PS.update();

  // 渲染
  background(0);
  image(img, 0, 0);
  Path.show();
  translate(width*0.5, 0);
  QTS.show();

  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}

// 开启/关闭 glitch 效果
void mousePressed() {
  isGlitch = !isGlitch;
}
