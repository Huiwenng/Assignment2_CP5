import controlP5.*;

float x;
float y;
float easing = 0.005;
int dragX ,dragY;
int cx1=45;
int cy1=45;
int x1=770;
int rectColor;
boolean text1=false;
PImage mouseCursor;

ControlP5 cp5;
ColorPicker cp;

ControlP5 cp5Button;

ControlP5 cp5Bar;
int colorMin =100;
int colorMax =100;

Range range;

ControlP5 cp5Checkbox;
CheckBox checkbox;

ControlP5 cp5Knob;
int ColorValue=50;

Knob myKnob;


void setup() {
  size(800, 420); 
  smooth(); 
  strokeWeight(1); 
  
  mouseCursor=loadImage("smilememe.png");
  
  cp5= new ControlP5(this);
  cp = cp5.addColorPicker("picker")
          .setPosition(500, 370)
          .setColorValue(color(255, 80, 71))
          ;
          
  cp5Button= new ControlP5(this);
  
   cp5Button.addButton("Plus")
     .setPosition(40,130)
     .setSize(40,40)
     ;
     
   cp5.addButton("Minus")
     .setPosition(90,130)
     .setSize(40,40)
     ;
  
   cp5Bar= new ControlP5(this);
   range= cp5.addRange("rangeController")
          // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(200,30)
             .setSize(400,30)
             .setHandleSize(20)
             .setRange(0,255)
             .setRangeValues(50,100)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setColorForeground(color(255,40))
             .setColorBackground(color(255,40))  
             ;
  
  cp5Checkbox= new ControlP5(this);
  checkbox= cp5.addCheckBox("checkBox")
                .setPosition(40, 370)
                .setSize(30, 30)
                .setItemsPerRow(4)
                .setSpacingColumn(20)
                .addItem("0", 0)
                .addItem("70", 70)
                .addItem("140", 50)
                .addItem("210", 210)
      
                ;
                
  cp5Knob = new ControlP5(this);
  myKnob = cp5.addKnob("ColorValue")
               .setRange(0,255)
               .setValue(50)
               .setPosition(710,15)
               .setRadius(30)
              
               .setTickMarkLength(4)
               .snapToTickMarks(true)
               .setColorForeground(color(255))
               .setColorBackground(color(248, 75, 61))
               .setColorActive(color(255))
               .setDragDirection(Knob.HORIZONTAL);

}

void draw() { 
  background(cp.getColorValue());
  fill(0);
  rect(490,360,275,60);
  
  noStroke();
  fill(colorMax);
  rect(0,0,width,80);
  fill(colorMin);
  rect(0,355,width,65);
  
   if ((keyPressed == true) && (key == 'A')) {
    fill(0);
    rect(100,50,600,320);
  } else {//otherwise display ellipse
    noStroke();
    fill(84,255,159);
    ellipse(85, 100, cx1, cy1);
    ellipse(dragX,dragY,30,30);
    ellipse(650,355,20,20);
    //ellipse(160,280,35,35);
  }
   
    stroke(255);
    fill(rectColor);
    rect(x1,280,20,200);
    //rect for BACKSPACE &ENTER
  
    
    if(text1==true){
    textSize(58);
    text("Hello World!", 90, 55); 
    //text test
  }
  
  //ori code *easingball
  float targetX = mouseX;
  float dx = targetX - x;
  x += dx * easing;
  
  float targetY = mouseY;
  float dy = targetY - y;
  y += dy * easing;
  
  stroke(1);
  fill(ColorValue);
  ellipse(x, y, 70, 70);
  //mousedata
  ellipse(mouseX+5, mouseY+5, 45, 45);
  
  
  //mousecursor
  if (mouseX < 400) {
    cursor(mouseCursor, 0 , 0); //display image if x less than 400
  } else {
    cursor(CROSS);//else display cross
  }}
  
public void controlEvent(ControlEvent c) {
  // when a value change from a ColorPicker is received, extract the ARGB values
  // from the controller's array value
  
  if(c.isFrom(cp)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
   
    color col = color(r,g,b);
  }
  
   if(c.isFrom("rangeController")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    colorMin = int(c.getController().getArrayValue(0));
    colorMax = int(c.getController().getArrayValue(1));
  }
  
  if (c.isFrom(checkbox)) {
    rectColor= 0;
    int col = 0;
    for (int i=0;i<checkbox.getArrayValue().length;i++) {
      int n = (int)checkbox.getArrayValue()[i];
     
      if(n==1) {
        rectColor += checkbox.getItem(i).internalValue();
      }    
  }
}
}


 
  

// color information from ColorPicker 'picker' are forwarded to the picker(int) function
void picker(int col) {
 
}
  
  
 void Plus() {
      cx1=cx1+5;
      cy1=cy1+5;
}
 void Minus() {
      cx1=cx1-3;
      cy1=cy1-3; 
}
 
 
 
 /* code before apply CP5
      void mousePressed(){
      if (mouseButton == LEFT) {
      cx1=cx1+5;
      cy1=cy1+5;  //increase size
  } else if (mouseButton == RIGHT){
      cx1=cx1-3;
      cy1=cy1-3;  //decrease size
 
  }
  }*/
  
  
  
  //mouseevent
  void mouseDragged(){
  dragX=mouseX;
  dragY=mouseY;
  //change position of ellipse when mouse is dragged
  }
 
 
  void keyPressed(){
    
    if (keyCode == BACKSPACE) {
      x1 = x1 - 5;
      //move rect to left
    } else if(keyCode== ENTER){
      x1= x1 + 5;
      //move rect to right
  } 
    
    if((key== 'Q') || (key=='q')){
      text1=true;}
    //keyboard data: display text when press 
    
    if (key==' ') {
    checkbox.deactivateAll();
  } 
  else {
    for (int i=0;i<4;i++) {
      // check if key 0-4 have been pressed and toggle
      // the checkbox item accordingly.
      if (keyCode==(48 + i)) { 
        // the index of checkbox items start at 0
        checkbox.toggle(i);
      }
    }
  }
  }
  
  void keyReleased(){
      text1=false;//disappears when release key
  }



    
    
    
    

  

