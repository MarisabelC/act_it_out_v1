import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'gamePage.dart';
import 'category.dart';
import 'scorePage.dart';


class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.title,this.language,this.teams,this.startTime}) : super(key: key);
  final String title;
  final teams;
  final language;
  final startTime;
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

  var _backgroundColor = Colors.deepPurpleAccent;
  int _selectedIndex = 0;
  ScorePage _scorePage = ScorePage( title: 'Score',);


  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    switch (index) {
      case 0:
//        Navigator.push(
//          context,
//          CupertinoPageRoute(
//              builder: (context) => SettingPage(
//                title: 'Setting',
//              )),
//        );
        break;
      case 1:
//        _scorePage.setVisiblility(false);
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => _scorePage));
        break;
    }
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
                  Category category = new Category(index);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => GamePage(category: category,
                              title: '',teams:widget.teams,language:widget.language,startTime:widget.startTime,scorePage:_scorePage
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
