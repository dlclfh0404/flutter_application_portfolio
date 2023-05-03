import 'package:flutter/material.dart';
import 'dice/my_dice.dart';
import 'package:flutter_application_portfolio/my_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;
  //하단 아이템들 배열 선언
  List<BottomNavigationBarItem> items = [];
  late Widget bodyPage; // widget은 null값이 안들어감
  List<dynamic> pages = [
    const MyTimer(),
    const MyTimer(),
    const MyDice(),
    const MyTimer(),
  ];

  void movePage(int page) {
    if (mounted) {
      setState(() {
        _index = page;
        bodyPage = pages[page];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //초기화 할일
    items.add(const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.house),
      label: 'home',
    ));
    items.add(const BottomNavigationBarItem(
      icon: Icon(Icons.access_time_rounded),
      label: 'timer',
    ));
    items.add(const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.dice),
      label: 'dice',
    ));
    items.add(const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.user),
      label: 'profile',
    ));

    //첫페이지를 지정
    bodyPage = const Center(
      child: Text('home 임시'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: bodyPage,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              movePage(value);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: _index,
            backgroundColor: Colors.grey[100],
            items: items),
      ),
    );
  }
}
