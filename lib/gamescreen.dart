import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangman/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String word = wordList[Random().nextInt(wordList.length)];

  handleText() {
    String displayWord = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        elevation: 10,
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
            icon: const Icon(Icons.volume_up_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
                height: 30,
                child: Center(
                  child: Text(
                    "12 points",
                    style: retroStyle(15, Colors.white, FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image(
                width: 155,
                height: 155,
                fit: BoxFit.cover,
                color: Colors.white,
                image: AssetImage(
                  "images/hangman0.png",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "7 lives left",
                style: retroStyle(18, Colors.grey, FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "??????",
                style: retroStyle(35, Colors.white, FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10),
                childAspectRatio: 1.3,
                physics: NeverScrollableScrollPhysics(),
                children: letters.map((alphabet) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => print("Tapped"),
                    child: Center(
                      child: Text(
                        alphabet,
                        style: retroStyle(20, Colors.white, FontWeight.w700),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
