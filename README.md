# pong-game

A custom Pong game project written in Processing 4, based on a programming lab assignment as part of first year computer science at TCD. 

CS1013 Programming Project
Exercise 2
1. Get the code presented in class working. i.e. setup and draw methods, human player
(bat), and ball. The integer variables mouseX and mouseY provide the x and y coordinates of the mouse pointer.
(20 marks)
2. Use the player class to create a computer player. You will need to create a new
method to control the computer's movement. A simple algorithm to use would be to
have the computer player move 1 pixel towards the ball position every frame. The
program must not directly copy the position of the ball as otherwise the human player
cannot win. The draw method for your new program will:
 move the ball
 move the computer player
 move the human player
 check for collision with human player
 check for collision with computer player
 draw the ball
 draw the computer player
 draw the human player
(20 marks).
3. Implement a reset() method which is called when the ball travels off the screen
(either the human or the computer has lost the game). The method should put the ball
back onto the screen and restart the game once the mouse button is pressed. If you
define a method called mousePressed(), Processing will call it when the mouse
is pressed. (20 marks).
4. Count the number of lives (hint: create an attribute and method in player). If the
computer wins three times, a game over message is displayed on the screen. If the
player wins three times, a different message is displayed. (20 marks).
5. Modify your program so that the speed and direction of movement of the bat affects
the trajectory of the ball when struck. (10 marks).
6. Modify your program so that the ball speeds up and the computer player gets better
over time. Show the current speed on the screen. (10 marks).
Lab challenge:
Details at the lab is you finish all parts.
