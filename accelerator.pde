class accelerator extends expressed{
 PVector pos = new PVector(0,0); 
 float mag = 1;
 float rad = 100;
 float min = 0.1;
 float max = 2;
 public accelerator(float x, float y, float magnitude, float radius){
   pos = new PVector(x,y);
   mag = magnitude;
   rad = radius;
 }
 public void step(particule part){
   if(PVector.dist(part.pos,pos)<=rad/2){
     //stroke(255);
     //line(pos.x,pos.y,part.pos.x,part.pos.y);
     part.vel.mult(mag);
     if(part.vel.mag()<min){
        part.vel.normalize().mult(min);
     }else if(part.vel.mag()>max){
        part.vel.normalize().mult(max);
     }
   }
 }
 public void draw(){
   final color colorb = color(252, 0, 0);
   final color colora = color(0, 255, 0);
   push();
   noFill();
   stroke(lerpColor(colora,colorb,map(mag,0.8,1.2,0,1)));
   translate(pos.x,pos.y);
   circle(0,0,rad);
   text("A",-5,5);
   text(mag,-5,17);
   pop();
 }
}
