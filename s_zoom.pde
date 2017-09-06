float DT_HEIGHT = sqrt(3) / 2;

float m;
int depth;
PVector[] verts;

void sierp(float tx, float ty, float base, float min) {
  if (ty < height) {
    float n_base = base / 2;

    if (n_base > min) {
      sierp(tx, ty, n_base, min);
      sierp(tx + n_base / 2, ty + DT_HEIGHT * base * 0.5, n_base, min);
      sierp(tx - n_base / 2, ty + DT_HEIGHT * base * 0.5, n_base, min);
    } else {
      triangle(tx, ty, tx + base / 2, ty + DT_HEIGHT * base, 
        tx - base / 2, ty + DT_HEIGHT * base);
    }
  }
}

void get_s_vertices(float tx, float ty, float base, int depth, ArrayList<PVector> vertices) {
  float n_base = base / 2;

  if (depth > 0) {
    get_s_vertices(tx, ty, n_base, depth - 1, vertices);
    get_s_vertices(tx + n_base / 2, ty + DT_HEIGHT * base * 0.5, n_base, depth - 1, vertices);
    get_s_vertices(tx - n_base / 2, ty + DT_HEIGHT * base * 0.5, n_base, depth - 1, vertices);
  } else {
    vertices.add(new PVector(tx, ty, base));
  }
}

PVector[] array_vertices(float tx, float ty, float base, int depth) {
  ArrayList<PVector> v = new ArrayList<PVector>();
  get_s_vertices(tx, ty, base, depth, v);
  return v.toArray(new PVector[0]);
}

void draw_vertices(PVector[] v) {
  for (PVector p : v) {
    if (p.y < height) {
      triangle(p.x, p.y, p.x + p.z / 2, p.y + DT_HEIGHT * p.z, 
        p.x - p.z / 2, p.y + DT_HEIGHT * p.z);
    }
  }
}

float base;
float s;

void setup() {
  size(800, 800);
  base = height / DT_HEIGHT;
  depth = 8;
  //m = base / pow(2, depth);
  verts = array_vertices(0, 0, base, depth);
  s = 1;
}

void draw() {
  background(0);
  fill(255);
  /*sierp(width / 2, 0, base, m);
   base += 5;
   if (base * DT_HEIGHT * 0.5 > height) {
   base /= 2;
   }*/
  s += 0.01;
  if (s > 2) {
    s = 1;
  }
  translate(width / 2, 0);
  scale(s, s);
  draw_vertices(verts);
}
