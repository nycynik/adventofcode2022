import '../utils/index.dart';

class File {
  var name = "";
  var size = 0;

  File(this.name, this.size);
}

class Dir {
  var parent;
  List<Dir> children = [];
  List<File> files = [];
  int dirSize = 0;
  var name = "";

  Dir(this.name);

  setParent(Dir parent) {
    this.parent = parent;
  }

  addDir(Dir child) {
    // print("adding dir ${name} / ${child.name}");
    child.setParent(this);
    this.children.add(child);
    if (child.dirSize != 0) this.addSize(child.dirSize);
  }

  addFile(File f) {
    files.add(f);
    this.addSize(f.size);
  }

  addSize(int size) {
    this.dirSize += size;
    // print('adding size to $name - $size total ${this.dirSize}');
    if (this.parent != null) {
      this.parent.addSize(size);
    }
  }

  changeDir(name) {
    for (var x = 0; x < this.children.length; x++) {
      if (this.children[x].name == name) return this.children[x];
    }
    return null;
  }

  getPath() {
    if (parent != null) {
      return parent.getPath() + "/" + this.name;
    } else {
      return this.name;
    }
  }

  printDir({spacer: ''}) {
    print("${dirSize.toString().padLeft(10)} $spacer ${name}");
    this.children.forEach((element) {
      element.printDir(spacer: spacer + '\t');
    });
  }

  int printSmallDirs(minsize) {
    var TotalSumOfSmallDirs = 0;

    if (dirSize <= minsize) {
      print("${dirSize.toString().padLeft(10)}\t${name}");
      TotalSumOfSmallDirs += dirSize;
    }
    this.children.forEach((element) {
      TotalSumOfSmallDirs += element.printSmallDirs(minsize);
    });
    return TotalSumOfSmallDirs;
  }

  findSmallestBiggerThan(size) {
    var smallesFound = 0;

    if (dirSize > size) {
      print("${dirSize.toString().padLeft(10)}\t${name}");
      smallesFound = dirSize;
    }
    this.children.forEach((element) {
      element.findSmallestBiggerThan(size);
    });
    return this;
  }

  findSmallestBiggerThanWrog(size) {
    var bestCandidate = null;

    if (this.dirSize > size) {
      var smallest = this.dirSize;
      print("found $name with ${dirSize} [${dirSize - size}]");

      // this an all children are candidates.
      for (var x = 0; x < this.children.length; x++) {
        if (this.children[x].dirSize > size &&
            this.children[x].dirSize < smallest) {
          // then this child is still big enough, so better candidate, it's
          // smaller and still big enough.
          bestCandidate = this.children[x];
          smallest = bestCandidate.dirSize;
          print("found ${bestCandidate.name} with ${bestCandidate.dirSize}");

          //this.children[x].findSmallestBiggerThan(size)
        }
      }
    }
    if (bestCandidate != null) {
      return bestCandidate.findSmallestBiggerThan(size);
    }
    return this;
  }
}

class Day07 extends GenericDay {
  var rootDir = new Dir('(root)');

  Day07() : super(7);

  @override
  parseInput() {
    var lines = input.getPerLine();
    var currDir = rootDir;

    lines.forEach((element) {
      if (element == '\$ cd /') return;

      // parse commands
      if (element[0] == '\$') {
        var cmd = element.substring(2, 4);
        switch (cmd) {
          case 'cd':
            var newDir = element.substring(5);
            if (newDir == '..') {
              currDir = currDir.parent;
            } else {
              currDir = currDir.changeDir(newDir);
            }
            print("cd ${currDir.getPath()}");
            break;
          case 'ls':
            break;
        }
      } else {
        // not a command, maybe a new dir or file?
        var splitCmd = element.split(' ');
        if (splitCmd[0] == 'dir') {
          var dirName = element.substring(4);
          currDir.addDir(new Dir(dirName));
        } else {
          // its a file.
          currDir.addFile(new File(splitCmd[1], int.parse(splitCmd[0])));
          //currDir.printDir();
        }
      }
    });
  }

  @override
  int solvePart1() {
    parseInput();

    print('\n smaller:');
    return rootDir.printSmallDirs(100000);
    ;
  }

  @override
  int solvePart2() {
    var totalSpace = 70000000;
    var neededSpace = 30000000;

    var freeSpace = totalSpace - rootDir.dirSize;
    var needToDelete = neededSpace - freeSpace;

    print("Free Space = $totalSpace - ${rootDir.dirSize} = ${freeSpace}");
    print("Space Needed = $neededSpace ");
    print("Difference = $neededSpace - $freeSpace = ${needToDelete}");

    // find a dir that will eliminate needToDelete space.
    var dir = rootDir.findSmallestBiggerThan(needToDelete);
    print("\n${dir.name} - ${dir.dirSize}");

    return 0;
  }
}
