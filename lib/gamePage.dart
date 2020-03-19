import 'package:flutter/material.dart';
import 'dart:async';
import 'category.dart';
import 'team.dart';
import 'package:flutter/cupertino.dart';
import 'scorePage.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:screen/screen.dart';
import 'package:flutter/services.dart';

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
  String _word;
  var _letterColor = Colors.black54;
  var _backgroundColor = Colors.deepPurpleAccent;
  Timer _timer;
  int _start;
  bool _visible = false;
  List<Team> _teams = [];
  int _idTeam = 0;
  int _score;
  final SpeechToText speech = SpeechToText();
  String lastError = "";
  String lastStatus = "";
  bool _hasPass = false;
  String _skipWord = "";

  @override
  void initState() {
    super.initState();
    _getWord();
    initSpeechState();
    _addTeams();
    Screen.keepOn(true);
    _skipWord = widget.category.getPass();
  }

  void _startTimer() {
    _score = _teams[_idTeam].getScore();
    _start=300;
//    _start = widget.startTime;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            stopListening();
            _visible = false;
            _idTeam++;
            if (_idTeam < widget.teams) {
              _teams[_idTeam].incrementScore();
              _getWord();
            } else {
              cancelListening();
              Screen.keepOn(false);
              widget.scorePage.isRead = false;
              widget.scorePage.teams = _teams;
              widget.category.resetCategory();
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => widget.scorePage),
              );
            }
          } else {
            _start = _start - 1;
            _hasPass = false;
            if (!speech.isListening) {
              startListening();
            }
          }
        },
      ),
    );
  }

  void _addTeams() {
    for (int i = 1; i <= widget.teams; i++) {
      _teams.add(Team(i));
    }
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    super.dispose();
    speech.stop();
    Screen.keepOn(false);
    widget.category.resetCategory();
  }

  void _incrementScoreOppositeTeam() {
    setState(() {
      for (Team team in _teams) {
        if (team.id != _idTeam + 1) team.incrementScore();
      }
    });
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

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (!mounted) return;
  }

  void startListening() {
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: widget.startTime),
        localeId: widget.language,
        cancelOnError: true,
        partialResults: true);
  }

  void stopListening() {
    speech.stop();
  }

  void cancelListening() {
    speech.cancel();
  }

  void resultListener(SpeechRecognitionResult result) {
    String text =
        "${result.recognizedWords} - ${result.finalResult}".toLowerCase();
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
                  SystemSound.play(SystemSoundType.click);
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
    if (textList.contains(_skipWord) && !_hasPass) {
      setState(() {
        _hasPass = true;
      });
      _incrementScoreOppositeTeam();
      widget.category.remove(_word);
      _getWord();
    }
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
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
          color:
              !_visible ? Colors.transparent : widget.scorePage.colors[_idTeam],
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
                      textAlign: TextAlign.center,
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
                        color: Colors.black54,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          _visible = !_visible;
                          startListening();
                          _startTimer();
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
