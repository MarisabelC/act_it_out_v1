import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'gamePage.dart';
import 'dart:math';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final entries = ['Objects & Things', 'Animals', 'Actions', 'Random'];
  final icons = [
    'images/object.jpg',
    'images/giraffe.jpg',
    'images/action.jpg',
    'images/random.jpg'
  ];
  final colorCodes = [600, 500, 400, 300];

  final categories = [
    [
      'Trumpet',
      'Hammer',
      'Milk',
      'Rocking Chair',
      'Rocket',
      'Airplane',
      'Ladder',
      'Lunchbox',
      'Feet',
      'Piano',
      'Salt',
      'Guitar',
      'Ambulance',
      'Shoulder',
      'Car'
    ],
    ['Cat'],
    ['Running']
  ];
  var _backgroundColor = Colors.deepPurpleAccent;
  Set<String> _set;

  int _selectedIndex = 0;
  int _index = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Setting',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _generateRandomNumber(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }

  String getNextWord(){
    int size = categories[_index].length;
    String word = categories[_index][_generateRandomNumber(size)];
    if (_set.contains(word) && size >_set.length)
      return getNextWord();
    _set.add(word);
    return word;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/gradient.jpg'), fit: BoxFit.cover),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.height / (entries.length * 2),
              color: Colors.blue[colorCodes[index]],
              child: FlatButton(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        icon: Image.asset(icons[index]),
                        iconSize: MediaQuery.of(context).size.height /
                            (entries.length * 3),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${entries[index]}',
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  _set= new HashSet<String>();
                  _index=index;
                  print(getNextWord());
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => GamePage(
                              title: '',
                            )),
                  );
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('Help'),
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
