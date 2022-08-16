int[] snakesX = new int[700]; //les parties du corps
int[] snakesY = new int[700];
int[] color_ = new int[700];
int spacey = 20; //espaces entre lignes et colonnes
int spacex = 20;
int snakeSize = 1;
float time = 200;
int moveX = 0; //déplacement sur l'axe des x et y
int moveY = 0;
int snakeHeadX; //la tête (permet de simplifier la syntaxe car on peut
int snakeHeadY; //aussi remplacer par l'index 0 de la liste snakes[])
int foodX;
int foodY;
long lastMove;
boolean gameOver;
int score = 0;

void setup() {
  size(901, 801);
  reset();
  colorMode(HSB, 100, 1, 1);
}

void draw() {
  background(0);
  grille();
  if (!gameOver) {
    fill(200, 1, 1);
    text("score: "+score, 20, 20);
    drawSnake();
    drawFood();
    if (millis()-lastMove >= time) { //permet de temporiser 
      snakeMove(); //le mvt du snake
      ateFood();
      lastMove = millis();
    }
  }
  else { text("GAME OVER,\npress 'r' to try again", width/2, height/2);} 
}

void grille() {
  stroke(10); 
  //lignes horizontales
  for(int i = 0; i < width; i++) {
    line(-1, i*spacey, width, i*spacey);
  }
  // lignes verticales
  for(int i = 0; i < height; i++) {
    line(i*spacex, -1, i*spacex, height);
  }
}

void reset() { //remet le jeu au départ
  int sX = (int)random(1, width/spacex);
  int sY = (int)random(1, height/spacey);
  int fX = (int)random(1, width/spacex);
  int fY = (int)random(1, height/spacey);
  snakeHeadX = sX*spacex; //position de la tête
  snakeHeadY = sY*spacey;
  foodX = fX*spacex;
  foodY = fY*spacey;
  moveX = 0; 
  moveY = 0;
  gameOver = false;
  score = 0;
  snakeSize = 1;
  lastMove = millis();
  time = 200;
  color_[0] = (int) random(100);
}
  
void drawSnake() {
  for (int i = 0; i < snakeSize; i++) { //définit
    int posx = snakesX[i]; //les coordonnées des parties du corps
    int posy = snakesY[i];
    fill(color_[i], 1, .5);
    rect(posx, posy, spacex, spacey); //dessine chaque partie
  }   
}

void ateFood(){
  if(foodX == snakeHeadX && foodY == snakeHeadY) {
     snakeSize++; //augmente la taille
     score++; //le score
     if (time > 60) //la vitesse
       time -= 3;     
     int X = (int)random(1, width/20); //place un nouveau fruit
     int Y = (int)random(1, height/20); //de coordonnées aléatoires
     foodX = X*20; //proportionnelles à la grille
     foodY = Y*20;
     color_[snakeSize-1] = (int) random(100); //et de couleur aléatoire
  }
}
  
void snakeMove() {
  snakeHeadX += moveX;
  snakeHeadY += moveY;
  
  if (snakeHeadX < 0 || snakeHeadX > width-1 || snakeHeadY < 0 || snakeHeadY > height-1) { gameOver = true;}
  for (int i = 1; i < snakeSize; i++) {
    if (snakesX[i] == snakeHeadX && snakesY[i] == snakeHeadY) //si la tête du serpent 
      gameOver = true; //touche une des parties du snake, game over
  }
  
  for(int i = snakeSize; i > 0; i--) { //bouge tous les éléments de la queue 
     snakesX[i] = snakesX[i-1]; 
     snakesY[i] = snakesY[i-1];
  }
  snakesX[0] = snakeHeadX; //la tête correspond à l'index 0
  snakesY[0] = snakeHeadY;
}

void drawFood() {
  fill(100, 1, 0.5);
  rect(foodX, foodY, spacex, spacey);
}

void keyPressed() {
  if(keyCode == UP) { 
    moveY = -spacey; 
    moveX = 0;   
  }
  if(keyCode == DOWN) {
    moveY = spacey; 
    moveX = 0;  
  }
  if(keyCode == LEFT) { 
    moveX = -spacex; 
    moveY = 0;   
  }
  if(keyCode == RIGHT) { 
    moveX = spacex; 
    moveY = 0;
  }
  if(key == 'r') { 
    reset();
  }
}