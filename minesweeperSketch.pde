 Minesweeper x;
  int s = 30;
  int sWidth=20;
  int mx;
  int my;
  int t=0;
  boolean mouseClicked= false;
  boolean rightClick=false;
  boolean[][] visited = new boolean[s][s];
  int[][] b;
  ArrayList<Pairs> clickedCheck = new ArrayList<Pairs>();
  boolean[][] clicked = new boolean[s][s];

  void setup(){
    size(600,650);
    background(0);
    fill(86, 125, 70);
    stroke(0,0,0);
    for(int x=0; x<s; x++){
      for(int y=0; y<s; y++){
        rect(x*sWidth, y*sWidth, sWidth, sWidth);
        visited[x][y]=false;
        clicked[x][y]=false;
      }
    }
    fill(86, 125, 70);
    rect(0, 600, 600,100);
    fill(255,255,255);
    rect(500,610,80,30);
    fill(0,0,0);
    textSize(20);
    text("" + (int)(millis()/1000), 510, 633);
    textSize(15);
  }
  
  void draw(){
    fill(86, 125, 70);
    rect(0, 600, 600,100);
    fill(255,255,255);
    rect(500,610,80,30);
    fill(0,0,0);
    textSize(20);
    text("" + (int)(millis()/1000), 510, 633);
    textSize(15);
    if(t==0){
      if(mouseClicked==true && rightClick==false){
        x=new Minesweeper(30);
        b=x.getBoard();
        clickedCheck=x.getClickableBoxes();
        int row = (int)(my/sWidth);
        int col = (int)(mx/sWidth);
        while(b[row][col]!=0){
          x=new Minesweeper(30);
          b=x.getBoard();
          clickedCheck=x.getClickableBoxes();
          row = (int)(my/sWidth);
          col = (int)(mx/sWidth);
        }
        ArrayList<Pairs> q = x.chunkCall(row, col);
          for(int k=0; k<q.size(); k++){
            int tcol = q.get(k).getC();
            int trow = q.get(k).getR();
            visited[trow][tcol]=true;
            clicked[trow][tcol]=true;
            fill(230,230,130);
            rect(tcol*sWidth, trow*sWidth, sWidth, sWidth);
            if(b[trow][tcol]!=0){
              fill(0,0,0);
              text("" + b[trow][tcol],tcol*sWidth+2, trow*sWidth+15);
            }
          }
          t++;
      }
    }
    else{
      if(mouseClicked==true && rightClick==false){
        int row = (int)(my/sWidth);
        int col = (int)(mx/sWidth);
        int val = b[row][col];
        if(val==25){
          fill(250,0,0);
          rect(0, 0, s*sWidth, s*sWidth);
          textSize(60);
          fill(0,0,0);
          text("YOU LOSE :(", 90,330);
        }
        else if(val==0){
          ArrayList<Pairs> q = x.chunkCall(row, col);
          for(int k=0; k<q.size(); k++){
            int tcol=q.get(k).getC();
            int trow = q.get(k).getR();
            visited[trow][tcol]=true;
            clicked[trow][tcol]=true;
            fill(230,230,130);
            rect(tcol*sWidth, trow*sWidth, sWidth, sWidth);
            if(b[trow][tcol]!=0){
              fill(0,0,0);
              text("" + b[trow][tcol],tcol*sWidth+2, trow*sWidth+15);
            }
          }
        }
        else{
          fill(230,230,130);
          visited[row][col]=true;
          clicked[row][col]=true;
          rect(col*sWidth, row*sWidth, sWidth, sWidth);
          fill(0,0,0);
          text("" + b[row][col],col*sWidth+2, row*sWidth+15);
        }
      }
      else if(mouseClicked==false && rightClick==true){
        int row = (int)(my/sWidth);
        int col = (int)(mx/sWidth);
        visited[row][col]=true;
        fill(90,90,90);
        rect(sWidth*col+sWidth/3, sWidth*row + sWidth/6, 2, sWidth*2/3);
        fill(250,0,0);
        triangle(sWidth*col+sWidth/3, sWidth*row + sWidth/6, sWidth*col+sWidth/3, 
            sWidth*row + sWidth/2, sWidth*col+sWidth/3*2 + 5, sWidth*row + sWidth/3);
      }
      int countee=0;
      int counter=0;
      for(int tx=0; tx<s; tx++){
        for(int ty=0; ty<s; ty++){
            if(clicked[tx][ty]==true){
              countee++;
            }
            if(visited[tx][ty]==true){
              counter++;
            }
        }
      }
      if(countee==clickedCheck.size() && counter==s*s){
        fill(86, 125, 70);
        rect(120, 210, 360, 180);
        textSize(60);
        fill(255,255,255);
        text("YOU WIN!", 165,295);
        textSize(40);
        text("Time: " + (int)(millis()/1000), 185, 350);
        noLoop();
      }
      rightClick=false;
      mouseClicked=false; 
    }
  }
  
  void mousePressed(){
    if(mouseButton==LEFT){
      mouseClicked=true;
      mx = mouseX;
      my = mouseY;
      draw();
    }
    else if(mouseButton==RIGHT){
      rightClick=true;
      mx= mouseX;
      my = mouseY;
      draw();
    }
  }


