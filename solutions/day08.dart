import '../utils/index.dart';

class Grid {
  var grid = [];
  var visGrid = [];

  getRows() {
    return grid.length;
  }

  getCols() {
    return grid[0].length;
  }

  addRow(row) {
    grid.add(row);
    var vizGrid = [];
    for (var x = 0; x < row.length; x++) {
      vizGrid.add(4);
    }
    visGrid.add(vizGrid);
  }

  printRow(row) {
    print("grid: ${grid[row]}");
    print("viz : ${visGrid[row]}");
  }

  inBounds(row, col) {
    var inBounds = true;
    if (row < 0 || col < 0 || row >= grid.length || col >= grid[0].length) {
      return false;
    }
    return inBounds;
  }

  checkVisible(row, col) {
    var treeHeight = grid[row][col];
    var visDirs = 0;

    var dirs = [
      [0, 1],
      [1, 0],
      [0, -1],
      [-1, 0]
    ];

    for (var d in dirs) {
      var dirBlocked = false;

      for (var x = 1; x < 5000; x++) {
        if (inBounds(row + (x * d[0]), col + (x * d[1]))) {
          if (grid[row + (x * d[0])][col + (x * d[1])] >= treeHeight) {
            dirBlocked = true;
            print(
                "blocked ${grid[row + (x * d[0])][col + (x * d[1])]} >= $treeHeight");
            break;
          }
        }
      }

      if (!dirBlocked) {
        visDirs += 1;
      }
    }

    visGrid[row][col] = visDirs;

    return visDirs > 0;
  }

  getScenicScore(row, col) {
    var scores = [0, 0, 0, 0];
    var treeHeight = grid[row][col];

    var dirs = [
      [0, 1],
      [1, 0],
      [0, -1],
      [-1, 0]
    ];
    var dIdx = 0;

    for (var d in dirs) {
      for (var x = 1; x < 5000; x++) {
        if (inBounds(row + (x * d[0]), col + (x * d[1]))) {
          if (grid[row + (x * d[0])][col + (x * d[1])] >= treeHeight) {
            scores[dIdx]++;
            break;
          } else {
            scores[dIdx]++;
          }
        }
      }
      dIdx++;
    }
    if (scores[0] * scores[1] * scores[2] * scores[3] > 0) print(scores);
    return scores[0] * scores[1] * scores[2] * scores[3];
  }

  setVisible(row, col) {}
}

class Day08 extends GenericDay {
  var grid = new Grid();

  Day08() : super(8);

  @override
  parseInput() {
    var lines = input.getPerLine();
    lines.forEach((element) {
      var gridLine = element.split('').map(int.parse).toList();

      grid.addRow(gridLine);
    });
  }

  @override
  int solvePart1() {
    parseInput();

    print("size: ${grid.getRows()} rows X ${grid.getCols()} cols");

    // find visible trees.
    var totalVisibleTrees = 0;
    for (var row = 0; row < grid.getRows(); row++) {
      for (var col = 0; col < grid.getCols(); col++) {
        if (row == 0 ||
            col == 0 ||
            row == grid.getRows() - 1 ||
            col == grid.getCols() - 1) {
          totalVisibleTrees++;
        } else {
          // not an edge, so figure it out.
          if (grid.checkVisible(row, col)) {
            totalVisibleTrees++;
          }
        }
      }
    }
    grid.printRow(0);
    print('\n');
    grid.printRow(1);
    print('\n');

    return totalVisibleTrees;
  }

  @override
  int solvePart2() {
    var maxScore = 0;

    for (var row = 0; row < grid.getRows(); row++) {
      for (var col = 0; col < grid.getCols(); col++) {
        var sc = grid.getScenicScore(row, col);
        if (sc > maxScore) {
          maxScore = sc;
        }
      }
    }

    print(grid.getScenicScore(29, 46));

    return maxScore;
  }
}
