
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
      algorithmeProfondeur();

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
 
 void algorithmeProfondeur(){
     
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
     
   if(x1 !=x2 || y1!=y2 )
 {  
   Node tete= null;
   
   while(x1 !=x2 || y1!=y2)
    
   {
     


      
     tete= arbre.remove(arbre.size()-1);
     erased.add(tete);

      

      //add left
      if(x1-32>0 && out.pixels[x1-32+y1*w]!= color(0,0,255) && !exists(erased,x1-32,y1) )arbre.add(new Node(x1-32,y1,tete));
 
      //add down
      if(y1+32<h && out.pixels[x1+(y1+32)*w]!= color(0,0,255) && ! exists(erased,x1,y1+32) )arbre.add(new Node(x1,y1+32,tete));
      
    
   
      //add right
      if(x1+32<h && out.pixels[x1+32+y1*w]!= color(0,0,255) && !exists(erased,x1+32,y1) )arbre.add(new Node(x1+32,y1,tete));
      
     
      //add up
      if(y1-32>0 && out.pixels[x1+(y1-32)*w]!= color(0,0,255) && !exists(erased,x1,y1-32) )arbre.add(new Node(x1,y1-32,tete));
        
      x1= arbre.get(arbre.size()-1).x;
      y1= arbre.get(arbre.size()-1).y;
   }
   
      voirChemins();
      voirCheminSolution();
      out.updatePixels();
      image(out,0,0);
 }
 }
 
  
 void voirChemins(){
     
  
        // SI JE VEUX VOIR TOUT LE PARCOURS EN PROFONDEUR
      
     for(int k=0;k<erased.size();k++)
     {
       if(erased.get(k).dad!=null && (erased.get(k).x!=x2 || erased.get(k).y!=y2))
       colorierPixel1(erased.get(k).x,erased.get(k).y);
       
     }
 }
 
 void voirCheminSolution(){
      
    Node chemin =arbre.remove(arbre.size()-1);
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
