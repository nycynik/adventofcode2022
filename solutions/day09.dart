import 'dart:collection';
import 'dart:math';
import '../utils/index.dart';

class Day09 extends GenericDay {
  var moves = [];
  Map<String, List<int>> directions = {
    'L': [0, -1],
    'R': [0, 1],
    'U': [1, 0],
    'D': [-1, 0],
  };

  Day09() : super(9);

  @override
  parseInput() {
    moves = input.getPerLine();
//     moves = '''R 4
// U 4
// L 3
// D 1
// R 4
// D 1
// L 5
// R 2'''
//         .split('\n');
  }

  String convertPointToString(List<int> point) {
    return "r${point[0]}c${point[1]}";
  }

  @override
  int solvePart1() {
    parseInput();

    var rope = [
      [0, 0],
      [0, 0]
    ];
    var headPos = [0, 0];
    var tailPos = [0, 0];
    var visited = new Set();

    visited.add(convertPointToString(tailPos));

    print(' == Initial == ');
    print(
        'head: ${convertPointToString(headPos)} tail: ${convertPointToString(tailPos)} count: ${visited.length}');

    moves.forEach((element) {
      // print(' == $element == ');
      var move = element.split(' ');
      var dir = directions[move[0]];
      var times = int.parse(move[1]);

      if (dir != null) {
        for (var x = 0; x < times; x++) {
          headPos[0] += dir[0];
          headPos[1] += dir[1];

          // find new tail position
          var rowDist = headPos[0] - tailPos[0];
          var colDist = headPos[1] - tailPos[1];
          var distance = sqrt(rowDist * rowDist + colDist * colDist);
          if (distance > 1.5) {
            var change = [0, 0];
            if (rowDist > 0) {
              change[0] = 1;
            } else if (rowDist < 0) {
              change[0] = -1;
            }
            if (colDist > 0) {
              change[1] = 1;
            } else if (colDist < 0) {
              change[1] = -1;
            }
            tailPos[0] += change[0];
            tailPos[1] += change[1];
          }

          visited.add(convertPointToString(tailPos));

          // print(
          //     "head: ${convertPointToString(headPos)} tail: ${convertPointToString(tailPos)} count: ${visited.length}");
        }
      }
    });

    return visited.length;
  }

  @override
  int solvePart2() {
    var rope = [
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0],
      [0, 0]
    ]; // 0th head, last tail
    var visited = new Set();

    visited.add(convertPointToString(rope[rope.length - 1]));

    print(' == Initial == ');
    print(
        "head: ${convertPointToString(rope[0])} tail: ${convertPointToString(rope[rope.length - 1])} count: ${visited.length}");

    moves.forEach((element) {
      // print(' == $element == ');
      var move = element.split(' ');
      var dir = directions[move[0]];
      var times = int.parse(move[1]);

      if (dir != null) {
        for (var x = 0; x < times; x++) {
          rope[0][0] += dir[0];
          rope[0][1] += dir[1];
          for (var segments = 1; segments < rope.length; segments++) {
            // find new tail position
            var rowDist = rope[segments - 1][0] - rope[segments][0];
            var colDist = rope[segments - 1][1] - rope[segments][1];
            var distance = sqrt(rowDist * rowDist + colDist * colDist);
            if (distance > 1.5) {
              var change = [0, 0];
              if (rowDist > 0) {
                change[0] = 1;
              } else if (rowDist < 0) {
                change[0] = -1;
              }
              if (colDist > 0) {
                change[1] = 1;
              } else if (colDist < 0) {
                change[1] = -1;
              }
              rope[segments][0] += change[0];
              rope[segments][1] += change[1];
            }

            visited.add(convertPointToString(rope[rope.length - 1]));

            // print(
            //     "head: ${convertPointToString(rope[0])} tail: ${convertPointToString(rope[rope.length - 1])} count: ${visited.length}");
          }
        }
      }
    });

    return visited.length;
  }
}
