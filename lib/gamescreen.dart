import 'package:flutter/material.dart';
import 'package:hangman/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: Text(
          "Hangman",
          style: retroStyle(30, Colors.white, FontWeight.w700),
        ),
        actions: [
          IconButton(
            iconSize: 40,
            color: Colors.purpleAccent,
            onPressed: () {},
            icon: Icon(Icons.volume_up_sharp),
          )
        ],
      ),
    );
  }
}
