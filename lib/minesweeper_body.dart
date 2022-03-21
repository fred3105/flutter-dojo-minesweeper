import 'package:flutter/material.dart';
import 'package:myapp/minesweeper_number_box.dart';

const numberOfSquares = 9 * 9;
const numberInEachRow = 9;

class MinesweeperBody extends StatefulWidget {
  const MinesweeperBody({
    Key? key,
    required this.bombLocation,
  }) : super(key: key);

  final List bombLocation;

  @override
  State<MinesweeperBody> createState() => _MinesweeperBodyState();
}

class _MinesweeperBodyState extends State<MinesweeperBody> {
  late List squareStatus;
  bool bombRevealed = false;

  @override
  void initState() {
    super.initState();
    squareStatus = List.generate(numberOfSquares, (index) => [0, false]);
    _scanBombs();
  }

  void restartGame() {
    setState(() {
      bombRevealed = false;
      squareStatus = List.generate(numberOfSquares, (index) => [0, false]);
      _scanBombs();
    });
  }

  void _revealBoxNumber(int index) {
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
    } else {
      setState(() {
        squareStatus[index][1] = true;

        // left
        if (index % numberInEachRow != 0) {
          _revealSurroundSquare(index - 1);
        }
        // top-left
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          _revealSurroundSquare(index - 1 - numberInEachRow);
        }
        // top
        if (index >= numberInEachRow) {
          _revealSurroundSquare(index - numberInEachRow);
        }
        // top-right
        if (index % numberInEachRow != numberInEachRow - 1 &&
            index >= numberInEachRow) {
          _revealSurroundSquare(index + 1 - numberInEachRow);
        }
        // right
        if (index % numberInEachRow != numberInEachRow - 1) {
          _revealSurroundSquare(index + 1);
        }
        // bottom-right
        if (index % numberInEachRow != numberInEachRow - 1 &&
            index < numberOfSquares - numberInEachRow) {
          _revealSurroundSquare(index + 1 + numberInEachRow);
        }
        // bottom
        if (index < numberOfSquares - numberInEachRow) {
          _revealSurroundSquare(index + numberInEachRow);
        }
        // bottom-left
        if (index % numberInEachRow != 0 &&
            index < numberOfSquares - numberInEachRow) {
          _revealSurroundSquare(index - 1 + numberInEachRow);
        }
      });
    }
  }

  void _revealSurroundSquare(int squareIndex) {
    if (squareStatus[squareIndex][0] == 0 &&
        squareStatus[squareIndex][1] == false) {
      _revealBoxNumber(squareIndex);
      squareStatus[squareIndex][1] = true;
    }
  }

  void _scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      var numberOfBombsAround = 0;

      // left
      if (widget.bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }
      // top-left
      if (widget.bombLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }
      // top
      if (widget.bombLocation.contains(i - numberInEachRow) &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }
      // top-right
      if (widget.bombLocation.contains(i + 1 - numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }
      // right
      if (widget.bombLocation.contains(i + 1) &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }
      // bottom-right
      if (widget.bombLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }
      // bottom
      if (widget.bombLocation.contains(i + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }
      // bottom-left
      if (widget.bombLocation.contains(i - 1 + numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

  void _playerLost() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: Center(
              child: Text(
                'You lose !'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.refresh,
                  color: Colors.grey,
                ),
              )
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }

  void _playerWon() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: Center(
              child: Text(
                'You win !'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.refresh,
                  color: Colors.grey,
                ),
              )
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }

  void _checkWinner() {
    var unrevealedBoxes = 0;
    for (int i = 0; i < numberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unrevealedBoxes++;
      }
    }
    if (unrevealedBoxes == widget.bombLocation.length) {
      _playerWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: numberOfSquares,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numberInEachRow,
      ),
      itemBuilder: (context, index) {
        final isBomb = widget.bombLocation.contains(index);
        return MinesweeperNumberBox(
          number: squareStatus[index][0].toString(),
          isBomb: isBomb,
          isRevealed: isBomb ? bombRevealed : squareStatus[index][1],
          function: () {
            isBomb
                ? {
                    setState(() {
                      bombRevealed = true;
                    }),
                    _playerLost()
                  }
                : {
                    _revealBoxNumber(index),
                    _checkWinner(),
                  };
          },
        );
      },
    );
  }
}
