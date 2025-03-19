// Constants
final int SCREENX = 320;
final int SCREENY = 240;
final int PADDLEHEIGHT = 20;  // Increased for better collision detection
final int PADDLEWIDTH = 50;
final int MARGIN = 10;
final int RESET_DELAY = 2000;

// Player Class (for both human and computer)
class Player {
  int xpos, ypos;
  color paddlecolor;
  
  Player(int screen_y, color pColor) {
    xpos = SCREENX / 2;
    ypos = screen_y;
    paddlecolor = pColor;
  }
  
  void move(int x) {
    xpos = constrain(x, 0, SCREENX - PADDLEWIDTH);
  }

  // Move Computer Player - follows the ball with a 1-pixel adjustment
  void moveComputer(int ballX) {
    if (xpos + PADDLEWIDTH / 2 < ballX) {
      xpos += computerSpeed; // Move right
    } else if (xpos + PADDLEWIDTH / 2 > ballX) {
      xpos -= computerSpeed; // Move left
    }
    xpos = constrain(xpos, 0, SCREENX - PADDLEWIDTH); // Prevent going off-screen
  }
  
  void draw() {
    fill(paddlecolor);
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
  }
}

// Ball Class
class Ball {
  float x, y, dx, dy;
  int radius;
  color ballColor = color(0, 255, 0);
  
  Ball() {
    x = random(SCREENX / 4, SCREENX / 2);
    y = random(SCREENY / 4, SCREENY / 2);
    dx = random(1,4); 
    dy = ballSpeed;
    radius = 5;
  }
  
  void move() {
    x += dx;
    y += dy;
  }
  
  void draw() {
    fill(ballColor);
    ellipse(int(x), int(y), radius * 2, radius * 2);
  }
  
  void collide(Player tPlayer) {
    if (y + radius >= tPlayer.ypos && 
        y - radius < tPlayer.ypos + PADDLEHEIGHT && 
        x + radius >= tPlayer.xpos && 
        x - radius <= tPlayer.xpos + PADDLEWIDTH) {
      dy = -dy;
      computerSpeed += 0.5;
      ballSpeed += 0.5;
      //println("Collided with player!");
    }
  }

  void collideComputer(Player cPlayer) {
    if (y - radius <= cPlayer.ypos + PADDLEHEIGHT && 
        y + radius > cPlayer.ypos && 
        x + radius >= cPlayer.xpos && 
        x - radius <= cPlayer.xpos + PADDLEWIDTH) {
      dy = -dy;
      //println("Collided with computer!");
    }
  }
  
  void collideWalls() {
    if (x - radius <= 0 || x + radius >= SCREENX) {
      dx = -dx;
    }
    if (y - radius <= 0) {
      points++;
      println("You win! you have " + points + " points!");
      reset();
    }
    if (y + radius >= SCREENY) {
      lives--;
      println("You lose! you have " + lives + " lives left!");
      reset();
    }
  }
}

// Global Variables
Player thePlayer;  // Human controlled player
Player computerPlayer; // Computer controlled player
Ball theBall;

int points = 0; // Points variable
int lives = 3; // Lives variable

float computerSpeed = 1;
float ballSpeed = 1;

// Settings function
void settings() {
  size(SCREENX, SCREENY);
}

// Resest function
void reset() {
  println("Restarting round...");
  delay(RESET_DELAY);
  
  // Reset ball to the center
  theBall.x = SCREENX / 2;
  theBall.y = SCREENY / 2;
  
  // Randomize new ball movement direction
  theBall.dx = random(1,4) * random(1,-1);
  theBall.dy = 3 * random(1,-1);
}

// Game restart
void mousePressed() {
  println("New Game!");
  
  // Reset global variables
  points = 0;
  lives = 3;
  
  // Recreate the ball
  theBall = new Ball();
  
  delay(RESET_DELAY);
  
  // Restart the game loop
  loop();
}


// Setup function
void setup() {
  thePlayer = new Player(SCREENY - MARGIN - PADDLEHEIGHT, color(255, 255, 255)); // Human Player
  computerPlayer = new Player(MARGIN, color(200, 50, 50)); // AI Player at the top
  theBall = new Ball();
  ellipseMode(RADIUS);
  textSize(16);
  fill(255);
}

// Draw function
void draw() {
  background(0);
  
  textSize(32);
  
  thePlayer.move(mouseX); // Move human player
  computerPlayer.moveComputer(int(theBall.x)); // Move AI player
  
  theBall.move();
  theBall.collide(thePlayer);
  theBall.collideComputer(computerPlayer);
  theBall.collideWalls();
  
  thePlayer.draw();
  computerPlayer.draw();
  theBall.draw();
  
  if (points == 3) {
    fill(255,255,255);
    background(0);
    text("YOU WIN!", (SCREENX/2)-62, (SCREENY/2)+8);
    noLoop();
 } else if (lives == 0) {
     fill(255,0,0);
     background(0);
     text("GAME OVER", (SCREENX/2)-75, (SCREENY/2)+8);
     noLoop();
  } 
}
