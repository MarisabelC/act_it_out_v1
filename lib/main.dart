import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'game.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Act It Out',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Act It Out'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Setting',
      style: optionStyle,
    ),
    Text(
      'Index 1: Quit',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _exitApp() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quit'),

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to quit?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                exit(0);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          Container(

            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red)

            ),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                _exitApp();
              },
            ),
          ),
        ],
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/gradient.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Act it out',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ButtonTheme(
                minWidth: MediaQuery. of(context). size. width/2,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                        CupertinoPageRoute(builder: (context) => GamePage(title: '',)),
                    );
                  },
                  child: Text(
                    "Play",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(''),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurpleAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Setting'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.score),
            title: Text('Score'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

//
//_speech = SpeechRecognition();
//
//// The flutter app not only call methods on the host platform,
//// it also needs to receive method calls from host.
//_speech.setAvailabilityHandler((bool result)
//=> setState(() => _speechRecognitionAvailable = result));
//
//// handle device current locale detection
//_speech.setCurrentLocaleHandler((String locale) =>
//setState(() => _currentLocale = locale));
//
//_speech.setRecognitionStartedHandler(()
//=> setState(() => _isListening = true));
//
//// this handler will be called during recognition.
//// the iOS API sends intermediate results,
//// On my Android device, only the final transcription is received
//_speech.setRecognitionResultHandler((String text)
//=> setState(() => transcription = text));
//
//_speech.setRecognitionCompleteHandler(()
//=> setState(() => _isListening = false));
//
//// 1st launch : speech recognition permission / initialization
//_speech
//    .activate()
//.then((res) => setState(() => _speechRecognitionAvailable = res));
////..
//
//speech.listen(locale:_currentLocale).then((result)=> print('result : $result'));
//
//// ...
//
//speech.cancel();
//
//// ||
//
//speech.stop();
