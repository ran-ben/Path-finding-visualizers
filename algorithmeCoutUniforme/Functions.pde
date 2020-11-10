import java.util.Collections;

void createLabyrinth(){
  
  // l 'image etant vide on utilise ses pixels
  out.loadPixels();
  
  for (int x = 0; x < w; x++ ) {
    for (int y = 0; y < h; y++ ) {

      // Calculate the 1D pixel location
      
      int loc = x + y*w;
      int stepx=w/16;
      int stepy=h/16;
      i= y/stepy; j=x/stepx;
      int val=obst[i][j];
      switch (val)
      {
        case 0: r= 0; g=0; b=0; break;
        case 1: r= 0; g=0; b=255; break;
        case 2: r= 255; g=0; b=0; break;
        case 3: r= 0; g=255; b=0; break;
      }      

      color c = color(r, g, b);
      out.pixels[loc]=c;
      
    }
  }
   out.updatePixels();
      image(out,0,0);
   
   algorithmeCoutUni();

}


 void getRobotPos(){
   
   for(int i=0;i<16;i++){
    
    for(int j=0;j<16;j++){
    
      if(obst[i][j]==2){
        
        posI=i;
        posJ=j;
      
      }
    
  }
 }
 }
 
  void getGoalPos(){
   
   for(int i=0;i<16;i++){
    
    for(int j=0;j<16;j++){
    
      if(obst[i][j]==3){
        
        posIG=i;
        posJG=j;
      
      }
    
  }
 }
 }
 
 
 boolean isNeighbour(int mousePos, int posX, int posY){
   
   out.loadPixels();
  
   
   if( out.pixels[posX+posY*w]== color(0,0,255)) return false;
   
     for(int x=posX ; x<posX+32;x++){
       
       for(int y=posY;y<posY+32;y++){
       
         if( x+y*w == mousePos) return true;
       }
     }
   return false;
 }
 
 
 
 void move(int x, int y, String direction){
       
    switch (direction){
      
      case "r": { x=x+32;  
                  obst[posI][posJ]=0;
                  obst[posI][posJ+1]=2;
                }break;
      
      case "l": { x=x-32;  
                  obst[posI][posJ]=0;
                  obst[posI][posJ-1]=2;
                  
                }break;
      
      
      case "u": { y=y-32;  
                  obst[posI][posJ]=0;
                  obst[posI-1][posJ]=2;}break;
      
      case "d": {    y=y+32;
                     obst[posI][posJ]=0;
                     obst[posI+1][posJ]=2;
                    }break;
    
    }
    
    createLabyrinth();
    
   
 
 }
 
 void colorierPixel(int x,int y){
   
    out.loadPixels();
   
    for (int k = x; k < x+32; k++ ) {
    for (int z = y; z < y+32; z++ ) {
      
      out.pixels[k+z*w]= color(255,255,0);
      
    }
    }
 }
 
  void colorierPixel1(int x,int y){
   
    out.loadPixels();
   
    for (int k = x; k < x+32; k++ ) {
    for (int z = y; z < y+32; z++ ) {
      
      out.pixels[k+z*w]= color(255,165,0);
      
    }
    }
 }
 
 
 void algorithmeCoutUni(){
     
     arbre.clear();
     erased.clear();
     getRobotPos();
    //position du premier pixel du robot
     x1 = posJ*32;
     y1 = posI*32;
    
     getGoalPos();
      
     x2= posJG*32;
     y2 = posIG*32;
     
     arbre.add(new Node(x1,y1,null));
     
      
     out.loadPixels();
     

   while(x1!=x2 || y1!=y2)
    
   {
   
     //add up
     if(y1-32>0 && out.pixels[x1+(y1-32)*w]!= color(0,0,255)){
       
       if( ! exists(erased,x1,y1-32) )
       {
          getFromArbre(x1,y1-32);
       }
       
       else {
         
         getFromErased(x1,y1-32);
        
       }
     }
     //add right
     if(x1+32<h && out.pixels[x1+32+y1*w]!= color(0,0,255))
    
     {
       if( ! exists(erased,x1+32,y1) )
       {
         getFromArbre(x1+32,y1);
       }
       else {
         
         getFromErased(x1+32,y1);
                
       }
     }
    
    
     //add left
     if(x1-32>0 && out.pixels[x1-32+y1*w]!= color(0,0,255) ){
      if( ! exists(erased,x1-32,y1) )
       {
         getFromArbre(x1-32,y1);
       }
       else {
         
         getFromErased(x1-32,y1);
         
       }
     }
     
     //add down
     if(y1+32<h && out.pixels[x1+(y1+32)*w]!= color(0,0,255))
     
      if( ! exists(erased,x1,y1+32) )
       {
         getFromArbre(x1,y1+32);
       }
       else {
         
         getFromErased(x1,y1+32);         
       }
      
     erased.add(arbre.remove(0));
     Collections.sort(arbre);
     
     x1=arbre.get(0).x;
     y1=arbre.get(0).y;
     
   }
  
      voirChemins();
      voirCheminSolution(arbre.get(0));
     
   
      out.updatePixels();
      image(out,0,0);
 }
 
 
 void voirChemins(){
      
     
      
     for(int k=0;k<erased.size();k++)
     {
       if(erased.get(k).dad!=null && (erased.get(k).x!=x2 || erased.get(k).y!=y2))
       colorierPixel1(erased.get(k).x,erased.get(k).y);
       
     }
 }
 
 void voirCheminSolution(Node chemin){
        
       chemin= chemin.dad;
       while(chemin.dad!=null)
        {
          
           colorierPixel(chemin.x,chemin.y);
            chemin= chemin.dad;
        }
 }
 
 boolean exists(ArrayList<Node> erase,int x,int y){
   
   for(int i=0;i<erase.size();i++){
     
     if(erase.get(i).x== x && erase.get(i).y== y){
       
       return true;
     }
   }
   return false;
 }
 
 void getFromArbre(int x,int y){
   
  
   for(Node n : arbre){
     
     if(n.x==x && n.y==y && n.cout>arbre.get(0).cout+1){
       
        arbre.remove(n);
       

      }
       
   }
   
  arbre.add(new Node(x,y,arbre.get(0)));
  
 }
 
  void getFromErased(int x,int y){
   
   for(Node n : erased){
     
     if(n.x==x && n.y==y && n.cout>arbre.get(0).cout+1){
       
       arbre.add(new Node(x,y,arbre.get(0)));
          
       
     }
   }
  
 }
 
 