class Minesweeper {
  private int[][] board;
  ArrayList<Pairs> clickableBoxes = new ArrayList<Pairs>();
  int BOMB=25;
  
  Minesweeper(int size){
    board = new int[size][size];
    for(int r=0; r<size; r++){
      for(int c=0; c<size; c++){
        if(Math.random()>.85){
          board[r][c]=BOMB;
        }
      }
    }
    for(int r=0; r<size; r++){
      for(int c=0; c<size; c++){
        if(board[r][c]!=BOMB){
          board[r][c]=getBombs(r, c);
          clickableBoxes.add(new Pairs(r,c));
        }
      }
    }
  }
  
  int getBombs(int x, int y){
    int count=0;
    for(int r=x-1; r<=x+1; r++){
      for(int c=y-1; c<=y+1; c++){
        if(r>=0 && r<board.length && c>=0 && c<board.length){
          if(r==x && c==y){
            
          }
          else if(board[r][c]==25){
            count++;
          }
        }
      }
    }
    return count;
  }
  
  ArrayList<Pairs> getClickableBoxes(){
    return clickableBoxes;
  }
  
  int[][] getBoard(){
    return board;
  }
  
  ArrayList<Pairs> p;
  
  ArrayList<Pairs> chunkCall(int r, int c){
    p = new ArrayList<Pairs>();
    chunk(r,c);
    return p;
  }
  
  boolean cons(ArrayList<Pairs> m, int r, int c){
    for(int j=0; j<m.size(); j++){
      if(m.get(j).getC()==c && m.get(j).getR()==r){
        return true;
      }
    }
    return false;
  }
  
  void chunk(int r, int c){
    if(r>=0 && r<board.length && c>=0 && c<board.length){ 
      p.add(new Pairs(r,c));
      if(r-1>=0){
        Pairs g = new Pairs(r-1,c);
        if(board[r-1][c]==0 && cons(p, r-1,c)==false){
          p.add(g);
          chunk(r-1,c);
        }
        if(board[r-1][c]!=0 && cons(p, r-1,c)==false){
          p.add(g);
        }
      }
      if(r+1<board.length){
        Pairs g = new Pairs(r+1,c);
        if(board[r+1][c]==0 && cons(p, r+1,c)==false){
          p.add(g);
          chunk(r+1,c);
        }
        if(board[r+1][c]!=0 && cons(p, r+1,c)==false){
          p.add(g);
        }
      }
      if(c+1<board.length){
        Pairs g = new Pairs(r,c+1);
        if(board[r][c+1]==0 && cons(p,r,c+1)==false){
          p.add(g);
          chunk(r,c+1);
        }
        if(board[r][c+1]!=0 && cons(p,r, c+1)==false){
          p.add(g);
        }
      }
      if(c-1>=0){
        Pairs g = new Pairs(r,c-1);
        if(board[r][c-1]==0 && cons(p,r, c-1)==false){
          p.add(g);
          chunk(r,c-1);
        }
        if(board[r][c-1]!=0 && cons(p, r, c-1)==false){
          p.add(g);
        }
      }
    }
  }
}

class Pairs {
  int ro;
  int co;
  Pairs(int r, int c){
    ro=r;
    co=c;
  }
  int getR() {
    return ro;
  }
  int getC() {
    return co;
  }
}
