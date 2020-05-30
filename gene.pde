public class gen{
  float x;
  float y;
  float a;
  float b;
  int type;
  int innov =0;
  boolean enabled = true;
  public gen(int type_,float x_, float y_, float a_, float b_){
   type = type_;
   x = x_;
   y = y_;
   a = a_;
   b = b_;
  }
  public gen copy(){
   gen temp =new gen(type,x,y,a,b);
   temp.innov=innov;
   temp.enabled = enabled;
   return temp;
  }
  public gen(int inniv){
   type = (int)random(0,3);
   x = random(0,1);
   y = random(0,1);
   a = random(0,1);
   b = random(0,1);
   innov = inniv;
  }
  
  public void mutateabs(){
    int which = (int)random(0,4);
   float mut = random(0.0,1.0);
   switch(which){
    
     case 0:
       x=mut;
       break;
     case 1:
       y=mut;
       break;
     case 2:
       a=mut;
       break;
     case 3:
       b=mut;
       break;
     
   }
  }
  
  public void flip(){
    enabled= ! enabled; 
  }
  
  public void mutaterel(){
   for(int i=0;i<4;i++){
     int which = (int)random(0,4);
     float mut = 0.02;
     float dir = 1;
     if(random(100)>50){
      dir = 1; 
     }else{
      dir = -1; 
     }
     switch(which){
      
       case 0:
         x+=mut*dir;
         if(x>1){
          x=1; 
         }else if(x<0){
         x=0;
         }
         break;
       case 1:
         y+=dir*mut;
         if(y>1){
          y=1; 
         }else if(y<0){
         y=0;
         }
         break;
       case 2:
         a+=dir*mut;
         if(a>1){
          a=1; 
         }else if(a<0){
         a=0;
         }
         break;
       case 3:
         b+=dir*mut;
         if(b>1){
          b=1; 
         }else if(b<0){
         b=0;
         }
         break;   
     }
   }
  }
  
  public ref createref(){
    ref res = null;
    if (type == 0 && enabled){
     res = new ref(new PVector(map(x,0,1.0,0,width),map(y,0,1.0,0,height)),PVector.fromAngle(map(a,0,1.0,0,2*PI)).mult(map(b,0,1.0,0,200)));
    }
    return res;
  }
  public attractor createatract(){
    attractor res = null;
    if (type == 1 && enabled){
     res = new attractor(map(x,0,1.0,0,width),map(y,0,1.0,0,height),map(a,0.0,1.0,-0.2,0.2),map(b,0,1,0,200));
    }
    return res;
  }
  public accelerator createaccel(){
    accelerator res = null;
    if (type == 2 && enabled){
        res = new accelerator(map(x,0,1.0,0,width),map(y,0,1.0,0,height),map(a,0.0,1.0,0.8,1.2),map(b,0,1,0,200));
    }
    return res;
  }
}
