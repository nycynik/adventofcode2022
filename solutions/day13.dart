import 'dart:convert';
import 'dart:math';
import '../utils/index.dart';

class Day13 extends GenericDay {
  Day13() : super(13);

  @override
  List parseInput() {
    return input.getBy('\n\n');
//     return """[1,1,3,1,1]
// [1,1,5,1,1]

// [[1],[2,3,4]]
// [[1],4]

// [9]
// [[8,7,6]]

// [[4,4],4,4]
// [[4,4],4,4,4]

// [7,7,7,7]
// [7,7,7]

// []
// [3]

// [[[]]]
// [[]]

// [1,[2,[3,[4,[5,6,7]]]],8,9]
// [1,[2,[3,[4,[5,6,0]]]],8,9]"""
//         .split('\n\n');
  }

// returns true if they are in the right order (left side is smaller)
  int comparePair(left, right) {
    if ((left is List) && (right is List)) {
      int? minLen = min([left.length, right.length]);
      for (var x = 0; x < minLen!; x++) {
        // if (right.length <= x) return 1; // right ran out
        var check = comparePair(left[x], right[x]);
        if (check == -1) return -1;
        if (check == 1) return 1;
      }
      if (left.length > right.length) return -1;
      if (left.length < right.length) return 1;
      return 0;
    } else
    // mixed type
    if (right is List) {
      return comparePair([left], right);
    } else if (left is List) {
      return comparePair(left, [right]);
    } else if ((left is int) && (right is int)) {
      if (left > right) return -1;
      if (left < right) return 1;
      return 0;
    }

    print('equal');
    return 0;
  }

  @override
  int solvePart1() {
    var pairs = parseInput();

    int countOrdered = 0;
    for (var x = 0; x < pairs.length; x++) {
      var splitPair = pairs[x].split('\n');
      final left = jsonDecode(splitPair[0]);
      final right = jsonDecode(splitPair[1]);

      var isOrdered = comparePair(left, right);
      if (isOrdered == 1) countOrdered += (x + 1);
      // print("${x + 1} : $isOrdered");
    }
    return countOrdered;
  }

  @override
  int solvePart2() {
    var pairs2 = parseInput();
    pairs2.add('[[6]]\n[[2]]');
    var allLines = [];

    for (var x = 0; x < pairs2.length; x++) {
      var splitPair = pairs2[x].split('\n');
      final left = jsonDecode(splitPair[0]);
      final right = jsonDecode(splitPair[1]);
      allLines.add(left);
      allLines.add(right);
    }

    allLines.sort(comparePair);
    int output = 1;
    for (int x = allLines.length - 1; x >= 0; x--) {
      if (allLines[x].toString() == '[[6]]' ||
          allLines[x].toString() == '[[2]]') {
        output *= allLines.length - x;
      }
    }
    // print(allLines.reversed);
    return output;
  }
}
