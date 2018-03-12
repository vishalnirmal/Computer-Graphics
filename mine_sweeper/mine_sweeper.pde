cell c[];
final int size = 40;
final int nrows = 10;
final int ncols = 10;
int level=1;
int tilesOpened;
void setup()
{
  size(401,401);
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
  background(0);
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
  return 2*level;
}
void mousePressed()
{
  int i = floor(mouseX/size);
  int j = floor(mouseY/size);
  int index = index(i,j);
  if(mouseButton == RIGHT)
    c[index].flaged = true;
  else if (mouseButton == LEFT && c[index].isOpened==false)
  {
    tilesOpened++;
    c[index].isOpened = true;
    if(c[index].hasBomb)  gameover();
    if(c[index].neighbours == 0) c[index].floodfill();
  }
  //println(tilesOpened);
}
void draw()
{
  if(tilesOpened < (nrows*ncols-totalBombs(level)))
  for(int i=0;i<nrows;i++)
  {
    for(int j=0;j<ncols;j++)
    {
      c[index(i,j)].show();
    } 
  }
  else
  {
    fill(0,100,0);
    textSize(50);
    text("You Win!!",301*0.30,301*0.65);
  }
}