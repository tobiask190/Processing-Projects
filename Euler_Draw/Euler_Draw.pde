//SET THESE VARIABLES TO DESIRED SPECIFICATIONS
int resolutionX = 1000;
int resolutionY = 1000;
int originX;
int originY;
int stepNumber = 40; //The more steps, the more accurate the predictions will be
double temp0 = resolutionX;
double stepSize = temp0/stepNumber;

double Slope(double inputX, double inputY) {
  inputX = 2;
  inputY = 2; // debugging
  
  return (inputX/inputY); // put the differential equations here
}

//Don't mess with theses for goodness sake
double TransformXCoordinates (double input){
  return (input - originX);  
}
double TransformYCoordinates (double input){  //These two convert the values into something easier to work with
  return (-input + originY);
}
double ReverseTransformX(double input) {
  return (input + originX);
}
double ReverseTransformY(double input) {
  return (-input + originY);
}
double SlopeAtPoint(double inputX, double inputY) {
  double outputY;
  double slope;
  inputY = TransformYCoordinates(inputY);
  inputX = TransformXCoordinates(inputX);
  slope = Slope(inputX,inputY); //INPUT YOUR EQUATION HERE!!!
  return slope;
} //put your function here. DON'T FORGET TO USE THE TRANSFORM FUNCTIONS!!! 

void DrawAxisis(int inputOriginX, int inputOriginY) {
  line(0,inputOriginY,resolutionX,inputOriginY);
  line(inputOriginX, 0, inputOriginX, resolutionY);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup(){
  size(1000, 1000); //BE SURE TO CHANGE THIS TO THE RESOLUTION SPECIFICATIONS ABOVE!!!
  noLoop();
  originX = resolutionX/2; //Purposely integer division 
  originY = resolutionX/2; //(origin_x, origin_y) should be center of the screen
}

void draw(){
  double currentX = originX; 
  double currentY = originY;
  double convertedX;
  double convertedY;
  float drawX;
  float drawY;
  
  DrawAxisis(originX, originY);
  
  while (currentX < resolutionX) {
    convertedY = TransformYCoordinates(currentY);
    convertedX = TransformXCoordinates(currentX);
    
    convertedY = convertedY + stepSize*SlopeAtPoint(convertedY, convertedX);
    currentY = ReverseTransformY(convertedY);
    
    drawX = (float)currentX;
    drawY = (float)currentY;
    
    ellipse(drawX, drawY, 1.0, 1.0);
    
    currentX = currentX + stepSize;
  }
  
  while (currentX > 0) {
    convertedY = TransformYCoordinates(currentY);
    convertedX = TransformXCoordinates(currentX);
    
    convertedY = convertedY - stepSize*SlopeAtPoint(convertedY, convertedX);
    currentY = ReverseTransformY(convertedY);
    
    drawX = (float)currentX;
    drawY = (float)currentY;
    
    ellipse(drawX, drawY, 1.0, 1.0);
    
    currentX = currentX - stepSize;
  }
}
