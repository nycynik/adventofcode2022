import '../utils/index.dart';

class Day14 extends GenericDay {
  Day14() : super(14);

  @override
  List<List<Position>> parseInput() {
    final lines = input.getPerLine();
//     var lines = """498,4 -> 498,6 -> 496,6
// 503,4 -> 502,4 -> 502,9 -> 494,9""".split('\n');

    final List<List<Position>> rockChains = [];
    final rocks = lines.map((line) => line.trim().split(' -> ')).toList();
    rocks.forEach((vein) {
      var positions = vein.map((p) {
        var tp = p.split(',').map(int.parse).toList();
        return Position(tp[0], tp[1]);
      }).toList();
      rockChains.add(positions);
    });

    return rockChains;
  }

  @override
  int solvePart1() {
    List<List<Position>> rocks = parseInput();

    final allRocks = rocks.expand((x) => x).toList(); 

    Position minPosition =Position(10000, 10000);
    Position maxPosition = Position(-1, -1);
    allRocks.forEach((el) { 
      if (el.x<minPosition.x) minPosition = Position(el.x-1, minPosition.y);
      if (el.y<minPosition.y) minPosition = Position(minPosition.x, 0); // el.y);

      if (el.x>maxPosition.x) maxPosition = Position(el.x+1, maxPosition.y);
      if (el.y>maxPosition.y) maxPosition = Position(maxPosition.x, el.y);

    });
    print(minPosition);
    print(maxPosition);

    List<List> matrix = [];
    for (var row =0; row < maxPosition.y+2; row++) {
      var row = [];
      for (var col = minPosition.x-1; col < maxPosition.x+1; col++) {
        row.add('.');
      }
      matrix.add(row);
    }
    Field field = Field(matrix);

    // add rocks to field.
    rocks.forEach((rockchain) {

      for (var j=0; j<rockchain.length-1; j++) {
        Position start = Position(rockchain[j].x - minPosition.x, rockchain[j].y - minPosition.y);
        Position end = Position(rockchain[j+1].x - minPosition.x, rockchain[j+1].y - minPosition.y);
        int diffx=(end.x - start.x);
        int diffy=(end.y - start.y);
        if (diffx<0 || diffy<0) {
          var t = start;
          start = end;
          end = t; 
        }
        // print ("line from $start to $end ($diffx to $diffy)");
        for (var rx=start.x; rx<=end.x; rx++) {
        for (var ry=start.y; ry<=end.y; ry++) {
          field.setValueAtPosition(Position(rx, ry), '#');
        }
        }
      }
    });
      rocks.forEach((chain) {
        chain.forEach((el) {
        field.setValueAtPosition(Position(el.x - minPosition.x, el.y), '#');
      });
      });

    print(field); 

    // drop sand.
    var sandDropped = 0;
    bool fellOff = false;
    Position start = Position(500 - minPosition.x, 0);
    while (fellOff == false) {
      // print(start);
      if (start.y >maxPosition.y) {
        fellOff = true;
        break;
      }
      var underSand = field.getValueAtPosition(start);
      var underSandNext = field.getValueAtPosition(Position(start.x, start.y+1));
      switch (underSandNext) {
        case '.': {
          // keep dropping
          start = Position(start.x, start.y+1);
        }
        break;
        case '#': 
        case 'o':
        {
          // move left, if that is NG, move right, ng, it's over.
          var left = Position(start.x-1, start.y+1);
          var right = Position(start.x+1, start.y+1);
          if (field.getValueAtPosition(left) == '.') {
            // keep dropping.
            start = left;
          } else if (field.getValueAtPosition(right) == '.') {
            // keep dropping.
            start = right;
          } else {
            field.setValueAtPosition(start, 'o');
            start = Position(500 - minPosition.x, 0); // restart sand.
            sandDropped++;
          }
        
        
        } 
      }
    }
        print(field); 

    return sandDropped;
  }

  @override
  int solvePart2() {

    List<List<Position>> rocks = parseInput();

    final allRocks = rocks.expand((x) => x).toList(); 

    // Find Min/Max
    Position minPosition =Position(10000, 10000);
    Position maxPosition = Position(-1, -1);
    allRocks.forEach((el) { 
      if (el.x<minPosition.x) minPosition = Position(el.x-1, minPosition.y);
      if (el.y<minPosition.y) minPosition = Position(minPosition.x, 0); // el.y);

      if (el.x>maxPosition.x) maxPosition = Position(el.x+1, maxPosition.y);
      if (el.y>maxPosition.y) maxPosition = Position(maxPosition.x, el.y);

     });
    print(minPosition);
    print(maxPosition);

    // add rocks to field.
    Map<Position, String> SonarMap = {};
    rocks.forEach((rockchain) {

      for (var j=0; j<rockchain.length-1; j++) {
        Position start = Position(rockchain[j].x - minPosition.x, rockchain[j].y - minPosition.y);
        Position end = Position(rockchain[j+1].x - minPosition.x, rockchain[j+1].y - minPosition.y);
        int diffx=(end.x - start.x);
        int diffy=(end.y - start.y);
        if (diffx<0 || diffy<0) {
          var t = start;
          start = end;
          end = t; 
        }
        // print ("line from $start to $end ($diffx to $diffy)");
        for (var rx=start.x; rx<=end.x; rx++) {
          for (var ry=start.y; ry<=end.y; ry++) {
            SonarMap[Position(rx, ry)] = '#';
          }
        }
      }
    });

    // start to drop sand.
    var sandDropped = 0;
    bool fellOff = false;
    Position start = Position(500 - minPosition.x, 0);
    while (fellOff == false) {

      var underSand = SonarMap.valueAtPosition(start);
      var underSandNext = '!';
      if (start.y+1 < (maxPosition.y+2)) 
        underSandNext = SonarMap.valueAtPosition(Position(start.x, start.y+1));

      switch (underSandNext) {
        case '.': {
          // keep dropping
          start = Position(start.x, start.y+1);
        }
        break;
        case '!': {
            SonarMap[start] = 'o';
            start = Position(500 - minPosition.x, 0); // restart sand.
            sandDropped++;
        }
        break;
        case '#': 
        case 'o':
        {
          // move left, if that is NG, move right, ng, it's over.
          var left = Position(start.x-1, start.y+1);
          var right = Position(start.x+1, start.y+1);
          if (SonarMap.valueAtPosition(left) == '.') {
            // keep dropping.
            start = left;
          } else if (SonarMap.valueAtPosition(right) == '.') {
            // keep dropping.
            start = right;
          } else {
            SonarMap[start] = 'o';
            sandDropped++;

            if ((sandDropped>10) && (start == Position(500 - minPosition.x, 0))) {
              fellOff = true;
              print('QUIT');
            }

            start = Position(500 - minPosition.x, 0); // restart sand.
          }
        
        
        } 
      }
    }
        
    return sandDropped;
  }
}

extension on Map<Position, String> {
  String valueAtPosition(Position from) {
    if (!this.containsKey(from)) {
      this[from] = '.';
    } 
    return this[from]!;
  }
}