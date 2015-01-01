// Copyright (C) 2015, David Hovemeyer <david.hovemeyer@gmail.com>

// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

int WIDTH=600;
int HEIGHT=600;
int MIN=320;
int X = 5;
int LINEWIDTH = 16;
float COLOR_PCT = 33.0;

color RED = color(212, 41, 23);
color YELLOW = color(245, 202, 97);
color BLUE = color(26, 25, 153);

int saveCount = 1;

void setup() {
  size(WIDTH, HEIGHT);
  generate();
}

void generate() {
  background(233);
  doit(0, 0, WIDTH, HEIGHT, 0);
}

void doit(int left, int top, int right, int bottom, int dir) {
  if (dir == 0) {
    // vertical split
    // +-------+-------+
    // |       |       |
    // |       |       |
    // |       |       |
    // +-------+-------+
    int remain = right-left;
    if (remain >= MIN) {
      int split = left + makeSplit(remain);
      doit(left, top, split, bottom, 1);
      doit(split, top, right, bottom, 1);
      stroke(0);
      strokeWeight(LINEWIDTH);
      line(split, top, split, bottom);
    } else {
      noStroke();
      paintRect(left, top, right, bottom);
    }
  } else {
    // horizontal split
    // +---------------+
    // |               |
    // +---------------+
    // |               |
    // +---------------+
    int remain = bottom-top;
    if (remain >= MIN) {
      int split = top + makeSplit(remain);
      doit(left, top, right, split, 0);
      doit(left, split, right, bottom, 0);
      stroke(0);
      strokeWeight(LINEWIDTH);
      line(left, split, right, split);
    } else {
      noStroke();
      paintRect(left, top, right, bottom);
    }
  }
}

int makeSplit(int n) {
  float x = float(n)/X;
  return int(random(x, (X-1)*x));
}

void paintRect(int left, int top, int right, int bottom) {
  float toss = random(0, 100);
  //println("toss was " + toss);
  if (toss >= COLOR_PCT) {
    return;
  }
  int flip = int(random(0,3));
  //println("flip was " + flip);
  if (flip == 0) {
    fill(RED);
  } else if (flip == 1) {
    fill(YELLOW);
  } else if (flip == 2) {
    fill(BLUE);
  }
  rect(left, top, right-left, bottom-top);
}

void draw() {
}

void mousePressed() {
  //println("Mouse pressed");
  generate();
}

/*
void keyPressed() {
  println("Key pressed");
  String filename = "/home/dhovemey/Pictures/mondrian" + saveCount + ".png";
  println("Saving as " + filename);
  save(filename);
  saveCount++;
}
*/
