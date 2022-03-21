import 'package:flutter/material.dart';

class MinesweeperAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MinesweeperAppBar({
    Key? key,
    required this.numberOfBombs,
  }) : super(key: key);

  final int numberOfBombs;

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _GameInfos(
            nametag: 'B O M B S',
            number: numberOfBombs.toString(),
          ),
          const _RefreshGameButton(),
          const _GameInfos(nametag: 'T I M E', number: '0')
        ],
      ),
    );
  }
}

class _RefreshGameButton extends StatelessWidget {
  const _RefreshGameButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Icon(
        Icons.refresh,
        color: Colors.grey[300],
        size: 40,
      ),
      color: Colors.grey[700],
      elevation: 10,
    );
  }
}

class _GameInfos extends StatelessWidget {
  const _GameInfos({
    Key? key,
    required this.nametag,
    required this.number,
  }) : super(key: key);

  final String nametag;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 40),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(nametag)
      ],
    );
  }
}
