// Copyright (C) 2020 RunwayML Examples
// 
// This file is part of RunwayML Examples.
// 
// Runway-Examples is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// Runway-Examples is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with RunwayML.  If not, see <http://www.gnu.org/licenses/>.
// 
// ===========================================================================

// RUNWAYML
// www.runwayml.com

// SPADE Landscapes Demo:
// Receive HTTP messages from Runway
// Running SPADE-Landscapes model
// example by George Profenza

// drawing layer
PGraphics drawing;
int currentLabelIndex = 0;
int currentLabelColor;

String status = "";

void setup(){
  size(1280,360);
  stroke(255);
  
  setupRunway();
  
  //setup drawing layer
  drawing = createGraphics(640,360);
  drawing.beginDraw();
  drawing.background(0);
  drawing.noStroke();
  drawing.endDraw();
}

void draw(){
  // clear background
  background(0);
  // preview drawing
  image(drawing,0,0);
  // display runway result (if any)
  if(runwayResult != null){
    image(runwayResult,640,0);
  }
  // display usage
  if(labels != null){
  text("LEFT/RIGHT = cycle through labels\n" +
      "currentLabel: " + labels[currentLabelIndex] + "\n" +  
       "click to draw\npress SPACE to send image to Runway\n" + status,5,15);
  }
  // separator
  line(640,0,640,360);
}

void mouseDragged(){
  drawing.beginDraw();
  drawing.fill(currentLabelColor);
  drawing.ellipse(constrain(mouseX,0,640),constrain(mouseY,0,360),36,36);
  drawing.endDraw();
}

void keyPressed(){
  if(keyCode == LEFT && currentLabelIndex > 0){
    currentLabelIndex--;
    updateLabelColor();
  }
  if(keyCode == RIGHT && currentLabelIndex < labels.length - 1){
    currentLabelIndex++;
    updateLabelColor();
  }
  if(key == ' '){
    status = "waiting for results";
    sendImageToRunway();
  }
}
