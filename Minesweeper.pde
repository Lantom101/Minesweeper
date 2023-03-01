import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_MINES = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < NUM_ROWS; r++){
      for (int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    
    setMines();
}
public void setMines()
{
   while(mines.size()<NUM_MINES){
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[row][col])){
      mines.add(buttons[row][col]);
      System.out.println(row + ", " + col);
    }
   }
  
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
  // if all mines are flagged, return true
  int flaggedMines = 0;
    for (int r = 0; r < NUM_ROWS; r++){
      for (int c = 0; c < NUM_COLS; c++){
        if (mines.contains(buttons[r][c]) && buttons[r][c].isFlagged()){
          flaggedMines++;
        }
      }
    }
    if (flaggedMines == NUM_MINES){
      return true;
    }
    return false;
}
public void displayLosingMessage()
{
    for (int r = 0; r < NUM_ROWS; r++){
      for (int c = 0; c < NUM_COLS; c++){
        buttons[r][c].clicked = true;
      }
    }
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("lose!");
}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("win!");
}
public boolean isValid(int r, int c)
{
  if (r < NUM_ROWS && r >= 0 && c <NUM_COLS && c >= 0){
    return true;
  } else {
    return false;
  }
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
    numMines++;
  if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
  if(isValid(row,col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if(isValid(row+1,col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;
  return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT){
          if(flagged == true){
            flagged = false;
          } else {
            flagged = true;
          }
        } else if (mines.contains(this)){
          displayLosingMessage();
        } else if (countMines(myRow,myCol) > 0){
          buttons[myRow][myCol].setLabel(countMines(myRow,myCol));
        } else { // if center = 5
          if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].clicked == false){
          buttons[myRow-1][myCol-1].mousePressed(); // 1
          }
          if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked == false){
          buttons[myRow-1][myCol].mousePressed(); // 2
          }
          if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked == false){
          buttons[myRow-1][myCol+1].mousePressed(); // 3
          }
          if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false){
          buttons[myRow][myCol-1].mousePressed(); // 4
          }
          if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked == false){
          buttons[myRow][myCol+1].mousePressed(); // 6
          }
          if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked == false){
          buttons[myRow+1][myCol-1].mousePressed(); // 7
          }
          if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked == false){
          buttons[myRow+1][myCol].mousePressed(); // 8
          }
          if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].clicked == false){
          buttons[myRow+1][myCol+1].mousePressed(); // 9
          }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if(clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    //your code here
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        // width = 400/NUM_COLS;
        // height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        // else if( clicked && mines.contains(this) ) 
        //     fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
