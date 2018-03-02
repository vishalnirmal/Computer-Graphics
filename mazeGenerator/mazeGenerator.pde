import java.util.*;

int rows,cols,w=10;
cell current,grid[],next;
Stack<cell> stack = new Stack();
void setup()
{
  size(400,400);
  rows = 400/w;
  cols = 400/w;
  grid = new cell[rows*cols];
  for(int i=0;i<rows;i++)
  {
    for(int j=0;j<cols;j++)
    {
      cell c = new cell(i,j);
      int index = j + i*cols;
      grid[index]=c;
    }
  }
  current = grid[0];
  stack.push(current);
  current.visited = true;
  background(252,128,114);
}

void draw()
{
  background(252,128,114);
  for(int i=0;i<grid.length;i++)
  {
    grid[i].show();
  }
  current.highlight();
  next = current.checkNeighbors();
    if(next!=null)
    {
      removeWalls(current,next);
      current = next;
      stack.push(current);
      
      current.visited = true;
    }
    else if(!stack.empty())
    {
      current = stack.pop();
    }
}

void removeWalls(cell a,cell b)
{
  int xi = a.i-b.i;
  if(xi==1)
  {
    a.walls[3] = false;
    b.walls[1] = false;
  }
  if(xi==-1)
  {
    a.walls[1] = false;
    b.walls[3] = false;
  }
  xi = a.j-b.j;
  if(xi==1)
  {
    a.walls[0] = false;
    b.walls[2] = false;
  }
  if(xi==-1)
  {
    a.walls[2] = false;
    b.walls[0] = false;
  }
  
}