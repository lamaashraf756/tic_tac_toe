import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'game_logic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('gameStats');
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TicTacToeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D44),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 3),
              ),
              child: const Text(
                'X O',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Tic Tac Toe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  final GameLogic _game = GameLogic();

  @override
  void initState() {
    super.initState();
    _game.initHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe (XO)'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2D2D44),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _game.statsBox.listenable(),
                  builder: (context, box, _) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D44),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Total Matches: ${_game.totalMatches}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatCard(
                              'Player X',
                              _game.winsX,
                              _game.lossesX,
                              Colors.blueAccent,
                            ),
                            _buildStatCard(
                              'Player O',
                              _game.winsO,
                              _game.lossesO,
                              Colors.redAccent,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  _game.statusMessage,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _game.gameOver
                        ? Colors.amberAccent
                        : (_game.isXTurn
                            ? Colors.blueAccent
                            : Colors.redAccent),
                  ),
                ),
                const SizedBox(height: 16),
                AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _game.handleTap(index);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D44),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              _game.board[index],
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: _game.board[index] == 'X'
                                    ? Colors.blueAccent
                                    : Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _game.resetGame();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Play Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _game.clearStats();
                        });
                      },
                      icon: const Icon(Icons.clear_all, color: Colors.white),
                      label: const Text('Reset Stats',
                          style: TextStyle(color: Colors.white)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white54),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, int wins, int losses, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D44),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            'Wins: $wins',
            style: const TextStyle(fontSize: 14, color: Colors.greenAccent),
          ),
          Text(
            'Losses: $losses',
            style: const TextStyle(fontSize: 14, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}