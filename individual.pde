public class indiv implements Comparable<indiv>{
  ArrayList<gen> mygenes = new ArrayList<gen>();
  
  float score =0;
  float adjusted=0;
  int innovmax =0;
  
  public indiv copy(){
    indiv temp = new indiv();
    for(gen g: mygenes){
     temp.mygenes.add(g.copy()); 
    }
    temp.innovmax = innovmax;
    return temp;
  }
  
  public String getcode(){
   String res ="";
   for( gen g : mygenes){
     res+=Integer.toString(g.type); 
   }
   return res;
  }
  public String getinnov(){
   String res ="";
   for( gen g : mygenes){
     res+=Integer.toString(g.innov); 
   }
   return res;
  }
  public String getactiv(){
   String res ="";
   String buffer = "0";
   for( gen g : mygenes){
     buffer="0";
     if(g.enabled){
       buffer="1";
     }
     res+=buffer; 
   }
   return res;
  }
  public void addrnd(){
    mygenes.add(new gen(innovmax));
    innovmax++;
  }
  public void removernd(){
    mygenes.remove((int)random(mygenes.size()));
  }
  public void add(gen element){
     mygenes.add(element);
  }
  
  public void remove(int index){
    mygenes.remove(index);
  }
  public void clear(){
   mygenes.clear();
   innovmax=0;;
  }
  
  public void fullmutaterel(){
    for( gen g : mygenes){
       g.mutaterel(); 
    }
    
  }
  
  public void fullmutateabs(){
    for( gen g : mygenes){
       g.mutateabs(); 
    }
  }
  
  public void discmutateabs(int n){
    for(int i=0;i<n+1;i++){
      int pos = (int)random(mygenes.size());
      mygenes.get(pos).mutateabs();
    }
  }
  public void rndflip(){
    mygenes.get((int)random(mygenes.size())).flip();
  }
  public ArrayList<ref> createrefs(){
   ArrayList<ref> res = new ArrayList<ref>();
   ref temp;
   for( gen g : mygenes){
     if(g.type==0){
       temp = g.createref();
       if(temp!=null){
         res.add(temp);
       }
     }
   }
   return res; 
  }
  public ArrayList<attractor> createattractors(){
   ArrayList<attractor> res = new ArrayList<attractor>();
   attractor temp;
   for( gen g : mygenes){
     if(g.type==1){
       temp = g.createatract();
       if(temp!=null){
         res.add(temp);
       }
     }
   }
   return res; 
  }
  public ArrayList<accelerator> createaccelerators(){
   ArrayList<accelerator> res = new ArrayList<accelerator>();
   accelerator temp;
   for( gen g : mygenes){
     if(g.type==2){
       temp = g.createaccel();
       if(temp!=null){
         res.add(temp);
       }
     }
   }
   return res; 
  }
  @Override
  int compareTo(indiv other) {
    return (int)((other.score - score)*1000);
  }
}
