import '../utils/index.dart';

class Day06 extends GenericDay {
  var line = "";

  Day06() : super(6);

  @override
  parseInput() {
    line = input.asString;
    //line = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"; // 7 and 19
  }

  @override
  int solvePart1() {
    parseInput();

    var index = 0;
    while (index < line.length) {
      var nextFour = line.substring(index, index + 4);
      var four = nextFour.split("").toSet();
      if (four.length == 4) {
        return index + 4;
      }
      index++;
    }

    return 0;
  }

  @override
  int solvePart2() {
    var index = 0;

    while (index < line.length) {
      var nextFourteen = line.substring(index, index + 14);
      var four = nextFourteen.split("").toSet();
      if (four.length == 14) {
        return index + 14;
      }
      index++;
    }

    return 0;
  }
}
