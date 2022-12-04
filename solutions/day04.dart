import '../utils/index.dart';

class Day04 extends GenericDay {
  List lines = [];

  Day04() : super(4);

  @override
  parseInput() {
    var test = '''2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
6-9,9-10
6-9,7-8
6-9,7-11
2-3,3-3
6-9,6-6
6-9,7-7
14-90,13-89
2-4,3-3''';
    lines = test.split('\n');
    lines = input.getPerLine();
  }

  bool checkForOverlap(pairs) {
    bool overlaps = false;

    List group1 = pairs[0].split('-').map(int.parse).toList();
    List group2 = pairs[1].split('-').map(int.parse).toList();

    if ((group1[0] == group2[0]) ||
        (group1[0] > group2[0] && group2[1] >= group1[0]) ||
        (group1[0] < group2[0] && group2[0] <= group1[1])) {
      overlaps = true;
    }

    return overlaps;
  }

  bool checkForEnclosed(pairs) {
    bool enclosed = false;

    List group1 = pairs[0].split('-').map(int.parse).toList();
    List group2 = pairs[1].split('-').map(int.parse).toList();

    if ((group1[0] >= group2[0] && group1[1] <= group2[1]) ||
        (group2[0] >= group1[0] && group2[1] <= group1[1])) {
      enclosed = true;
    }
    return enclosed;
  }

  @override
  int solvePart1() {
    parseInput();

    var totalEnclosed = 0;

    lines.forEach((element) {
      if (checkForEnclosed(element.split(','))) {
        totalEnclosed += 1;
      }
    });
    return totalEnclosed;
  }

  @override
  int solvePart2() {
    var totalOverlapping = 0;

    lines.forEach((element) {
      if (checkForOverlap(element.split(','))) {
        totalOverlapping += 1;
      }
    });

    return totalOverlapping;
  }
}
