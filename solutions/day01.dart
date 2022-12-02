import 'dart:ffi';

import '../utils/index.dart';

class Day01 extends GenericDay {
  List elves = [];

  Day01() : super(1);

  @override
  parseInput() {
    print("parse called");

    var calories = input.getPerLine();
    var caloriesPerElf = 0;

    for (var x = 0; x < calories.length; x++) {
      if (calories[x].trim() == '') {
        elves.add(caloriesPerElf);
        caloriesPerElf = 0;
      } else {
        caloriesPerElf += int.parse(calories[x]);
      }
    }
    elves.sort();

  }

  @override
  int solvePart1() {
    parseInput();

    return this.elves[elves.length - 1];
  }

  @override
  int solvePart2() {
    return this.elves[elves.length - 1] +
        this.elves[elves.length - 2] +
        this.elves[elves.length - 3];
  }
}
