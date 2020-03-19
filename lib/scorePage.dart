import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'team.dart';
import 'readWriteFile.dart';

class ScorePage extends StatefulWidget {
  ScorePage({Key key, this.title, this.teams}) : super(key: key);
  bool isRead = false;
  final String title;
  List<Team> teams = [];
  final colors = [
    Colors.blue[300],
    Colors.pink[200],
    Colors.lightGreen[400],
    Colors.amber[200],
    Colors.grey
  ];
  List<int> _scores = [];
  ReadWriteFile _file = ReadWriteFile();
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  List<String> _newScores = ['', '', '', ''];
  var _backgroundColor = Colors.deepPurpleAccent;
  final _places = ['1st', '2nd', '3rd', '4th'];

  @override
  void initState() {
    super.initState();
    widget._file.readScores().then((List<int> value) {
      _updateScore(value);
    });
  }

  void _updateScore(value) {
    setState(() {
      widget._scores = value;
      print('no empty' + widget._scores.toString());
    });
  }

  void replaceHighScore() {
    print('replace' + widget._scores.toString());
    setState(() {
      if (widget.teams != null)
        for (var team in widget.teams) {
          for (int i = 0; i < widget._scores.length; i++) {
            if (team.getScore() > widget._scores[i]) {
              widget._scores.insert(i, team.getScore());
              _newScores.insert(i, 'NEW');
              print('new');
              widget._scores.removeLast();
              break;
            }
          }
        }
    });
    String data = widget._scores.map((i) => i.toString()).join(",");
    widget._file.writeScores(data);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    BoxDecoration boxDecoration() {
      return BoxDecoration(
        color: Colors.blue[400],
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      );
    }

    getNumberOfTeam() {
      if (widget.teams != null) return widget.teams.length;
      return 0;
    }

    Text getHighScoreText() {
      if (widget.isRead == false) {
        replaceHighScore();
        setState(() => widget.isRead = true);
      }
      return Text(' High Scores',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ));
    }

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
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: getHighScoreText(),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        left: _width * .05,
                        right: _width * .05,
                      ),
                      itemCount: widget._scores.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: (MediaQuery.of(context).size.height / 2) /
                              (widget._scores.length + 1),
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Text(
                                  '\t' + _places[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  ' ${widget._scores[index]}  ',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    ' ${_newScores[index]}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return new GridView.builder(
                    itemCount: getNumberOfTeam(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          constraint.maxWidth / constraint.maxHeight,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        color: widget.colors[index],
                        margin: EdgeInsets.all(4.0),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Team  ${widget.teams[index].id} ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              ' ${widget.teams[index].getScore()}',
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                          ],
                        )),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
