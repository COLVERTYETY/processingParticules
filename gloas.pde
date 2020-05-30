class goal{
 int level = 0;
 int levelmax = 100;
 int counter =0;
 PVector pos = new PVector(0,0);
 float radius = 50;
 
 public goal(int plevel,int plevelmax,PVector ppos,int size){
   level = plevel;
   levelmax = plevelmax;
   pos =ppos;
   radius = size;
 }
 public void step(particule part){
   if((PVector.dist(part.pos,pos)<=radius/2)&& part.state == level){
     part.state++;
     counter++;
     if(level ==levelmax){
       part.process = false;
     }
   }
 }
 public void draw(){
   final color colorb = color(255, 0, 0);
   final color colora = color(0, 0, 255);
   push();
   translate(pos.x,pos.y);
   fill(lerpColor(colora,colorb,map(level,0,levelmax,0,1)));
   circle(0,0,radius);
   fill(255);
   text(level,-5,5);
   text(counter,-5,17);
   pop();
 }
  
  
}
