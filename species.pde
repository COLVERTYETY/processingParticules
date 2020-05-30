public class species{
  
 ArrayList<indiv> members = new ArrayList<indiv>();
 final float threshold = 0.7;
 int name = (int)random(1000);
 indiv repthewest = new indiv();
 float sumscore=0;
 public species(indiv representativ){
    repthewest = representativ;
    members.add(repthewest);
 }
 
 public boolean included( indiv test){
  boolean res = false;
  if(distance(test,repthewest)<=threshold){
   res = true;
   members.add(test);
  }
  return res;
 }
 
 
 public float adjust(){
   sumscore=0;
   Collections.sort(members);
   if(members.size()>0){
      members.remove(members.size()-1);//eliminate the worst
   }
   if(members.size()>0){
      members.add(members.get(0));//eliminate the worst
      members.get(members.size()-1).discmutateabs(5);
   }
   for(indiv member : members){
     member.adjusted = member.score/members.size();
     sumscore+=member.score/members.size();
   }
   return sumscore;
 }
 public void nextgen(float quantity){
  ArrayList<indiv> newmembers = new ArrayList<indiv>();
  indiv temp;
  for(indiv m: members){
   for(int i=0;i<quantity*(m.adjusted/sumscore);i++){
     temp = m.copy();
     if(random(100)<=100){//shall be mutated
       if(random(100)<=50){
         temp.fullmutaterel();
       }else{
         temp.fullmutateabs(); 
       }
     }
     if(random(100)<70){//change nodes
        if(random(100)<101){
          temp.addrnd();
        }else{
          temp.removernd();
        }
     }
     newmembers.add(temp);
   }
  }
  members = newmembers;
 }
 public void describe(){
  println("_____________species_____________");
  println("name: ",name);
  println("descr: ",repthewest.getcode());
  for(indiv m: members){
    println("     ¤ ",m.getcode(), " ",m.adjusted, " ", distance(repthewest,m));
  }
  println("size: ",members.size());
  println("sumscore: ",sumscore);
 }
 
 public void reduce(){
   if(members.size()>0){
    repthewest = members.get((int)random(members.size()));
     members.clear(); 
   } else{
    println("danger stranger problem helter skelter");
    describe();
    println("so???");
   }
   
 }
 
 public float distance(indiv first, indiv second){
   float c1=1;
   float c2 =1;
   float c3 =0.1;
   float res =0;
   int disj=0;
   int sim=0;
   boolean found = false;
   float weightavg = 0.0;
   int excess =abs(first.mygenes.size()-second.mygenes.size());
   indiv smaller = first;
   indiv bigger =second;
   if(first.mygenes.size()>second.mygenes.size()){
     bigger = first;
     smaller = second;
   }else{
    bigger = second;
    smaller = first;
   }
   int N = bigger.mygenes.size();
   for(gen sg: smaller.mygenes){
     found = false;
     for(gen bg : bigger.mygenes){
       if(sg.innov==bg.innov && sg.type == bg.type){
          found = true;
          weightavg+=abs(bg.x-sg.x);
          weightavg+=abs(bg.y-sg.y);
          weightavg+=abs(bg.a-sg.a);
          weightavg+=abs(bg.b-sg.b);
          sim++;
          break;
       }
     }
     if(!found){
       disj++; 
     }
   }
   weightavg/=sim;
   res = ((c1*excess)/N) + ((c2*disj)/N);
   if(!Double.isNaN(weightavg)){
    res+= c3*weightavg; 
   }
   return res;
 }
}
