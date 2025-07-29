import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreO = 0;
  int scoreX = 0;
  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TicTacToe',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              _resetGame();
            },
            icon: Icon(Icons.refresh),
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            _getScoreBoard(),
            SizedBox(height: 20),
            _getResultButton(),
            SizedBox(height: 20),
            _getGridView(),
            _getTurn(),
          ],
        ),
      ),
    );
  }

  Widget _getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        onPressed: () {
          gameHasResult = false;
          _clearGame();
        },
        child: Text(
          '$winnerTitle, play again!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          side: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _getGridView() {
    return Expanded(
      child: GridView.builder(
        // shrinkWrap: true,
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (gameHasResult == false) {
                _tapped(index);
              }
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                xOrOList[index],
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: xOrOList[index] == 'X' ? Colors.blue : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _tapped(int index) {
    // if (gameHasResult) {
    //   return;
    // }

    setState(() {
      if (xOrOList[index] != '') {
        return;
      }
      if (isTurnO) {
        xOrOList[index] = 'O';
        filledBoxes = filledBoxes + 1;
      } else {
        xOrOList[index] = 'X';
        filledBoxes = filledBoxes + 1;
      }
      isTurnO = !isTurnO;

      _checkWinner();
    });
  }

  void _checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0], 'winner is ' + xOrOList[0]);
      return;
    }
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      _setResult(xOrOList[3], 'winner is ' + xOrOList[3]);
      return;
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      _setResult(xOrOList[6], 'winner is ' + xOrOList[6]);
      return;
    }
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0], 'winner is ' + xOrOList[0]);
      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      _setResult(xOrOList[1], 'winner is ' + xOrOList[1]);
      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      _setResult(xOrOList[2], 'winner is ' + xOrOList[2]);
      return;
    }
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0], 'winner is ' + xOrOList[0]);
      return;
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      _setResult(xOrOList[2], 'winner is ' + xOrOList[2]);
      return;
    }

    if (filledBoxes == 9) {
      _setResult('', 'draw');
    }
  }

  Widget _getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player O',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreO',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreX',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == 'X') {
        scoreX = scoreX + 1;
      } else if (winner == 'O') {
        scoreO = scoreO + 1;
      } else {
        scoreX = scoreX + 1;
        scoreO = scoreO + 1;
      }
    });
  }

  void _resetGame() {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
      gameHasResult = false;
      scoreO = 0;
      scoreX = 0;
      filledBoxes = 0;
    });
  }

  void _clearGame() {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
      filledBoxes = 0;
    });
  }
}
