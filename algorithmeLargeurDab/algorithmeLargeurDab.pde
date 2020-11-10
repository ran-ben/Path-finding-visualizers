
int i,j, w, h,posI,posJ,posIG,posJG,x1,x2,y1,y2;
PImage out;
float r,g,b;
ArrayList<Node> arbre;
 ArrayList<Node> erased;
int [][]obst={{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1},
        {1,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,3,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}; 

void setup() {
 
     size(512, 512);
     w=512;
     h=512;
     
 
    out=createImage(w,h,RGB);
    arbre= new ArrayList();
    erased= new ArrayList();
    createLabyrinth();
  
}

void draw() {

  
  }
  
  void mouseClicked(){
   
    getRobotPos();
    
    out.loadPixels();
    
    //position du premier pixel du robot
    int x = posJ*32;
    int y = posI*32;
    
    int mousePos = mouseX + mouseY*w;
    
    if(out.pixels[mousePos]!=color(0,255,0)&& out.pixels[mousePos]!=color(0,255,0) )
    {
        if(isNeighbour(mousePos,x+32,y) ){
          
          move(x,y,"r");
          
        }
        
        if(isNeighbour(mousePos,x,y+32) ){
          
          move(x,y,"d");
          
          
        }
          if(isNeighbour(mousePos,x,y-32) ){
          
          move(x,y,"u");
        
        
        }
        
        if(isNeighbour(mousePos,x-32,y) ){
          
          move(x,y,"l");
         
          
        }
        
    }
   
    
    
  }

//  la fonction de callback clavier
void keyPressed(){
  
  if(key==CODED)
  {
    getRobotPos();
    
    out.loadPixels();
    
    //position du premier pixel du robot
    int x = posJ*32;
    int y = posI*32;
    
    
    if(keyCode==UP){   
            
                           if(out.pixels[x+(y-32)*w]!=color(0,0,255)&& out.pixels[x+(y-32)*w]!=color(0,255,0))  
        
                            move(x,y,"u");
                          
                          
                        }




    
    if(keyCode==DOWN){    
                         
                        if(out.pixels[x+(y+32)*w]!=color(0,0,255)&& out.pixels[x+(y+32)*w]!=color(0,255,0)) move(x,y,"d");
                      
                  }
    
    
    
    if(keyCode==LEFT){      
                         if(out.pixels[(x-32)+y*w]!=color(0,0,255)&& out.pixels[(x-32)+y*w]!=color(0,255,0))move(x,y,"l");
                     
                              
    }
    
    
    
    if(keyCode==RIGHT){   
                        if(out.pixels[(x+32)+y*w]!=color(0,0,255)&& out.pixels[(x+32)+y*w]!=color(0,255,0))   move(x,y,"r");
                      
                              
    }
    
}
    
 
  
}

 
  
