double cafeWidth = 0;
double cafeHeight = 0;

double referenceRatio = 918.85 / 411.42;
double screenFactor = 0;

void initVars() {
  screenFactor = (cafeHeight / cafeWidth) / referenceRatio;
}
