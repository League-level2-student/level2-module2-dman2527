//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
int x ;
int y ; 

// Add a constructor with parameters to initialize each variable.
Segment(int x , int y){
  this.x = x;
  this.y = y;
}

}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
Segment head ;
int foodx ;
int foody ;
ArrayList<Segment> tail = new ArrayList<Segment>();

int direction = UP;
int foodEaten = 0;
//*





//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.

//*

void setup() {
size(500,500);
  head = new Segment(100,30);
  frameRate(20);
  drawFood();
}

void dropFood() {
  //Set the food in a new random location
  foodx = ((int)random(50)*10);
  foody = ((int)random(50)*10);
 
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0,0,100);
  move();
  drawSnake();
  drawFood();
  eat();
}

void drawFood() {
  //Draw the food
fill(0,100,0);
rect(foodx,foody,10,10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(100,0,0);
  rect(head.x,head.y,10,10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
for(Segment s:tail){
 fill(50,50,50);
 rect(s.x,s.y,10,10);
}
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  tail.add(new Segment(head.x,head.y));
  tail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(int i=0; i< tail.size();i++){
   if(tail.get(i).x == head.x && tail.get(i).y == head.y){
    foodEaten = 1;
    tail.clear();
    tail.add(new Segment(head.x,head.y));
   }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if(key == CODED && direction !=RIGHT){
    if(keyCode == LEFT){
   direction = LEFT; 
  }
  }
  if(key == CODED && direction != DOWN){
    if(keyCode == UP){
   direction = UP; 
  }
  }
  if(key == CODED && direction != LEFT){
   if(keyCode == RIGHT){
   direction = RIGHT; 
  }
  }
  if(key == CODED && direction != UP ){
    if(keyCode == DOWN){
   direction = DOWN; 
  }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
   
  switch(direction) {
  case UP:
    head.y = head.y -10 ;
    break;
  case DOWN:
    head.y = head.y +10 ;
    break;
  case LEFT:
   head.x = head.x -10 ;
    break;
  case RIGHT:
    head.x = head.x +10 ;
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(head.x > 500){
  head.x = 0; 
 }
 if(head.x < 0){
  head.x = 500; 
 }
  if(head.y < 0){
  head.y = 500; 
 }
  if(head.y > 500){
  head.y = 0; 
 }
}



void eat() {
  if(head.x == foodx && head.y == foody){
    foodEaten = foodEaten + 1;
    drawFood();
    tail.add(new Segment(head.x,head.y));
    dropFood();
  }


}
