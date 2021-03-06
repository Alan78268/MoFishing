// Created By: Alan Mo 1A
// Version 1
// 3.5 hrs on 10/20/2019(background, fish, hook, platform, scenery, movement of hook and platform)
// 2 hrs on 10/21/2019(created sharks and collision detection of platform and hook)
// 2 hrs on 10/22/2019(fixed collision detection of the platform and hook, fish stay on hook if caught)
// 2 hrs on 10/23/2019(display the weight on the fish and sharks and display the number of pounds caught(score) fish goes back in the water when caught)
// 1 hr on 10/24/2019(cleaned up and commented code)

// 4 hrs on 11/3/2019(changed to an ArrayList of Fish, remove fish and replace with new one if caught. Added levels and added required amount of lbs to catch before level up. Added start screen)
// 0.5 hr on 11/6/2019(gameOver when catch shark)
// 1.5 hr on 11/8/2019(Improved gameOver screen and made functional restart/replay button)
// 5 hrs on 2/5/2020(switched over to inheritance, created button class, display the type of fish and shark when moused over)
//next steps: save data to file, make fish look better, display information about fish
Platform p;

Hook h;

Fish f;

Shark sh;
//Fish []myFish = new Fish[15];
ArrayList<Fish> myFish;
ArrayList<Shark> mySharks;

Score s;

Button gameOverButton;
Button startGame;

Table table;
int i = 0;
int j = 0;
void setup() {

  //  table = loadTable("new.csv", "header");
  //table.addColumn("id");
  //table.addColumn("species");
  //table.addColumn("name");
  //  table.sort("id");
  //  table.sort("species");
  //  table.sort("name");
  //TableRow newRow = table.addRow();
  ////newRow.setInt("id", table.lastRowIndex());
  //newRow.setString("species", "Panthera leo");
  //newRow.setString("name", "lion");
  //saveTable(table, "data/new.csv");



  // frame size
  size(1000, 1000);

  // frameRate(60);

  // create platform
  p = new Platform();

  // create hook
  h = new Hook();

  // create array of fishes
  myFish = new ArrayList<Fish>();

  // create array of sharks
  mySharks = new ArrayList<Shark>();

  // create Score
  s = new Score();
}// end of setup

void draw() {// display everything

  // light blue color (the sky)
  background(135, 206, 250);

  if (s.start) {// startScreen
    startScreen();
  } else if (!s.start) {// play screen
    textAlign(LEFT);
    rectMode(CORNER);
    noStroke();

    //display the sky
    fill(135, 206, 250);
    rect(0, 0, width, height);

    // display water
    fill(0, 0, 255);
    rect(0, height/1.5, width, height/1.5);

    // Display the sun
    strokeWeight(1);
    stroke(0);
    fill(255, 230, 0);
    ellipse(width, 30, 300, 300);

    // display Score
    s.display();

    // display platform
    p.display();
    p.keyPressed();

    // display fish
    for (i = 0; i < 15; i++) {
      textSize(18);
      myFish.add(new Fish());
      myFish.get(i).display();
      myFish.get(i).move();
      if (myFish.get(i).isCaught()) {
        myFish.remove(i);
      }
    }
    // display sharks
    for (j = 0; j < s.level; j++) {
      textSize(18);
      mySharks.add(new Shark());
      mySharks.get(j).display();
      mySharks.get(j).move();
      if (mySharks.get(j).isCaught()) {
        print("ya6y");

        mySharks.remove(j);
      }
    }

    // display hook
    h.display();
    h.keyPressed();

    gameOver();
  }// end of play screen
}// end of draw

void gameOver() {
  if (s.gameOver) {// if caught a shark then game over screen
    fill(0);
    rect(0, 0, width, height);// black background
    textAlign(CENTER);
    textSize(70);
    fill(255, 0, 0);
    text("GAME OVER", width/2, height/2-70);
    textSize(50);
    text("You were eaten by a shark at level: " + s.level, width/2, height/2);

    gameOverButton = new Button(width/2, height/2+200, 500, 200, 100, "Click to play again!!!");
    gameOverButton.display();
    if (gameOverButton.clicked) {
      // not game over anymore
      s.gameOver = false;
      //display startScreen
      s.start = true;
      startScreen();
    }// end of ifClicked
  }// end of if game over
}// end of gameOver method

void startScreen() {// start screen method
  s.gameOver = false;
  background(135, 206, 250);

  startGame = new Button(width/2, height/2, 500, 200, 100, "Click to start game!!!");
  startGame.display();
  if (startGame.clicked) {// if clicked
    // reset keyCode
    keyCode = ' ';

    // reset level
    s.level = 1;

    // reset score
    s.score = 0;

    // reset hook position
    h.x = width/2 + 60;
    h.y = height/2;

    // reset platform position
    p.x = width/2;
    p.y = height/2;

    // reset line position
    p.lineX = p.x+60;
    p.lineY = p.y;

    // not on startScreen anymore
    s.start = false;
  }// end of ifClicked
}// end of startScreen method
