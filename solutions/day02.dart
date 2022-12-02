import '../utils/index.dart';

class Day02 extends GenericDay {
  List games = [];
  // (1 for Rock, 2 for Paper, and 3 for Scissors)
  var shapeScores = [1, 2, 3];
  // outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
  List outcomes = [0, 3, 6];

  Day02() : super(2);

  @override
  parseInput() {
    this.games = input.getPerLine();
  }

  @override
  int solvePart1() {
    parseInput();

    int totalScore = 0;

    games.forEach((singleGame) {
      var splitGame = singleGame.split(" ");

      int myPlay = splitGame[1].codeUnitAt(0) - 'X'.codeUnitAt(0);
      int theirPlay = splitGame[0].codeUnitAt(0) - 'A'.codeUnitAt(0);

      var outcomeScore = 0;
      var gameScore = myPlay - theirPlay;

      if (gameScore == 0) {
        outcomeScore = outcomes[1]; // tie!
      } else if (gameScore == 2) {
        outcomeScore = outcomes[0]; // rochambo!
      } else if (gameScore == -2) {
        outcomeScore = outcomes[2]; // rochambo!
      } else if (gameScore > 0) {
        outcomeScore = outcomes[2]; // WIN!!
      } else if (gameScore < 0) {
        outcomeScore = outcomes[0]; // LOSS!
      }

      // print(
      //     " me: ${myPlay + 1}, them: ${theirPlay + 1} score: ${shapeScores[myPlay]} + $outcomeScore [gs: $gameScore]");
      totalScore += shapeScores[myPlay] + outcomeScore;
    });

    return totalScore;
  }

  @override
  int solvePart2() {
    int totalScore = 0;

    games.forEach((singleGame) {
      var game = singleGame.split(" ");

      int theirPlay = game[0].codeUnitAt(0) - 'A'.codeUnitAt(0);
      int desiredOutcome = game[1].codeUnitAt(0) - 'X'.codeUnitAt(0);
      int outcomeScore = outcomes[desiredOutcome];

      int myPlay = 0;
      if (desiredOutcome == 1) {
        myPlay = theirPlay;
      } else if (desiredOutcome == 0) {
        // I want to lose
        myPlay = theirPlay - 1;
        if (myPlay == -1) myPlay = 2;
      } else if (desiredOutcome == 2) {
        // I want to win
        myPlay = theirPlay + 1;
        if (myPlay == 3) myPlay = 0;
      }

      print(
          " $desiredOutcome me: ${myPlay + 1}, them: ${theirPlay + 1} score: ${shapeScores[myPlay]} + $outcomeScore");

      totalScore += shapeScores[myPlay] + outcomeScore;
    });

    return totalScore;
  }
}
