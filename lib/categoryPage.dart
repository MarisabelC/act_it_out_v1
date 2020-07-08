import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'gamePage.dart';
import 'category.dart';
import 'scorePage.dart';
import 'helpPage.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key, this.title, this.language, this.teams, this.startTime})
      : super(key: key);
  final String title;
  var teams;
  var language;
  var startTime;
  final ScorePage _scorePage = ScorePage(
    title: 'Score',
    teams: [],
  );

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final entries = {
    'en_US': [
      'Objects & Things',
      'Movies & Books',
      'People/Characters',
      'Animals',
      'Actions',
      'Sports',
      'Random'
    ],
    'es_ES': [
      'Objetos & Cosas',
      'Peliculas & Libros',
      'Personajes',
      'Animales',
      'Accion',
      'Deportes',
      'Aleatorio'
    ]
  };
  final icons = [
    'images/object.jpg',
    'images/movie_book.png',
    'images/people.jpg',
    'images/giraffe.jpg',
    'images/action.jpg',
    'images/sport.jpg',
    'images/random.jpg'
  ];
  final colorCodes = [800, 700, 600, 500, 400, 300, 200];

  var _backgroundColor = Colors.deepPurpleAccent;
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => HelpPage(
                    title: 'How to play',language: widget.language,
                  )),
        );
        break;
      case 1:
        widget._scorePage.teams = [];
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => widget._scorePage));
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
          itemCount: entries[widget.language].length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.height / (entries[widget.language].length*1.5),
              color: Colors.blue[colorCodes[index]],
              child: FlatButton(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        icon: Image.asset(icons[index]),
                        iconSize: MediaQuery.of(context).size.height /
                            (entries[widget.language].length * 2),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${entries[widget.language][index]}',
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Category category = new Category(index,widget.language);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => GamePage(
                              category: category,
                              title: '',
                              teams: widget.teams,
                              language: widget.language,
                              startTime: widget.startTime,
                              scorePage: widget._scorePage)));
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
            icon: Icon(Icons.help,color: Colors.white,),
            title: Text('How to play',style: TextStyle(color: Colors.white,)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.score,color: Colors.white,),
            title: Text('Score',style: TextStyle(color: Colors.white,)),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
