import '../utils/index.dart';

class Monkey {
  String name = '';
  num monkeyNum = 0;
  List<BigInt> items = [];
  String operation = '';
  BigInt operationAmount = BigInt.from(0);
  BigInt testDiv = BigInt.from(0);
  List<int> throwTo = [-1, -1]; // true, false
  int inspectionCount = 0;

  Monkey(String name) {
    this.name = name;
    this.monkeyNum = int.parse(name.substring(7).replaceAll('\:', ''));
  }

  addItems(String startitems) {
    //   Starting items: 54, 65, 75, 74
    items = startitems
        .replaceAll(',', '')
        .substring(18)
        .split(' ')
        .map(BigInt.parse)
        .toList();
  }

  addItem(BigInt item) {
    items.add(item);
  }

  addOperation(String oper) {
    List<String> o = oper.substring(23).split(' ');

    if (o[1] == 'old') {
      operation = o[0] + o[1];
    } else {
      operation = o[0];
      operationAmount = BigInt.parse(o[1]);
    }
  }

  addTest(String e) {
    var t = e.substring(8).split(' ');
    this.testDiv = BigInt.parse(t[2]);
  }

  addTrue(String e) {
    var t = e.substring(13).split(' ');
    this.throwTo[0] = int.parse(t[3]);
  }

  addFalse(String e) {
    var t = e.substring(14).split(' ');
    this.throwTo[1] = int.parse(t[3]);
  }

  // functions
  BigInt doInspections(monkeys, {verbose = true}) {
    BigInt newLevel = BigInt.from(0);

    if (verbose) print('\n${this.name}');

    int totalItems = this.items.length;
    for (var x = 0; x < totalItems; x++) {
      this.inspectionCount++;
      BigInt i = this.items.removeAt(0);
      if (verbose) print('  Monkey inspects an item with a worry level of $i');

      var operation = this.operation;
      newLevel = i;
      switch (operation) {
        case '+':
          newLevel += this.operationAmount;
          break;
        case '*':
          newLevel *= this.operationAmount;
          break;
        case '+old':
          newLevel += i;
          break;
        case '*old':
          newLevel *= i;
          break;
        default:
          print(operation);
          break;
      }
      if (newLevel.isNegative) verbose = true;
      if (verbose)
        print(
            '    Worry level is ${operation} by ${this.operationAmount} to ${newLevel}.');

      // bored
      // newLevel = (newLevel ~/ BigInt.from(3));
      if (verbose)
        print(
            '    Monkey gets bored with item. Worry level is divided by 3 to $newLevel.');

      // test
      var isNot = '';
      var throwTo = 0;
      // this.testDiv
      var dTest = false;
      if (newLevel < BigInt.from(96577)) {
        dTest = (newLevel % this.testDiv == BigInt.from(0));
      } else {
        dTest = (newLevel % BigInt.from(96577) == BigInt.from(0));
      }
      if (dTest) {
        throwTo = this.throwTo[0];
      } else {
        isNot = 'not ';
        throwTo = this.throwTo[1];
      }
      monkeys[throwTo].addItem(newLevel);
      if (verbose)
        print(
            '    Current worry level is ${isNot}divisible by ${this.testDiv}.');

      // and based on test, throw
      if (verbose)
        print(
            '    Item with worry level ${newLevel} is thrown to monkey ${throwTo}.');
      if (newLevel.isNegative) throw (0);
    }

    return newLevel;
  }

  // strings
  String toString() {
    var items = this.items.toString().substring(1).replaceAll(']', '');
    return 'Monkey ${this.monkeyNum} (${this.inspectionCount}): $items';
  }

  String toFullString() {
    var items = this.items.toString().substring(1).replaceAll(']', '');
    return 'Monkey ${this.monkeyNum} (${this.inspectionCount}): $items\n . test: Div by ${this.testDiv}\n . Throw (T/F): ${throwTo}\n\n';
  }

  String showInspectionCounts() {
    return 'Monkey ${this.monkeyNum} inspected items ${this.inspectionCount} times.';
  }
}

// =-======= =-======= =-======= =-======= =-======= =-======= =-======= =-======= =-======= =-=======
class Day11 extends GenericDay {
  var monkeys = [];

  Day11() : super(11);

  @override
  parseInput() {
    // var lines = input.getPerLine();
    var lines = '''Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1'''
        .trim()
        .split('\n');

    lines.add(''); // makes processing easier.

    var monkey;
    var index = 0;
    lines.forEach((element) {
      if (element.trim() == '') {
        // next monkey
        index = 0;
        monkeys.add(monkey);
        monkey = null;
      } else {
        // continuing or starting monkey (this should just build a string array of lines and pass to moneky, but I'm not going to do that here for speed.)
        switch (index) {
          case 0: // name
            monkey = new Monkey(element);
            break;
          case 1: // items
            monkey.addItems(element);
            break;
          case 2: // Operation
            monkey.addOperation(element);
            break;
          case 3: // test
            monkey.addTest(element);
            break;
          case 4: // true
            monkey.addTrue(element);
            break;
          case 5: // false
            monkey.addFalse(element);
            break;
        }
        index++;
      }
    });
  }

  @override
  int solvePart1() {
    parseInput();
    monkeys.forEach((element) {
      print(element.toFullString());
    });

    // var modulo = monkeys.fold<int>(
    //     1, (int total, Monkey element) => int.parse(total! * element.testDiv));
    BigInt modulo = BigInt.from(1);
    monkeys.forEach((element) {
      modulo *= element.testDiv;
    });
    print(modulo);

    // do rounds
    List<int> maxMonkeyBiz = [0, 0];
    for (var x = 1; x < 10001; x++) {
      if (x == 1 || x == 20 || x % 1000 == 0) print("\nRound $x");
      monkeys.forEach((m) {
        m.doInspections(monkeys, verbose: false);
      });

      if (x == 1 || x == 20 || x % 1000 == 0) {
        for (Monkey m in monkeys) {
          print(m.showInspectionCounts());
        }
      }
    }

    for (Monkey m in monkeys) {
      print(m.showInspectionCounts());
      maxMonkeyBiz.add(m.inspectionCount);
      maxMonkeyBiz.sort((a, b) => b - a);
      maxMonkeyBiz.removeLast();
    }

    print(maxMonkeyBiz);
    return maxMonkeyBiz[0] * maxMonkeyBiz[1];
  }

  @override
  int solvePart2() {
    return 0;
  }
}
