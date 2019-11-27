/* tested with functions 2 and 2x. The functions look decent enough.
*/
//################################################################################//
////////////////////////////////Graph Sizing////////////////////////////////////////
//################################################################################//

////////////////////////////////Changeable Variables//////////////////////////////
double resolutionX = 1000; //graphical bug when inputing 1000 in both resolutionX and resolutionY
double resolutionY = 1000;
double drawCenterX = resolutionX/2;
double drawCenterY = resolutionY/2;
int numberOfTicksX = 10; // THESE MUST BE EVEN NUMBERS 
int numberOfTicksY = 10; // IF ODD, THE GRAPH WILL, WILL LOOK WEIRD AND WILL BE INCORRECT!!!

////////////////////////////////NO TOUCHY//////////////////////////////////////////


double tickSizeX = resolutionX/numberOfTicksX;
double tickSizeY = resolutionY/numberOfTicksY;


void DrawTicks() {
  double startPosition;
  
  for(double i = 0; i < resolutionX; i += tickSizeX) {
    line((float)i, (float)(drawCenterY+10), (float)i, (float)(drawCenterY-10));
  }
  for(double i = 0; i < resolutionY; i += tickSizeY) {
    line((float)(drawCenterX+10), (float)i, (float)(drawCenterX-10), (float)i);
  }
}

void DrawAxis() {
  line((float)0, (float)(resolutionY/2), (float)resolutionX, (float)(resolutionY/2));
  line((float)(resolutionX/2), (float)0, (float)(resolutionY/2), (float)resolutionY);
}

double drawTransformX(double graphX) {
  double drawX = 0;
  drawX = graphX*tickSizeX + drawCenterX;
  return drawX;
}
double drawTransformY(double graphY) {
  double drawY = 0;
  drawY = -graphY*tickSizeY + drawCenterY;
  return drawY;
}
//#################################################################################//
///////////////////////////////Euler's Method////////////////////////////////////////
//#################################################################################//
//////////////////////////////////Changeable Variables///////////////////////////////
int steps = 18000; //looks 18000 is the general max 
double initialX = -1;
double initialY = -2;
double stepSize = (double)numberOfTicksX/((double)steps);
double slope;


/////////////////////////////////Changeable Function/////////////////////////////////

void slopeCalculation(double intX, double intY) {
  slope = 2*intX - intY; //PUT YOUR DIFFERENTIAL EQUATION HERE!!!
}

////////////////////////////////NO TOUCHY/////////////////////////////////////////////

double xBoundsUpper;
double xBoundsLower;

void findBounds() {
  xBoundsUpper = numberOfTicksX/2;
  xBoundsLower = -numberOfTicksX/2;
  println(xBoundsUpper + " " + xBoundsLower);
}

double ForwardEulerCalculationY(double intX, double intY) {
  double outputY;
  slopeCalculation(intX, intY);
  outputY = intY + stepSize*slope; 
  return outputY;
}
double BackwardEulerCalculationY(double intX, double intY) {
  double outputY;
  slopeCalculation(intX, intY);
  outputY = intY - stepSize*slope; 
  return outputY;
}


//################################################################################//
////////////////////////////Actual Drawing//////////////////////////////////////////
//################################################################################//

void setup() {
  size(1000, 1000); //BE SURE TO CHANGE THESE TO THE RESOLUTIONS!!!
  DrawTicks();
  DrawAxis();
  findBounds();
  noLoop();
  
  println(stepSize);
}

void draw() {
  double yPos = initialY;
  for (double i = initialX; i < xBoundsUpper; ellipse((float)drawTransformX(i), (float)drawTransformY(yPos), 1, 1)) {
    yPos = ForwardEulerCalculationY(i, yPos);
    i = i + stepSize;
  }
  yPos = initialY;
  for (double i = initialX; i > xBoundsLower; ellipse((float)drawTransformX(i), (float)drawTransformY(yPos), 1, 1)) {
    yPos = BackwardEulerCalculationY(i, yPos);
    i = i - stepSize;
  }
  ellipse((float)drawTransformX(initialX), (float)drawTransformY(initialY), 5, 5);
}
