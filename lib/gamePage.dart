import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:async';
import 'Category.dart';


class GamePage extends StatefulWidget {
  GamePage({Key key, this.title,this.category}) : super(key: key);
  final String title;
  final Category category;

  @override
  _GamePageState createState() => _GamePageState(category);
}

class _GamePageState extends State<GamePage> {
  int _selectedIndex = 0;
  final Category category;
  _GamePageState(this.category);
  var _letterColor = Colors.black54;
  var _backgroundColor = Colors.deepPurpleAccent;
  Timer _timer;
  int _start = 60;
  int score = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text(widget.title),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/gradient.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Time',
                            style: TextStyle(
                              color: _letterColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            "$_start",
                            style: TextStyle(
                              color: _letterColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Score:',
                            style: TextStyle(
                              color: _letterColor,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            '$score',
                            style: TextStyle(
                              color: _letterColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  category.getNextWord(),
                  style: TextStyle(
                    color: _letterColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(''),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
