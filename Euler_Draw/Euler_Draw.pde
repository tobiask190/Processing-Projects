//SET THESE VARIABLES TO DESIRED SPECIFICATIONS
double resolutionX = 1000;
double resolutionY = 1000;
double stretch = 1;
double originX;
double originY;
int stepNumber = 10000; //The more steps, the more accurate the predictions will be
double temp0 = resolutionX;
double stepSize = temp0/stepNumber;

double Slope(double inputX, double inputY) {
  //inputX = 2;
  //inputY = 2; // debugging
  
  return inputX*1.1; // put the differential equations here
}

//Don't mess with theses for goodness sake
double TransformXCoordinates (double input){
  return (input - originX) * stretch;  
}
double TransformYCoordinates (double input){  //These two convert the values into something easier to work with
  return (-input + originY) * stretch;
}
double ReverseTransformX(double input) {
  return (input + originX) / stretch;
}
double ReverseTransformY(double input) {
  return (-input + originY) / stretch;
}
double SlopeAtPoint(double inputX, double inputY) {
  double outputY;
  double slope;
  inputY = TransformYCoordinates(inputY);
  inputX = TransformXCoordinates(inputX);
  slope = Slope(inputX,inputY); //INPUT YOUR EQUATION HERE!!!
  return slope;
} //put your function here. DON'T FORGET TO USE THE TRANSFORM FUNCTIONS!!! 

void DrawAxisis(float inputOriginX, float inputOriginY) {
  line(0,(float)inputOriginY,(float)resolutionX,(float)inputOriginY);
  line((float)inputOriginX, 0, (float)inputOriginX, (float)resolutionY);
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
  
  DrawAxisis(((float)originX), ((float)originY));
  
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
