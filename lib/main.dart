import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> selectedIndexes = [];
  static const bombIndexes = [2, 22, 41, 42, 52, 63, 64, 72, 77];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(10),
            itemCount: 9 * 9,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => setState(() {
                  selectedIndexes.add(index);
                }),
                child: MinesweeperTile(
                  bombIndexes: bombIndexes,
                  index: index,
                  isSelected: selectedIndexes.contains(index),
                ),
              );
            },
          ),
        ));
  }
}

class MinesweeperTile extends StatelessWidget {
  const MinesweeperTile({
    Key? key,
    required this.bombIndexes,
    required this.index,
    required this.isSelected,
  }) : super(key: key);

  final List<int> bombIndexes;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var bombs = getNumberOfBombsAround(index, bombIndexes);
    bool hasBombsAround =
        getNumberOfBombsAround(index, bombIndexes) == 0 ? true : false;
    return ColoredBox(
      child:
          isSelected && !hasBombsAround ? Center(child: Text("$bombs")) : null,
      color:
          bombIndexes.contains(index) && isSelected ? Colors.red : Colors.grey,
    );
  }

  static const tileWidth = 9;
  int getNumberOfBombsAround(int index, List<int> bombIndexes) {
    int count = 0;
    if (bombIndexes.contains(index - tileWidth - 1)) count++;
    if (bombIndexes.contains(index - tileWidth)) count++;
    if (bombIndexes.contains(index - tileWidth + 1)) count++;
    if (bombIndexes.contains(index - 1)) count++;
    if (bombIndexes.contains(index + 1)) count++;
    if (bombIndexes.contains(index + tileWidth - 1)) count++;
    if (bombIndexes.contains(index + tileWidth)) count++;
    if (bombIndexes.contains(index + tileWidth + 1)) count++;
    return count;
  }
}
