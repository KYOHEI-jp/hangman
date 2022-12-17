import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hangman/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  AudioCache audioCache = AudioCache(prefix: "sounds/");
  String word = wordList[Random().nextInt(wordList.length)];
  List guessedAlphabets = [];
  int points = 0;
  int status = 0;
  List images = [
    "images/hangman0.png",
    "images/hangman1.png",
    "images/hangman2.png",
    "images/hangman3.png",
    "images/hangman4.png",
    "images/hangman5.png",
    "images/hangman6.png",
  ];

  playSound(String sound) async {
    await audioCache.play(sound);
  }

  /**
   * 領域外を押しても動作しない ダイアログを表示
   */
  openDialog(String title) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 180,
              decoration: BoxDecoration(color: Colors.purpleAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: retroStyle(25, Colors.white, FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your point: $points",
                    style: retroStyle(25, Colors.white, FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          status = 0;
                          points = 0;
                          guessedAlphabets.clear();
                          word = wordList[Random().nextInt(wordList.length)];
                        });
                        playSound("sounds/restart.mp3");
                      },
                      child: Center(
                        child: Text(
                          "Play again",
                          style:
                              retroStyle(20, Colors.white, FontWeight.normal),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  String handleText() {
    String displayWord = "";
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (guessedAlphabets.contains(char)) {
        displayWord += char;
      } else {
        displayWord += "? ";
      }
    }
    return displayWord;
  }

  checkLetter(String alphabet) {
    if (word.contains(alphabet)) {
      setState(() {
        guessedAlphabets.add(alphabet);
        points += 5;
      });
      playSound("sounds/correct.mp3");
      guessedAlphabets.add(alphabet);
    } else if (status != 6) {
      setState(() {
        status += 1;
        points -= 5;
      });
      playSound("sounds/wrong.mp3");
    } else {
      openDialog("You lost");
      playSound("sounds/lost.mp3");
    }

    bool isWon = true;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!guessedAlphabets.contains(char)) {
        setState(() {
          isWon = false;
        });
        break;
      }
    }

    if (isWon) {
      openDialog("Hurray You Won");
      playSound("sounds/won.mp3");
    }
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
                    "$points points",
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
                  images[status],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${7 - status} lives left",
                style: retroStyle(18, Colors.grey, FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                handleText(),
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
                    onTap: () => checkLetter(alphabet),
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
