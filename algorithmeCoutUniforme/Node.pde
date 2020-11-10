public class Node implements Comparable<Node>{
  
  int x,y,cout;
  Node dad;
  
  
 public Node(int valX,int valY,Node d){
   
    x=valX;
    y=valY;
    dad=d;
    
    if(dad==null)cout=0;
    else cout= dad.cout+1;
     
 }
     public int compareTo(Node n){  
    
     if(n.cout==cout)  
     return 0;
    
        else if(cout>n.cout)  
     
        return 1;  
        else  
        return -1;  
        
     }
}
