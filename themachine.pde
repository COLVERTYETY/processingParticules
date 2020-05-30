public class evmachine{
 float scoretotal=0;
 int generation =0;
 ArrayList<indiv> thepop = new ArrayList<indiv>();
 ArrayList<species> thespecies = new ArrayList<species>();
 int index=0;
 int popsize = 10;
 public evmachine(int size, int startlength){
  indiv temp=new indiv();
  popsize = size;
  for(int j=0;j<size;j++){
    temp = new indiv();
    temp.innovmax=startlength;
    for(int i=0;i<startlength;i++){
     temp.add( new gen(i));
    }
    thepop.add(temp);
  }
 }
 
 public indiv current(){
  return thepop.get(index); 
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
   println("//////////////////////////////////");
   println("big: ",bigger.getcode());
   println("smal: ",smaller.getcode());
   println("excess: ",excess);
   println("disj: ",disj);
   println("avg: ",weightavg);
   println("N: ",N);
   return res;
 }
 
 
 public void step(int score){
   scoretotal+=score;
   thepop.get(index).score=score;
   index++;
   if(index>=thepop.size()){
     index=0;
     generation++;
     nextgen();
     //for( indiv ind : thepop){
     //  int mut = (int)random(0,5);
     //  switch(mut){
     //     case 0:
     //       ind.fullmutaterel();
     //       break;
     //     case 1:
     //       ind.fullmutateabs();
     //       break;
     //     case 2:
     //       ind.addrnd();
     //       break;
     //     case 3:
     //       if(ind.mygenes.size()>1){
     //         ind.removernd();
     //       }
     //       break;
     //      case 4:
     //       ind.rndflip();
     //       break;
     //  }
     //}
   }
   
 }
 
 public void nextgen(){
  Collections.sort(thepop);
  println("-------------------result-------------------");
  for(indiv i: thepop){
    println("-- ",i.score,"  ",i.getcode()); 
  }
  boolean foundafam = false;
  for( indiv ind : thepop){//sort by species
    foundafam = false;
    for(species s : thespecies){
      if(s.included(ind)){
        foundafam = true;
        break;
      }
    }
    if(!foundafam){//has no spiecies so add a species
     thespecies.add(new species(ind)); 
    }
  }
  
  ArrayList<species> temp = new ArrayList<species>();//////remove empty
  for(int i =0;i<thespecies.size();i++){
    if(thespecies.get(i).members.size()!=0){
      temp.add(thespecies.get(i));
    }
  }
  thespecies = temp;
  scoretotal=0;
  for(species s : thespecies){//////////////////////adjust fitnest
        scoretotal+=s.adjust();
        s.describe();  
  }
  
  for(species s : thespecies){//////////////////////nextgen (reproduce) and mutate
        s.nextgen((popsize*(s.sumscore/scoretotal)));
  }
  temp = new ArrayList<species>();////////////////////remove empty
  for(int i =0;i<thespecies.size();i++){
    if(thespecies.get(i).members.size()!=0){
      temp.add(thespecies.get(i));
    }
  }
  thespecies = temp;
  for(species s : thespecies){////////////////////////cleanup species
      s.reduce();
    }
    
  println("score total ",scoretotal);
 }
 
 public ArrayList<ref> giverefs(){
  return thepop.get(index).createrefs(); 
 }
 public ArrayList<accelerator> giveaccels(){
  return thepop.get(index).createaccelerators(); 
 }
 public ArrayList<attractor> giveattract(){
  return thepop.get(index).createattractors(); 
 }
}
