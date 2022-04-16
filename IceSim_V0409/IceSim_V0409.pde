////////////////////////////////////////////////////////
////  Kin Blandford, Microporous Medium Simulator  /////
////  04/08/22                                     /////
////////////////////////////////////////////////////////

//// TODO ////

// Add loading progress bar with thread and number done/DIM^3
// Add button to 'scan' and save data (excel?)
// Add method to scan a folder of xRay images and make pointcloud
// Add a scale bar fitted to edge of cube, axes? Pore space perc in single sea ice crystals paper shows scale.
// Better generalize and relate scaling variables
// IDENTIFY PORES - in 3D array of points, start at random point. Add this to first pore list. Check neighbors. Add. Remove from checks. Repeat.
// Using instances of pore class find Euler Characteristic.
// Fluid permeability - Same method as identifying pores but instead starting from top layer.
// Figure out heap space issue. It's because of pShape, so maybe for 350+DIM just don't do visual display, just data. Then again, actual pores wont have as many points.

// Define pores from the very start -- IE walkers -- adding neighbors as they go?
// Octree?
// Slices / level sets??
// noiseDetail() for fitting to real life?
// Ability to save clouds?
// Think about signal domain?
// Figure out what the plots mean? Drainage curve looks similar?

//// SETUP ////
volatile boolean LOADED = false;


//function: input a series of points, out a series of points plus the points around it(neighbor search, recursive)(see paper alex gave me)

void setup()
{

  fullScreen(P3D);
  //size(1000,1000,OPENGL);

  cam = new PeasyCam(this, 300);
  controlP5 = new ControlP5(this);
  createStaticSliders();

  cam.setMinimumDistance(100);
  cam.setMaximumDistance(500);
  controlP5.setAutoDraw(false);

  double d = cam.getDistance() * 2;

  //pointShader = loadShader("pointfrag.txt", "pointvert.txt");
  //pointShader.set("maxDepth", (float) d);
  //shader(pointShader, POINTS);

  strokeWeight(strokeWeight);
  //noiseSeed(0); //for benchmarking
  //noiseDetail(); //sort of interesting

  // Initialize 3D ArrayList
  initPointCloudArray();


  thread("setupLoad");
}//end of setup

public void setupLoad() {
  makePointCloudShape();
  count();
  timeInt = millis();
  timeFloat = float(timeInt);

  LOADED = true;
}

//// DRAW ////
void draw()
{

  if (!LOADED) {

    cam.beginHUD();

    background(22);
    textSize(50);
    fill(255);

    text("Loading...", 75, 100);

    cam.endHUD();

    return;
  }

  background(0);
  noLights();

  shape(pointCloudShape);


  //draws GUI
  drawMenu();

  //check for update (enter pressed)
  if (keyPressed)
  {
    if (key == ENTER || key == RETURN)
    {
      update();
    }
  }

  //turn off camera control if mouse is in menu
  cam.setActive(true);

  if (isInsideMenu())
  {
    cam.setActive(false);
  }
}//end of draw
