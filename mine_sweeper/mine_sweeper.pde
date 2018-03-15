cell c[];
final int size = 50;
final int nrows = 8;
final int ncols = 8;
final int gap = 2;
int level=1;
int tilesOpened;
PImage win;
PImage flag,bomb;
int counter = 0;
void setup()
{
  size(417,417);
  win = loadImage("/home/vishalnirmal/Programs/Computer-graphics/mine_sweeper/youwin.png");
  flag = loadImage("/home/vishalnirmal/sketchbook/mine_sweeper/flag.jpg");
  bomb = loadImage("/home/vishalnirmal/sketchbook/mine_sweeper/bomb.png");
  win.resize(501,501);
  flag.resize(49,49);
  bomb.resize(49,49);
  c = new cell[nrows*ncols];
  for(int i=0;i<nrows;i++)
  {
    for(int j=0;j<ncols;j++)
    {
      c[index(i,j)] = new cell(i,j,size);
    } 
  }
  placeBombs(c);
  for(int i=0;i<nrows;i++)
  {
    for(int j=0;j<ncols;j++)
    {
      c[index(i,j)].countBombs();
    } 
  }
  background(255);
  frameRate(100);
}
int index(int i,int j){
return i + j*nrows;
}
void placeBombs(cell c[])
{
  int total = totalBombs(level);
  int count=1;
  while(count<=total)
  {
    int index = floor(random(nrows*ncols));
    if(!c[index].hasBomb)
    {
      c[index].hasBomb = true;
      count++;
    }
  }
}
void gameover()
{
  for(int i=0;i<nrows;i++)
  {
    for(int j=0;j<ncols;j++)
    {
      c[index(i,j)].isOpened=true;
    }
  }
}
int totalBombs(int level)
{
  return 8+2*level;
}
void mousePressed()
{
  int i = floor(mouseX/size);
  int j = floor(mouseY/size);
  int index = index(i,j);
  if(mouseButton == RIGHT)
    c[index].flaged = !c[index].flaged;
  else if (mouseButton == LEFT && c[index].isOpened==false)
  {
    tilesOpened++;
    c[index].isOpened = true;
    if(c[index].hasBomb)  {
      c[index].clickedMine = true;
      gameover();
    }
    if(c[index].neighbours == 0) c[index].floodfill();
  }
}
void draw()
{
  if(mouseX>=0 && mouseX<width && mouseY>=0 && mouseY<height)
  c[index(floor(mouseX/size),floor(mouseY/size))].onMouse = true;
  if(tilesOpened >= (nrows*ncols-totalBombs(level)))
  {
    gameover();
  }
    for(int i=0;i<nrows;i++)
    {
      for(int j=0;j<ncols;j++)
      {
        c[index(i,j)].show();
      } 
    }
}