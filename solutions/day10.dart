import '../utils/index.dart';

class Day10 extends GenericDay {
  var lines;
  int cycles = 0;
  int xRegister = 0;
  int cycleCheck = 20;
  List<int> twenties = [];
  var message = [[], [], [], [], [], [], []];
  int messageRow = 0;

  Day10() : super(10);

  @override
  parseInput() {
    lines = input.getPerLine();
//     lines = '''addx 15
// addx -11
// addx 6
// addx -3
// addx 5
// addx -1
// addx -8
// addx 13
// addx 4
// noop
// addx -1
// addx 5
// addx -1
// addx 5
// addx -1
// addx 5
// addx -1'''
//         .trim()
//         .split('\n');
  }

  increaseCycle() {
    cycles++;
    if (cycles == cycleCheck) {
      int curSignal = cycles * xRegister;
      print('Cycle: $cycles - Reg: $xRegister = $curSignal');
      twenties.add(curSignal);
      cycleCheck += 40;
    }
    // draw
    if (cycles > xRegister - 1 && cycles < xRegister + 1) {
      message[messageRow].add('#');
    } else {
      message[messageRow].add('.');
    }
    if (cycles % 40 == 0) {
      message.forEach((m) {
        print(m);
      });
      messageRow++;
    }
  }

  @override
  int solvePart1() {
    parseInput();

    xRegister = 1;
    cycles = 0;
    twenties = [];

    lines.forEach((element) {
      List cmd = element.split(' ');
      if (cmd.length == 2) {
        // not a noop
        increaseCycle(); // cause it takes two cycles
        increaseCycle();
        xRegister += int.parse(cmd[1]);
      } else
        increaseCycle();
    });
    return twenties.sum;
  }

  @override
  int solvePart2() {
    var message = [];

    xRegister = 1;
    cycles = 0;
    twenties = [];

    lines.forEach((element) {
      List cmd = element.split(' ');
      if (cmd.length == 2) {
        // not a noop
        increaseCycle(); // cause it takes two cycles
        increaseCycle();
        xRegister += int.parse(cmd[1]);
      } else
        increaseCycle();
    });
    print(message);
    return twenties.sum;
  }
}

// ###   ##  ###  ###  #  #  ##  ###    ##
// #  # #  # #  # #  # # #  #  # #  #    #
// #  # #    #  # ###  ##   #  # #  #    #
// ###  #    ###  #  # # #  #### ###     #
// #    #  # #    #  # # #  #  # #    #  #
// #     ##  #    ###  #  # #  # #     ##

// ########################################
// ###   ##  ###  ###  #  #  ##  ###    ## 
// #  # #  # #  # #  # # #  #  # #  #    # 
// #  # #    #  # ###  ##   #  # #  #    # 
// ###  #    ###  #  # # #  #### ###     # 
// #    #  # #    #  # # #  #  # #    #  # 
// #     ##  #    ###  #  # #  # #     ##    