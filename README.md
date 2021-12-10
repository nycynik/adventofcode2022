<img src="https://www.kindpng.com/picc/m/176-1766554_dart-programming-language-logo-hd-png-download.png" width="160" align="right">

# AdventOfCode-Starter-Darts

This is a Starter project for [AdventOfCode](https://adventofcode.com/2021), written in `Dart`. Feel free to use it for your own adventures with the christmas-themed puzzles!

## How to use
The code is commented abundantly, but you can find an overview about the features here as well.

### Boilterplate Generation
In the root of your directory, run `dart run day_generator.dart <day>` <br>
This will create an empty input file and a solution file with all the needed boilerplate to have a quick start. It also adds the solution to the corresponding index file, so the solution get imported into `main` automatically.

### Main
To add a new solution, all you have to do is add `DayXX()` to the `day` List. Running main automatically prints either all your solutions, or just the last one, depending on your settings.

### Generic Day
The abstract class all individual days subclass from. When constructed with the correct `day`, it automatically ready the corresponding input file and provides it with the `InputUtil`. To access it, just call `input` inside your class.

### Input Util
Automatically reads the input files and provides different methods to parse it.
- `.asString` to get the whole input as a single String
- `.getPerLine()` splits on `\n` characters, returning a List with single lines as elements.
- `.getPerWhitespace()` splits on `\s` and `\n`, essentially returning a List with all the single characters.
- `.getBy(pattern)` lets you define your own split logic. It essentially calls Dart´s native `.split(pattern)`

### Parse Util
A place to store useful parsing operations, like creating a `List<int>` from a `List<String>`. There will be a lot of opportunities during AoC for you to extend this.

### Naming conventions
When using the Boilerplate generator, everything is done for you automatically. However, if you create a solution or input file by yourself: make sure it has a 2-digit number. Concretely, pad days 1-9 as `Day01.dart` for solutions and `aoc01.txt` for input.

## Contributing
Contributing is greatly appreciated, just fork this project and create a Pull Request, or open an Issue!

# Happy Holidays!

<img src="https://blogs.sap.com/wp-content/uploads/2020/11/EkaoQQTXEAMA4BN.jpg">
