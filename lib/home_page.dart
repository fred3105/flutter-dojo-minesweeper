import 'package:flutter/material.dart';
import 'package:myapp/minesweeper_app_bar.dart';
import 'package:myapp/minesweeper_body.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<int> bombLocation = [6, 14, 24, 26, 31, 32, 47, 49, 68];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MinesweeperAppBar(
        numberOfBombs: bombLocation.length,
      ),
      body: MinesweeperBody(
        bombLocation: bombLocation,
      ),
    );
  }
}
