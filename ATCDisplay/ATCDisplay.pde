/* ATC Display prototype                             */
/* Concept for CSCI 363 @ University of North Dakota */

Airspace KGFK;
void setup() {
  KGFK = new Airspace("KGFK");
  size(750, 750);
  background(0, 0, 20);
}

void draw() {
  KGFK.showAirspace();
}
