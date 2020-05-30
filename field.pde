class attractor extends expressed{
 PVector pos = new PVector(0,0); 
 float mag = 1;
 float rad = 100;
 
 public attractor(float x, float y, float magnitude, float radius){
   pos = new PVector(x,y);
   mag = magnitude;
   rad = radius;
 }
 public void step(particule part){
   if(PVector.dist(part.pos,pos)<=rad/2){
     //stroke(255);
     //line(pos.x,pos.y,part.pos.x,part.pos.y);
     PVector targ = part.pos.copy().sub(pos);
     targ.normalize().mult(mag);
     part.vel.add(targ);
   }
 }
 public void draw(){
   final color colorb = color(252, 152, 3);
   final color colora = color(3, 49, 252);
   push();
   noFill();
   stroke(lerpColor(colora,colorb,map(mag,-0.2,0.2,0,1)));
   translate(pos.x,pos.y);
   circle(0,0,rad);
   text("F",-5,5);
   text(mag,-5,17);
   pop();
 }
}
