class particule{
  final color colora = color(252, 152, 3);
  final color colorb = color(3, 49, 252);
  PVector pos = new PVector(0,0);
  PVector vel = new PVector(0,0);
  int state = 0;
  boolean process = true;
  public particule(PVector ppos, PVector pvel){
    pos = ppos;
    vel = pvel;
  }
  
  public void step(){
    final int offset = 50;
    if(pos.x>(-1*offset) && pos.x<(width+offset) && pos.y>(-1*offset) && pos.y<(height+offset)){
      pos.add(vel); 
    }else{
     process = false; 
    }
  }
  
  public void draw(){
   push();
   translate(pos.x,pos.y);
   //fill(lerpColor(colora,colorb,map(cos(10*radians(frameCount)),-1,1,0,1)));
   fill(255);
   noStroke();
   circle(0,0,2);
   pop();
  }
  
}
