import 'package:flutter/material.dart';
import 'dart:async';
import 'category.dart';
import 'team.dart';
import 'package:flutter/cupertino.dart';
import 'scorePage.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:wakelock/wakelock.dart';

class GamePage extends StatefulWidget {
  GamePage(
      {Key key,
        this.title,
        this.category,
        this.teams,
        this.language,
        this.startTime,
        this.scorePage})
      : super(key: key);
  final String title;
  final Category category;
  final String language;
  final teams;
  final startTime;
  final ScorePage scorePage;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _selectedIndex = 0;
  String _word;
  var _letterColor = Colors.black54;
  var _backgroundColor = Colors.deepPurpleAccent;
  Timer _timer;
  int _start;
  bool _visible = false;
  List<Team> _teams = [];
  int _idTeam = 0;
  int _score;
  bool _isListening = false;
  final SpeechToText speech = SpeechToText();
  String lastError = "";
  String lastStatus = "";

  void _startTimer() {
    addTeam();
//    _start=2;
    _start = widget.startTime;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            stopListening();
            _idTeam++;
            if (_idTeam < widget.teams) {
              _visible = false;
              widget.category.resetCategory();
              _getWord();
            } else {
              cancelListening();
              widget.scorePage.teams=_teams;
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => widget.scorePage),
              );
            }
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void addTeam() {
    _teams.add(Team(_idTeam));
    _score = _teams[_idTeam].getScore();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    cancelListening();
  }

  void _incrementScore() {
    setState(() {
      if (_teams[_idTeam] != null) {
        _teams[_idTeam].incrementScore();
        _score = _teams[_idTeam].getScore();
      }
    });
  }

  void _getWord() {
    setState(() {
      _word = widget.category.getNextWord();
    });
  }

  @override
  void initState() {
    super.initState();
    _getWord();
    initSpeechState();
  }


  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(onError: errorListener, onStatus: statusListener );

    if (!mounted) return;
    setState(() {
      _isListening = hasSpeech;
    });
  }

  void startListening() {
    speech.listen(onResult: resultListener );
  }

  void stopListening() {
    speech.stop( );
  }

  void cancelListening() {
    speech.cancel( );
  }

  void resultListener(SpeechRecognitionResult result) {
    String text="${result.recognizedWords} - ${result.finalResult}";
    List<String> wordList = _word.split(" ");
    List<String> textList = text.split(" ");

    setState(() {
      if (wordList.length <= text.length) {
        for (int i = 0; i < text.length; i++) {
          int indexText = i;
          if (wordList.length <= (text.length - i - 1)) {
            for (int j = 0; j < wordList.length; j++) {
              if (i < textList.length && wordList[j] == textList[indexText]) {
                print(wordList[j] + textList[indexText]);
                if (j == wordList.length - 1) {
                  _getWord();
                  _incrementScore();
                  i = textList.length;
                  break;
                }
                indexText++;
                continue;
              }
              break;
            }
          }
        }
      }
    });
    if (textList.contains('pass')) {
      _getWord();
    }
    stopListening();
    startListening();
  }

  void errorListener(SpeechRecognitionError error ) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });

    startListening();
  }
  void statusListener(String status ) {
    setState(() {
      lastStatus = "$status";
    });
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
        child: Container(
          color: widget.scorePage.colors[_idTeam],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: _visible,
                child: Expanded(
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
                                '$_score',
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
              ),
              Expanded(
                flex: 6,
                child: Visibility(
                  visible: _visible,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '$_word',
                      style: TextStyle(
                        color: _letterColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: !_visible,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width / 2,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          _visible = !_visible;
                          startListening();
                          _startTimer();
                          setState(() {
                            Wakelock.enable();
                          });
                        },
                        child: Text(
                          'Start',
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
