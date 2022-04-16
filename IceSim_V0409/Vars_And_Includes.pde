//// IMPORTS ////
import controlP5.*;
import peasy.*;
import java.util.ArrayList;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import processing.opengl.*;

//// MODES ////
boolean shapeMode = true; //renders using PShape (high performance, no live manipulation. Set with button.) Works up to DIM ~570

//// VALUES ////
int DIM = 100; //got this to work up to 1,000 (one billion points) when I turned off loop in draw
float cubeSize = 100;//controls size of cube on screen (functionally eq. to zooming camera)
float zoom = 0.02; //control with slider //controls zoom on sampling from noisespace, IE how big of an area of the cloud we are sampling
float threshold = 0.555; //control with slider
float strokeWeight = 1;
//int res = 1;

//// PROGRAM VARIABLES ////
int points = 0; //counts number of points in domain
int surfacePoints = 0; //counts number of points on surface
int pointCloudArraySize = 0;
float floatPoints; //for more accurate vol frac calculation
float floatDIM = float(DIM); //for more accurate vol frac calculation
float volPerc; //volume percentage, calculated later at end of populate. points function as center of equally sized imaginary voxels for the sake of volume calculation. all !points also have imaginary centers.

int timeInt = 0; //used to get render time
float timeFloat = 0; //used to calculate render time
int timeIntStart = 0;
float timeFloatStart = 0;

float a = 0; //animated parameter

//// OBJECT INITIALIZATION ////
PeasyCam cam;
ControlP5 controlP5;

ArrayList<ArrayList<ArrayList<Integer>>> pointCloudArray = new ArrayList<>();

PShape pointCloudShape;
PShader pointShader;
