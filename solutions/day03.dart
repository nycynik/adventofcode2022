import '../utils/index.dart';

class Day03 extends GenericDay {
  List sacks = [];

  Day03() : super(3);

  @override
  parseInput() {
    var test = '''vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw''';
    // var lines = test.split("\n");

    var lines = input.getPerLine();

    lines.forEach((element) {
      int elSplit = element.length ~/ 2;
      this.sacks.add([
        element.substring(0, elSplit).trim().split(''),
        element.substring(elSplit).trim().split('')
      ]);
    });
  }

  @override
  int solvePart1() {
    parseInput();

    List matching = [];
    sacks.forEach((element) {
      matching.add(findMatching(element).first);
    });

    num sum = 0;
    matching.forEach((element) {
      sum += element;
    });

    return sum.toInt();
  }

  @override
  int solvePart2() {
    int sackIndex = 0;
    num totalOfMatches = 0;

    while (sackIndex < sacks.length) {
      var combinedSacks = [
        (sacks[sackIndex][0] + sacks[sackIndex][1]),
        (sacks[sackIndex + 1][0] + sacks[sackIndex + 1][1]),
        (sacks[sackIndex + 2][0] + sacks[sackIndex + 2][1])
      ];

      var matchesFirst =
          findMatchingLetters([combinedSacks[0], combinedSacks[1]]);
      var matches = findMatching([matchesFirst, combinedSacks[2]]);

      totalOfMatches += matches.first;
      sackIndex += 3;
    }

    return totalOfMatches.toInt();
  }

  List<String> findMatchingLetters(element) {
    List<String> matched = [];

    element[0].forEach((el) {
      if (element[1].contains(el)) {
        var code = (el.codeUnitAt(0) - 'a'.codeUnitAt(0)) + 1;
        if (code < 0) {
          code = (el.codeUnitAt(0) - 'A'.codeUnitAt(0)) + 27; // 1 + 27
        }
        if (!matched.contains(el)) matched.add(el);
      }
    });

    return matched;
  }

  List<int> findMatching(element) {
    List<int> matched = [];

    element[0].forEach((el) {
      if (element[1].contains(el)) {
        var code = (el.codeUnitAt(0) - 'a'.codeUnitAt(0)) + 1;
        if (code < 0) {
          code = (el.codeUnitAt(0) - 'A'.codeUnitAt(0)) + 27; // 1 + 27
        }
        if (!matched.contains(code)) matched.add(code);
      }
    });

    return matched;
  }
}
