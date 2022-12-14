import '../utils/index.dart';
import 'package:dijkstra/dijkstra.dart';

class Day12 extends GenericDay {
  Day12() : super(12);

  @override
  Field<String> parseInput() {
    final lines = input.getPerLine();
//     final lines = """Sabqponm
// abcryxxl
// accszExk
// acctuvwj
// abdefghi"""
//         .split('\n');
    final parts = lines.map((line) => line.trim().split('')).toList();
    return Field(parts);
  }

  @override
  int solvePart1() {
    final field = parseInput();

    Position start = Position(0, 0);
    Position end = Position(0, 0);
    final graph = Map<Position, Map<Position, int>>();
    final List starts = [];

    field.forEach((x, y) {
      final thisPosValue = field.getValueAtPosition(Position(x, y));
      if (thisPosValue == 'S') {
        start = Position(x, y);
      }
      if (thisPosValue == 'E') {
        end = Position(x, y);
      }
      if (thisPosValue == 'a') {
        starts.add(Position(x, y));
      }

      // make graph from connections
      final adj = field.adjacent(x, y);
      adj.forEach((pos) {
        var val = field.getValueAtPosition(pos);

        if (((thisPosValue == 'z') && (field.getValueAtPosition(pos) == 'E')) ||
            (thisPosValue == 'S') ||
            ((field.getValueAtPosition(pos) != 'E') &&
                (field.getValueAtPosition(pos).codeUnitAt(0) -
                        thisPosValue.codeUnitAt(0)) <
                    2)) {
          // can traverse, add node.
          if (graph[Position(x, y)] == null) {
            graph[Position(x, y)] = {};
          }
          graph[Position(x, y)]![pos] = 1;
        }
      });
    });

    print("start: $start");
    print("end: $end");

    var p2End = Position(138, 9);
    final path2 = Dijkstra.findPathFromGraph(graph, start, p2End);
    print("path len: ${path2.length}");
    print(graph[p2End]);

    final path = Dijkstra.findPathFromGraph(graph, start, end);

    Field f2 = field.copy();
    path.forEach((element) {
      f2.setValueAtPosition(element, '•');
    });
    print(f2);

    int cost = 0;
    for (var i = 0; i < path.length - 1; ++i) {
      cost += graph.costForMove(path[i], path[i + 1]);
    }

    // part 2
    var minScenicPath = 1000000;
    print("there are ${starts.length} possible starts");
    starts.forEach((possibleStart) {
      var scenicpath = Dijkstra.findPathFromGraph(graph, possibleStart, end);
      if ((scenicpath.length > 0) && (scenicpath.length < minScenicPath)) {
        print("start: $possibleStart : ${scenicpath.length}");
        minScenicPath = scenicpath.length;
      }
    });
    return cost;
  }

  @override
  int solvePart2() {
    return 0;
  }
}

extension on Map<Position, Map<Position, int>> {
  int costForMove(Position from, Position to) {
    return this[from]![to]!;
  }
}
