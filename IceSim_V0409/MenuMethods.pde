//// DRAW MENU ////
void drawMenu()
{
  cam.beginHUD();

  drawText();
  addSliders();

  fill(255);
  stroke(255);

  cam.endHUD();
}//end of drawmenu

//// SLIDER STUFF ////
void addSliders()
{
  controlP5.draw();
}//end of addSliders

//// CREATE SLIDERS ////
void createStaticSliders()
{
  controlP5.addSlider("threshold")
    .setPosition(35, 500)
    .setRange(0, 1)
    .setSize(250, 30)
    ;

  controlP5.addSlider("DIM")
    .setPosition(35, 540)
    .setRange(0, 700)
    .setSize(250, 30)
    ;

  controlP5.addSlider("zoom")
    .setPosition(35, 580)
    .setRange(0, 0.2)
    .setSize(250, 30)
    ;

  //controlP5.addSlider("res")
  //  .setPosition(35, 620)
  //  .setRange(1, 7)
  //  .setSize(250, 30)
  //  ;

  controlP5.setColorBackground(color(75));
  controlP5.setColorForeground(color(100));
  controlP5.setColorActive(color(155));
}//end of  createStaticSliders

//// DETECT MOUSE IN MENU ////
boolean isInsideMenu()
{
  if (mouseX < 333)
  {
    return true;
  } else
  {
    return false;
  }
}//end of isInsideMenu

//// TEXT AND INFO ////

void drawText()
{
  fill(255);
  textSize(15);

  text("Volume percent: ", 35, 40);
  text(volPerc + "%", 35, 55);

  text("Volume Points: ", 35, 90);
  text(points, 35, 105);

  text("Surface points: ", 35, 145);
  text(surfacePoints, 35, 160);


  text("Time to populate: ", 35, 240);
  text(timeFloat/1000 + "s", 35, 255);
 

  textSize(20);

  text("Press ENTER to update", 35, 680);
}//end of drawText
