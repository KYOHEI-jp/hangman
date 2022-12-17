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

  /**
   * 領域外を押しても動作しない ダイアログを表示
   */
  openDialog(String title) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("Youlost"),
              actions: [
                FlatButton(
                   //ライフとポイントを元に戻す
                    onPressed: () => {
                          points = 0,
                          status = 0,
                          Navigator.pop(context),
                          setState(() {})
                        },
                    child: Text("また遊んでね！"))
              ],
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
      guessedAlphabets.add(alphabet);
    } else if (status != 6) {
      setState(() {
        status += 1;
        points -= 5;
      });
    } else {
      openDialog("You lost");
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
      print("won");
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
