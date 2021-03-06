import 'dart:io';
import 'categoryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'helpPage.dart';
import 'settingPage.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Act It Out',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Act It Out'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SettingPage _settingPage;
  CategoryPage _categoryPage;
  double _progressValue = 0.0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _settingPage = SettingPage(
      title: 'Setting',
    );
    _updateProgress();
    _categoryPage = CategoryPage(
        title: 'Categories',
        teams: _settingPage.teams,
        language: _settingPage.language,
        startTime: _settingPage.timer);
  }

  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          t.cancel();
          _loading = false;
          return;
        }
      });
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Setting',
      style: optionStyle,
    ),
    Text(
      'Index 1: Help',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => _settingPage));
        break;
      case 1:
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => HelpPage(
                    title: 'How to play',
                    language: _settingPage.language,
                  )),
        );
        break;
    }
  }

  Future<void> _exitApp() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quit'),
          backgroundColor: Colors.blueGrey[400],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to quit?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes', style: TextStyle(color: Colors.white)),
              color: Colors.green,
              onPressed: () {
                exit(0);
              },
            ),
            FlatButton(
              child: Text('No', style: TextStyle(color: Colors.white)),
              color: Colors.red,
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
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 40,
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
              image: AssetImage('images/gradient.jpg'), fit: BoxFit.cover),
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
              child: Visibility(
                visible: !_loading,
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
                      _categoryPage.teams = _settingPage.teams;
                      _categoryPage.startTime = _settingPage.timer;
                      _categoryPage.language = _settingPage.language;
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => _categoryPage),
                      );
                    },
                    child: Text(
                      "Play",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Visibility(
                  visible: _loading,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('loading...'),
                      Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .1,
                              right: MediaQuery.of(context).size.width * .1),
                          child: LinearProgressIndicator(
                            value: _progressValue,
                          )),
                      Text('${(_progressValue * 100).round()}%'),
                    ],
                  ),
                ))
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurpleAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: Colors.white,),
            title: Text('Setting',style: TextStyle(color: Colors.white,)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help,color: Colors.white,),
            title: Text('How to play',style: TextStyle(color: Colors.white,)),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
