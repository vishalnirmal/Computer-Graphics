class cell
{
  int i,j;
  int x,y;
  int size;
  int neighbours=0;
  boolean isOpened = false;
  boolean hasBomb = false;
  boolean flaged = false;
  cell(int i,int j,int size)
  {
    this.i = i;
    this.j = j;
    this.size = size;
    x = i*size;
    y = j*size;
  }
  void show()
  {
    fill(255);
    rect(x,y,size,size);
    if(isOpened)
    {
      if(hasBomb)
      {
        fill(0);
        ellipse(x+size*0.5,y+size*0.5,size*0.5,size*0.5);
      }
      else
      {
        fill(200);
        rect(x,y,size,size);
        if(neighbours>0){
          fill(0);
          textSize(size*.5);
          text(neighbours,x+size*0.35,y+size*0.75);
        }
      }
    }
    else if(flaged)
    {
      fill(0);
      rect(x+size*0.25,y+size*.25,size*0.5,size*0.5);
    }
  }
  void countBombs()
  {
    int count=0;
    for(int i = -1;i<2;i++)
    {
      for(int j=-1;j<2;j++)
      {
        if (this.i+i<0 || this.i+i>=nrows)  continue;
        if(this.j+j<0 || this.j+j>=ncols)  continue;
        if(c[index(this.i+i,this.j+j)].hasBomb) count++;
      }
    }
    this.neighbours = count;
  }
  void floodfill()
  {
    for(int i = -1;i<2;i++)
    {
      for(int j=-1;j<2;j++)
      {
        int x1 = this.i+i;
        int y1 = this.j+j;
        if (x1<0 || x1>=nrows || y1<0 || y1>=ncols || (i==0 && j==0))  
          continue;
        if(c[index(x1,y1)].neighbours == 0 && c[index(x1,y1)].isOpened == false) 
        {
          tilesOpened++;
          c[index(x1,y1)].isOpened = true;
          c[index(x1,y1)].floodfill();
        }
      }
    }
  }
}