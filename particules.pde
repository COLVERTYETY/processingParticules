import java.util.Collections;
int npart = 1000;
PVector temp = new PVector(0,0);
particule[] particules = new particule[npart];
evmachine evolmachine = new evmachine(100,5);
ArrayList<ref> refs = new ArrayList<ref>();
ArrayList<attractor> fields = new ArrayList<attractor>();
ArrayList<accelerator> accs = new ArrayList<accelerator>();
goal[] goals = new goal[1];

void setup(){
 size(800,500);
 background(0);
 frameRate(1000);
  //println(":::::::::::::::::::::::::::::::::::::::::::::",evolmachine.generation);
  //println("index: ",evolmachine.index);
  //println("code is: ",evolmachine.current().getcode());
  //println("enab is: ",evolmachine.current().getactiv());
  //println("inno is: ",evolmachine.current().getinnov());
  refs =evolmachine.giverefs();
  //println("refs: ",refs.size());
  fields = evolmachine.giveattract();
  //println("fields: ",fields.size());
  accs = evolmachine.giveaccels();
  //println("accs: ",accs.size());
 
 goals[0] = new goal(0,goals.length,new PVector(700,height/2),50);
 //goals[1] = new goal(1,goals.length,new PVector(400,100),50);
 //goals[2] = new goal(2,goals.length,new PVector(400,height-100),50);
 float step = (2*PI)/particules.length;
 for(int i =0;i<particules.length;i++){/////////////////////::particules
   particules[i] = new particule(new PVector(100,250),PVector.fromAngle(step*i).mult(2));
 }
}

void draw(){
 background(0);
 for(int i =0;i<goals.length;i++){
   goals[i].draw();
 }
 for(int i =0;i<particules.length;i++){
   if(particules[i].process){
     for(ref r: refs){
         if (r.intersection(particules[i],temp)){
           break; 
         }
     }
     for(attractor f : fields){
       f.step(particules[i]);
     }
     for(accelerator ac : accs){
       ac.step(particules[i]);
     }
     for(int j =0;j<goals.length;j++){
       goals[j].step(particules[i]);
     }
     particules[i].step();
     particules[i].draw();
   }
 }
   
 for(int i =0;i<refs.size();i++){
   refs.get(i).draw();
 }
 for(int i =0;i<fields.size();i++){
   fields.get(i).draw();
 }
 for(int i =0;i<accs.size();i++){
   accs.get(i).draw();
 }
 fill(0);
 rect(20,10,50,14);
 fill(255);
 text(frameRate,20,20);
 //if(frameCount%100==0){
 //  println(frameCount,calculatescore(goals));
 //}
 if(frameCount >600){
   frameCount = 1;
   //println("indiv: ",calculatescore(goals));
   evolmachine.step(calculatescore(goals));
   //println("cumul: ",evolmachine.scoretotal);
   setup(); 
 }
}


public int calculatescore(goal[] gg){
 int res = 0;
 for(int i =0;i<goals.length;i++){
   res+=gg[i].counter*(gg[i].level+1);
 }
 return res;
}
