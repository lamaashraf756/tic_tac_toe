import 'package:hive_flutter/hive_flutter.dart';

class GameLogic {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;
  String statusMessage = "Player X's Turn";
  bool gameOver = false;

  late Box statsBox;

  final List<List<int>> winPatterns = const [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6],
  ];

  void initHive() {
    statsBox = Hive.box('gameStats');
  }

  int get totalMatches => statsBox.get('totalMatches', defaultValue: 0);
  int get winsX => statsBox.get('winsX', defaultValue: 0);
  int get winsO => statsBox.get('winsO', defaultValue: 0);
  int get lossesX => winsO;
  int get lossesO => winsX;

  bool handleTap(int index) {
    if (board[index] != '' || gameOver) return false;

    board[index] = isXTurn ? 'X' : 'O';
    _checkWinner();

    if (!gameOver) {
      isXTurn = !isXTurn;
      statusMessage = isXTurn ? "Player X's Turn" : "Player O's Turn";
    }
    return true;
  }

  void _checkWinner() {
    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];

      if (a != '' && a == b && b == c) {
        gameOver = true;
        statusMessage = "Player $a Wins!";
        _updateStats(winner: a);
        return;
      }
    }

    if (!board.contains('') && !gameOver) {
      gameOver = true;
      statusMessage = "It's a Draw!";
      _updateStats(winner: null);
    }
  }

  void _updateStats({String? winner}) {
    statsBox.put('totalMatches', totalMatches + 1);
    if (winner == 'X') {
      statsBox.put('winsX', winsX + 1);
    } else if (winner == 'O') {
      statsBox.put('winsO', winsO + 1);
    }
  }

  void resetGame() {
    board = List.filled(9, '');
    isXTurn = true;
    gameOver = false;
    statusMessage = "Player X's Turn";
  }

  void clearStats() {
    statsBox.put('totalMatches', 0);
    statsBox.put('winsX', 0);
    statsBox.put('winsO', 0);
    resetGame();
  }
}