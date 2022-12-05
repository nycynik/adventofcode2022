import '../utils/index.dart';

class Crates {
  /*
        [H]         [H]         [V]    
        [V]         [V] [J]     [F] [F]
        [S] [L]     [M] [B]     [L] [J]
        [C] [N] [B] [W] [D]     [D] [M]
    [G] [L] [M] [S] [S] [C]     [T] [V]
    [P] [B] [B] [P] [Q] [S] [L] [H] [B]
    [N] [J] [D] [V] [C] [Q] [Q] [M] [P]
    [R] [T] [T] [R] [G] [W] [F] [W] [L]
    1   2   3   4   5   6   7   8   9 
  */
  List stacks = [
    ['R', 'N', 'P', 'G'],
    ['T', 'J', 'B', 'L', 'C', 'S', 'V', 'H'],
    ['T', 'D', 'B', 'M', 'N', 'L'],
    ['R', 'V', 'P', 'S', 'B'],
    ['G', 'C', 'Q', 'S', 'W', 'M', 'V', 'H'],
    ['W', 'Q', 'S', 'C', 'D', 'B', 'J'],
    ['F', 'Q', 'L'],
    ['W', 'M', 'H', 'T', 'D', 'L', 'F', 'V'],
    ['L', 'P', 'B', 'V', 'M', 'J', 'F']
  ];

  List stacks2 = [
    ['R', 'N', 'P', 'G'],
    ['T', 'J', 'B', 'L', 'C', 'S', 'V', 'H'],
    ['T', 'D', 'B', 'M', 'N', 'L'],
    ['R', 'V', 'P', 'S', 'B'],
    ['G', 'C', 'Q', 'S', 'W', 'M', 'V', 'H'],
    ['W', 'Q', 'S', 'C', 'D', 'B', 'J'],
    ['F', 'Q', 'L'],
    ['W', 'M', 'H', 'T', 'D', 'L', 'F', 'V'],
    ['L', 'P', 'B', 'V', 'M', 'J', 'F']
  ];
  getJustLastCrates() {
    String msg = '';
    stacks.forEach((element) {
      msg += element[element.length - 1];
    });
    return msg;
  }

  printCrates() {
    print('\nStacks:');
    stacks.forEach((stack) {
      print(stack);
    });
  }

  moveMultipleCrates(howmany, from, to) {
    List tempStack = [];
    for (var x = howmany; x > 0; x--) {
      tempStack.add(stacks[from].removeLast());
    }
    tempStack.reversed.forEach((element) {
      stacks[to].add(element);
    });
  }

  moveCrates(howmany, from, to) {
    for (var x = howmany; x > 0; x--) {
      stacks[to].add(stacks[from].removeLast());
    }
  }
}

class Day05 extends GenericDay {
  Crates c = new Crates();
  var moves = [];

  Day05() : super(5);

  @override
  parseInput() {
    var lines = input.getPerLine();
    lines.forEach((element) {
      print(element);
      // move 3 from 3 to 7
      var moveData = element.substring(5).split(' ');
      moves.add([
        int.parse(moveData[0]),
        int.parse(moveData[2]) - 1,
        int.parse(moveData[4]) - 1
      ]);
    });
  }

  @override
  int solvePart1() {
    parseInput();
    c.printCrates();
    moves.forEach((move) {
      c.moveCrates(move[0], move[1], move[2]);
      c.printCrates();
    });
    print(c.getJustLastCrates());

    return 0;
  }

  @override
  int solvePart2() {
    c.stacks = c.stacks2;

    c.printCrates();
    moves.forEach((move) {
      c.moveMultipleCrates(move[0], move[1], move[2]);
      c.printCrates();
    });

    print(c.getJustLastCrates());

    return 0;
  }
}
