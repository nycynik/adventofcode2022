
# AdventOfCode 2022!

<pre>
 *        +     *           *           *                *        *
      *  ( )          | advent of code *           *
   *    (   )    *    | 2022    *            +             *          *
       (     )      * | https://adventofcode.com/        *   (._.)
*     (       )        +         *      *         *         (  .  )  *
     (         )   *     *     +              *        *   (   .   )   +
</pre>

# Puzzles

| S  | M  | T  | W  | Th | F | S |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|   |   |   | [Day 01](./solutions/day01.dart) ⭐⭐ | [Day 02](./solutions/day02.dart) ⭐⭐ | [Day 03](./solutions/day03.dart) ⭐⭐  | [Day 04](./solutions/day04.dart)  |
| [Day 05](./solutions/day05.dart)  | [Day 06](./solutions/day06.dart)  | [Day 07](./solutions/day07.dart)   | [Day 08](./solution/day08.dart)   | [Day 09](./solutions/day09.dart)  | [Day 10](./solutions/day10.dart)  | [Day 11](./solutions/day11.dart)  |
| [Day 12](./solution/day12.dart)  | [Day 13](./solutions/day13.dart)  | [Day 14](./solutions/day14.dart)  | [Day 15](./solutions/day15.dart)   | [Day 16](./solutions/day16.dart) | [Day 17](./solutions/day17.dart)  | [Day 18](./solutions/day18.dart) |
| [Day 19](./solutions/day19.dart)  | [Day 20](./solutions/day20.dart)  | [Day 21](./solutions/day21.dart)   | [Day 22](./solutions/day22.dart)   | [Day 23](./solutions/day23.dart) | [Day 24](./solutions/day24.dart)  | [Day 25](./solutions/day25.dart) |

# Development

## How to use
The code is commented abundantly, but you can find an overview about the features here as well.

### Setup
Please visit the [AdventOfCode](https://adventofcode.com/2022) site and log in. After that, get your cookie from the browser, and add it to the day_generator.dart file´s `session` variable. This will allow the script to populate your input file.

### Boilterplate Generation
In the root of your directory, run `dart run day_generator.dart <day>` <br>
This will create an input file and a solution file with all the needed boilerplate to have a quick start. It also adds the solution to the corresponding index file, so the solution get imported into `main` automatically. 

### Main
To add a new solution, all you have to do is add `DayXX()` to the `day` List. Running main automatically prints either all your solutions, or just the last one, depending on your settings.

You can run the main file by running `dart run main.dart` or `dart main.dart` in the root of your directory.
By default the main file will only show the last solution. If you want to see all of them, you can use the `-a` or `--all` flag.
You can list all the command line arguments by using the `-h` or `--help` flag.

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

### Field Class
A helper class for 2D data, as often present in AoC. Any data can be respresented. For Integers specifically, there are convenience methods in `IntegerField`. For all available methods, have a look at the abundantly-documented code.

### Naming conventions
When using the Boilerplate generator, everything is done for you automatically. However, if you create a solution or input file by yourself: make sure it has a 2-digit number. Concretely, pad days 1-9 as `Day01.dart` for solutions and `aoc01.txt` for input.

### Helper Packages
**Tuple** enables operations on pairs/triplets etc of any type. Absolutely needed for most of the puzzles.
**Collection** provides many methods for ...collections... Most importantly, a `groupBy` and a collection equality interface.
**Quiver** is an awesome toolbox of helper methods for Dart. We mostly use `/iterables` (similar to Pythons `itertools`). 

# Happy Holidays!

<img solution="https://blogs.sap.com/wp-content/uploads/2020/11/EkaoQQTXEAMA4BN.jpg">
