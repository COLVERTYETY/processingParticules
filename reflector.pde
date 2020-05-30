class ref extends expressed{
  public PVector pos = new PVector(0,0);
  public PVector arm = new PVector(0,0);
  public ref(PVector root, PVector parm){
   pos = root;
   arm = parm;
 }
 public void draw(){
   push();
   stroke(32, 230, 49);
   strokeWeight(1);
   translate(pos.x,pos.y);
   line(0,0,arm.x,arm.y);
   pop();
 }
 public boolean intersection(particule part, PVector result)
{
  PVector a = part.pos;
  PVector b = part.pos.copy().add(part.vel);
  // center everything on point "d"
  PVector axis = pos.copy().sub(pos.copy().add(arm));
  float axLen = axis.mag();
  axis.normalize();
  PVector workingA = a.copy().sub(pos.copy().add(arm));
  PVector workingB = b.copy().sub(pos.copy().add(arm));

  // create a perpendicular vector to "c-d"
  PVector rightang = new PVector(-axis.y, axis.x);

  // In short: rotate everything so "c-d" becomes the y-axis
  //   rightang becomes x-axis
  PVector mappedA = new PVector(workingA.dot(rightang), workingA.dot(axis));
  PVector mappedB = new PVector(workingB.dot(rightang), workingB.dot(axis));
  // More detail: mappedA and -B are projections of "a" and "b" onto the lines
  //   "c-d" and "rightang", creating Axis Aligned 2D coordinates

  // Get the axis-aligned segment
  PVector dir = mappedA.sub(mappedB);

  // This is the same math used for 2D axis-aligned-bounding-boxes but only used
  //   for one intersection instead of two edges
  // In other words:
  //   "How much do we change segment 'a-b's length to reach segment 'c-d'?"
  // Result can be +/- INF, meaning segments are parallel
  // Relying on the floating point to handle div by 0.0 --> INF
  //   is implementation dependant. Your hardware may vary.
  float tx = 1.0 / 0.0;
  if (abs(dir.x) > 0.0)
    tx = -mappedB.x / dir.x;
  
  // when the original line segment "a-b" is extended/shortened by tx,
  //   the end of that segment is the intersecting point
  PVector inters = a.copy().sub(b).mult(tx).add(b);
  result.set(inters);
  
  // Segment/segment intersection:
  // Logic is that if the first segment would have to expand or reverse to
  //   reach the point at 'inters', then the segments do not cross
  float ty = inters.sub(pos.copy().add(arm)).dot(axis);
  boolean intersecting = (tx >= 0) && (tx <= 1.0) && (ty >= 0) && (ty <= axLen);
  if(intersecting){
    //calculating reflection vector using: R = 2(N.L)N-L
       float mag = part.vel.mag();
       PVector norm = new PVector(-arm.y,arm.x);//mirror vect
       norm.normalize();
       PVector incidence =part.vel.copy().mult(-1);//normalized vel
       incidence.normalize();
       float dot = incidence.dot(norm);//angle dot product
       part.vel.set(2*norm.x*dot - incidence.x, 2*norm.y*dot - incidence.y);
       part.vel.mult(mag);
  }
  return intersecting;
}
 
}
