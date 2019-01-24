/**
 Snake Game
 By Nathan Breunig
 Last Updated: 1/23/18
 **/

ArrayList<Cell> snakeCells; //snake represented as an array of cells
Cell food;
int cellWidth, cellHeight;
boolean up, down, left, right; //direction snake is moving

void setup() {
  size(1400, 800);
  background(0);
  frameRate(10);
  cellWidth = width/40;
  cellHeight = height/20;
  up = false; 
  down = false; 
  left = false; 
  right = false;
  snakeCells = new ArrayList();
  snakeCells.add(new Cell((int)random(0, 40), (int)random(0, 19)));
  food = new Cell((int)random(0, 40), (int)random(0, 19));
}

void draw() {
  if (!gameOver()) {
    background(0);
    stroke(255);
    updateGame();

    for (int x = 0; x < 50; x++) {
      for (int y = 0; y < 50; y++) {
        if (x == food.x && y == food.y) {
          //if this spot is the food
          fill(102, 102, 0);
          rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);
        } else {
          fill(51, 153, 255);
          rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);
        }
        for (Cell cell : snakeCells) {
          if (cell.x == x && cell.y == y) {
            //if this spot is one of the snake spots
            fill(255, 255, 51);
            rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);
          }
        }
      }
    }
    fill(255);
    textSize(30);
    text("Length: " + snakeCells.size(), 10, 30);
  } else {
    textSize(50);
    fill(255);
    text("Game Over!", 10, 150);
    text("Press Enter to play again!", 10, 250);
  }
}

//If the game is over 
boolean gameOver() {
  boolean die = false;
  for (Cell cell : snakeCells) {
    if (cell.x >= 40 || cell.y >= 20 || cell.x < 0 || cell.y < 0) {
      die = true;
      break;
    }
  }

  if (!die) {
    for (int i = 1; i < snakeCells.size(); i++) {
      if (snakeCells.get(0).x == snakeCells.get(i).x && snakeCells.get(0).y == snakeCells.get(i).y) {
        die = true;
      }
    }
  }
  return die;
}

void keyPressed() {
  if (keyCode == UP) {
    up = true;
    down = false;
    left = false;
    right = false;
  } else if (keyCode == DOWN) {
    up = false;
    down = true;
    left = false;
    right = false;
  } else if (keyCode == LEFT) {
    up = false;
    down = false;
    left = true;
    right = false;
  } else if (keyCode == RIGHT) {
    up = false;
    down = false;
    left = false;
    right = true;
  } else if (keyCode == ENTER && gameOver()) {
    setup();
  }
}

void updateGame() {
  if (up) {
    Cell nextCell = new Cell(snakeCells.get(0).x, snakeCells.get(0).y-1);
    snakeCells.add(0, nextCell);
    snakeCells.remove(snakeCells.size() - 1);
  } else if (down) {
    Cell nextCell = new Cell(snakeCells.get(0).x, snakeCells.get(0).y+1);
    snakeCells.add(0, nextCell);
    snakeCells.remove(snakeCells.size() - 1);
  } else if (left) {
    Cell nextCell = new Cell(snakeCells.get(0).x-1, snakeCells.get(0).y);
    snakeCells.add(0, nextCell);
    snakeCells.remove(snakeCells.size() - 1);
  } else if (right) {
    Cell nextCell = new Cell(snakeCells.get(0).x+1, snakeCells.get(0).y);
    snakeCells.add(0, nextCell);
    snakeCells.remove(snakeCells.size() - 1);
  }

  if (snakeCells.get(0).x == food.x && snakeCells.get(0).y == food.y) {
    if (up) {
      snakeCells.add(new Cell(food.x, food.y+1));
      snakeCells.add(new Cell(food.x, food.y+2));
    } else if (down) {
      snakeCells.add(new Cell(food.x, food.y-1));
      snakeCells.add(new Cell(food.x, food.y-2));
    } else if (left) {
      snakeCells.add(new Cell(food.x+1, food.y));
      snakeCells.add(new Cell(food.x+2, food.y));
    } else if (right) {
      snakeCells.add(new Cell(food.x-1, food.y));
      snakeCells.add(new Cell(food.x-2, food.y));
    }
    while (foodOverlap()) {
      food = new Cell((int)random(0, 40), (int)random(0, 19));
    }
  }
}

//If snake ran into itself
boolean foodOverlap() {
  for (Cell cell : snakeCells) {
    if (cell.x == food.x && cell.y == food.y) {
      return true;
    }
  }
  return false;
}
