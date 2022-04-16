//// SURFACE CHECK ////
boolean neighborCheckSurface(float x, float y, float z)
{

  //if it is a point above the threshold,
  if (toggle(x, y, z))
  {
    //if one of its neighbors is below the threshold,
    if ((!toggle(x+1, y, z)) || !(toggle(x-1, y, z)) || !(toggle(x, y+1, z)) || !(toggle(x, y-1, z)) || !(toggle(x, y, z+1)) || !(toggle(x, y, z-1)))
    {
      return true;
    } else //(if no neighbors are below threshold, IE interior point)
    {
      return false;
    }
  } else //(if not a point above the threshold)
  {
    return false;
  }
}//end of neighborCheckSurface

//// NOISE TOGGLE ////
boolean toggle(float x, float y, float z)
{

  //scales input to 'index' precisely from noisespace
  //at points noiseX,noiseY,noiseZ, return true if value of noise is above threshold

  float noiseX = x*zoom;//+(DIM/2);
  float noiseY = y*zoom;//+(DIM/2);
  float noiseZ = z*zoom;//+(DIM/2);

  return((noise(noiseX, noiseY, noiseZ)<threshold));
}//end of toggle

//// TOTAL POINT COUNT ////
void count()
{

  points = 0;
  for (int i = 0; i < DIM; i++)
  {
    for (int j = 0; j < DIM; j++)
    {
      for (int k = 0; k < DIM; k++)
      {
        points += pointCloudArray.get(i).get(j).get(k);
      }//end of k loop
    }//end of j loop
  }//end of i loop

  floatPoints = float(points);
  volPerc = (floatPoints*100)/(floatDIM*floatDIM*floatDIM);
}//end of count method

//// CREATE SHAPE FROM CURRENT VALUES ////
void makePointCloudShape()
{
  surfacePoints = 0;
  initPointCloudArray();
  pointCloudShape = createShape();
  pointCloudShape.curveDetail(0);
  pointCloudShape.beginShape(POINTS);
  for (int i = 0; i < DIM; i+= 1)
  {
    for (int j = 0; j < DIM; j+= 1)
    {
      for (int k = 0; k < DIM; k+= 1)
      {
        float x = map(i, 0, DIM, -cubeSize, cubeSize);
        float y = map(j, 0, DIM, -cubeSize, cubeSize);
        float z = map(k, 0, DIM, -cubeSize, cubeSize);
        if (neighborCheckSurface(i, j, k)) //i,j,k used because noisespace not defined for negative values. zoom adjusts i,j,k to sample more appropriate area.
        {
          pointCloudShape.stroke(255);
          pointCloudShape.vertex(x, y, z);
          surfacePoints++;
        }
        if (toggle(i, j, k))
        {
          //add assign 1 to i,j,k in 3d array (int, not boolean, because may need higher value for different info)
          pointCloudArray.get(i).get(j).set(k, 1);
        }
      }//end of k loop
    }//end of j loop
  }//end of i loop
  pointCloudShape.endShape();
}//end of makePointCloudShape

void initPointCloudArray()
{
  pointCloudArraySize = 0;
  for (int i = 0; i < DIM; i++)
  {
    pointCloudArray.add(i, new ArrayList<ArrayList<Integer>>());
    for (int j = 0; j < DIM; j++)
    {
      pointCloudArray.get(i).add(j, new ArrayList<Integer>());
      for (int k = 0; k < DIM; k++)
      {
        pointCloudArray.get(i).get(j).add(0);
        pointCloudArraySize++;
      }
    }
  }
}//end of initPointCloudArray

void update()
{
  timeIntStart = millis();
  timeFloatStart = float(timeIntStart);
  floatDIM = float(DIM);
  makePointCloudShape();
  count();
  timeFloat = millis() - timeFloatStart;
}



//debug pointCloudArray
//for (int i = 0; i < DIM; i++)
//{
//  for (int j = 0; j < DIM; j++)
//  {
//    for (int k = 0; k < DIM; k++)
//    {
//      if (pointCloudArray.get(i).get(j).get(k) == 1)
//      {
//        float x = map(i, 0, DIM, -cubeSize, cubeSize);
//        float y = map(j, 0, DIM, -cubeSize, cubeSize);
//        float z = map(k, 0, DIM, -cubeSize, cubeSize);
//        stroke(255);
//        point(x, y, z);
//      }
//    }
//  }
//}

//old count()
//for (int i = 0; i < DIM; i++)
//{
//  for (int j = 0; j < DIM; j++)
//  {
//    for (int k = 0; k < DIM; k++)
//    {
//      if (toggle(i, j, k)) //i,j,k used because noisespace not defined for negative values. zoom adjusts i,j,k to sample more appropriate area.
//      {
//        points++;
//      }
//    }//end of k loop
//  }//end of j loop
//}//end of i loop

//old array populate
//// POPULATE POINT ARRAY BY MODE ////
//void populate()
//{

//  //surface only mode
//  if (surfaceOnly)
//  {
//    pointArray.clear();
//    for (int i = 0; i < DIM; i++)
//    {
//      for (int j = 0; j < DIM; j++)
//      {
//        for (int k = 0; k < DIM; k++)
//        {
//          float x = map(i, 0, DIM, -cubeSize, cubeSize);
//          float y = map(j, 0, DIM, -cubeSize, cubeSize);
//          float z = map(k, 0, DIM, -cubeSize, cubeSize);
//          if (neighborCheckSurface(i, j, k)) //i,j,k used because noisespace not defined for negative values. zoom adjusts i,j,k to sample more appropriate area.
//          {

//            pointArray.add(new Point(x, y, z, i, j, k)); //x,y,z used so center of cube boundary is 0,0,0.
//            surfacePoints++;
//          }
//        }//end of k loop
//      }//end of j loop
//    }//end of i loop
//  }//end of if surfaceOnly

//  //filled in mode
//  if (!surfaceOnly)
//  {
//    pointArray.clear();
//    for (int i = 0; i < DIM; i++)
//    {
//      for (int j = 0; j < DIM; j++)
//      {
//        for (int k = 0; k < DIM; k++)
//        {
//          float x = map(i, 0, DIM, -cubeSize, cubeSize);
//          float y = map(j, 0, DIM, -cubeSize, cubeSize);
//          float z = map(k, 0, DIM, -cubeSize, cubeSize);
//          if (toggle(i, j, k)) //i,j,k used because noisespace not defined for negative values. zoom adjusts i,j,k to sample more appropriate area.
//          {

//            pointArray.add(new Point(x, y, z, i, j, k)); //x,y,z used so center of cube boundary is 0,0,0.
//            surfacePoints++;
//          }
//        }//end of k loop
//      }//end of j loop
//    }//end of i loop
//  }//end of if !surfaceOnly
//}//end of populate method
