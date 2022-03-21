import 'package:flutter/material.dart';

class MinesweeperNumberBox extends StatelessWidget {
  const MinesweeperNumberBox({
    Key? key,
    required this.number,
    required this.isBomb,
    required this.isRevealed,
    required this.function,
  }) : super(key: key);

  final String number;
  final bool isBomb;
  final bool isRevealed;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            color: isBomb
                ? isRevealed
                    ? Colors.grey[700]
                    : Colors.grey[400]
                : isRevealed
                    ? Colors.grey[300]
                    : Colors.grey[400],
            child: Center(
              child: Text(
                isBomb || !isRevealed || number == '0' ? '' : number,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: number == '1'
                      ? Colors.blue
                      : number == '2'
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
