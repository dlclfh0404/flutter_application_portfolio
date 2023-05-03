import 'dart:async';

import 'package:flutter/material.dart';
import 'dice.dart';

void main() {
  runApp(const MyDice());
}

class MyDice extends StatefulWidget {
  const MyDice({super.key});

  @override
  State<MyDice> createState() => _MyDiceState();
}

class _MyDiceState extends State<MyDice> {
  Dice dice = Dice(size: 45);
  late Timer timer;
  dynamic resultNum = 0;
  String resultView = '';
  bool isStart = false;

  void start() {
    if (!isStart && dice.dice.isNotEmpty) {
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        dice.shake();
        if (mounted) {
          setState(() {
            resultNum = dice.dice[0];
            isStart = true;
          });
        }
      });
    }
  }

  void pickUp() {
    if (dice.dice.isNotEmpty && isStart) {
      setState(() {
        //resultView = resultView + ' ' + dice.pick().toString();
        resultView = '$resultView ${dice.pick()}';
      });
    }
    if (dice.dice.isEmpty) {
      //클래스이름.안에변수이름
      timer.cancel();
      setState(() {
        isStart = false;
        resultNum = '끝!!';
      });
    }
  }

  //초기화
  //결과를 지우기
  //배열을 다시 초기화 => 원래 크기로 만들기
  void reset() {
    setState(() {
      resultNum = '';
      resultView = '';
      dice.init();
      if (isStart) {
        timer.cancel();
      }
      isStart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.brown[200],
                  child: const Center(
                    child: Text('Random dice', style: TextStyle(fontSize: 60)),
                  ),
                )),
            Flexible(
                flex: 2,
                child: Center(
                    child: Text('$resultNum',
                        style: const TextStyle(fontSize: 60)))),
            Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.blueGrey[200],
                  child: Center(
                      child: Text(resultView,
                          style: const TextStyle(fontSize: 20))),
                )),
            Flexible(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            iconSize: 100,
                            onPressed: start,
                            icon: const Icon(
                              Icons.play_circle,
                            )),
                        IconButton(
                            iconSize: 100,
                            onPressed: pickUp,
                            icon: const Icon(Icons.check_circle_outline)),
                        IconButton(
                            iconSize: 100,
                            onPressed: reset,
                            icon: const Icon(
                                Icons.settings_backup_restore_outlined)),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
