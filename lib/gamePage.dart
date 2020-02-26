import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:async';
import 'category.dart';
import 'team.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';


class GamePage extends StatefulWidget {
  GamePage({Key key, this.title,this.category}) : super(key: key);
  final String title;
  final Category category;

  @override
  _GamePageState createState() => _GamePageState(category);
}

class _GamePageState extends State<GamePage> {
  int _selectedIndex = 0;
  String _word;
  final Category category;
  _GamePageState(this.category);
  var _letterColor = Colors.black54;
  var _backgroundColor = Colors.deepPurpleAccent;
  Timer _timer;
  int _start;
  bool _visible= false;
  List<Team> _teams=[];
  int _idTeam=0;
  int _score;
  bool _isListening= false;
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  String _transcription ='';

  void _startTimer() {
    _start=20;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            stop();
            _visible=false;
            category.resetCategory();
            _getWord();
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
    super.initState();
    _getWord();
    _teams.add(Team(_idTeam));
    _score= _teams[_idTeam].getScore();
    activateSpeechRecognizer();
  }

  void activateSpeechRecognizer() {
    requestPermission();
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.activate().then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void requestPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]);
    }
  }

  void start() => _speech
      .listen(locale: 'en_US')
      .then((result) => print('Started listening => result $result'));

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() => _speech.stop().then((result) {
    setState(() => _isListening = result);
  });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) =>
      setState(() => print("current locale: $locale"));

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {
    List<String> wordList= _word.split(" ");
    List<String> textList= text.split(" ");
    setState(() {

      if (wordList.length <= text.length){
        for (int i= 0; i< text.length; i++){
          int indexText=i;
          if (wordList.length <= (text.length - i -1)) {
            for (int j = 0; j < wordList.length; j++) {
              if (i<textList.length && wordList[j] == textList[indexText]){
                print(wordList[j] + textList[indexText]);
                if (j == wordList.length-1) {
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

      if (textList.contains('pass') ) {
        _getWord();
      }
      start();

    });


  }

  void onRecognitionComplete() => setState(() => _isListening = false);

  void  _incrementScore(){
    setState(() {
      if (_teams[_idTeam] != null) {
        _teams[_idTeam].incrementScore();
        _score = _teams[_idTeam].getScore();
      }
    });
  }

  void  _getWord(){
    setState(() {
      _word = category.getNextWord();
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
              child:
                  Visibility(
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
              child:
              Visibility(
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
                        _speechRecognitionAvailable && !_isListening
                            ? start():  stop();
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
    );
  }
}
