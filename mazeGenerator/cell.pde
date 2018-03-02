class cell
{
  int i,j;
  boolean walls[] = {true , true , true , true};
  boolean visited = false; 
  cell(int i,int j)
  {
    this.i = i;
    this.j = j;
  }
  
  void show()
  {
    int x = i*w;
    int y = j*w;
    stroke(0);
    if(walls[0])
    {
      line(x,y,x+w,y);
    }
    if(walls[1])
    {
      line(x+w,y,x+w,y+w);
    }
    if(walls[2])
    {
      line(x+w,y+w,x,y+w);
    }
    if(walls[3])
    {
      line(x,y+w,x,y);
    }
    
    
    if(this.visited)
    {
      noStroke();
      fill(252,128,114);
      rect(x+1,y+1,w-1,w-1);
    }
    
  }
  void highlight()
  {
    int x = this.i*w;
    int y = this.j*w;
    fill(0);
    noStroke();
    rect(x,y,w,w);
  }
  int index(int i,int j)
  {
    if(i<0||i>cols-1||j<0||j>rows-1)
    return -1;
    return j+i*cols;
  }
  cell checkNeighbors()
  {
    int co=0;
    cell neighbors[] = {null,null,null,null};
    cell top=null,bottom=null,right=null,left=null;
    int ir=-1,il=-1,ib=-1,it=-1;
    if(this.index(i,j-1)!=-1){
    it = this.index(i,j-1);
    top = grid[it];
    }
    if(this.index(i+1,j)!=-1){
    ir = this.index(i+1,j);
    right = grid[ir];
    }
    if(this.index(i,j+1)!=-1){
    ib = this.index(i,j+1);
    bottom = grid[ib];
    }
    if(this.index(i-1,j)!=-1){
    il = this.index(i-1,j);
    left = grid[il];
    }
    
    if(top!=null && !top.visited)
    neighbors[co++]=top;
    if(right!=null && !right.visited)
    neighbors[co++]=right;
    if(bottom!=null && !bottom.visited)
    neighbors[co++]=bottom;
    if(left!=null && !left.visited)
    neighbors[co++]=left;
    if(co>0)
    return neighbors[(int)random(0,co)];
    else
    return null;
    
  }
  
}