import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'team.dart';

class ScorePage extends StatefulWidget {
  ScorePage({Key key, this.title, this.teams}) : super(key: key);
  final String title;
  List<Team> teams = [];
  final colors = [Colors.blue[300], Colors.red[400], Colors.lightGreen[400], Colors.amber[300]];

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final scores = [0, 0, 0, 0, 0];
  var _backgroundColor = Colors.deepPurpleAccent;
  final _places = ['1st', '2nd', '3rd', '4th', '5th'];

  @override
  Widget build(BuildContext context) {
//    final _height =
//        MediaQuery.of(context).size.height / (_entries.length * 1.5);
    final _width = MediaQuery.of(context).size.width;

    void replaceHighScore() {
      setState(() {
        for (var team in widget.teams) {
          for (int i = 0; i < scores.length; i++) {
            if (team.getScore() > scores[i]) {
              scores.insert(i, team.getScore());
              scores.removeLast();
            }
          }
        }
      });
    }

    @override
    void initState() {
      super.initState();
      replaceHighScore();
    }

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

    Text getHighScoreText(){
      replaceHighScore();
      return Text(
          ' High Scores',
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
                      child:getHighScoreText(),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        left: _width * .05,
                        right: _width * .05,
                      ),
                      itemCount: scores.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: (MediaQuery.of(context).size.height / 2) /
                              scores.length,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Text(
                                  _places[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  ' ${scores[index]}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
              flex: 2,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  right: _width * .05,
                  bottom: MediaQuery.of(context).size.height * .1,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: getNumberOfTeam(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width:
                    MediaQuery.of(context).size.width / 2,
                    color: widget.colors[index],
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Team  ${widget.teams[index].id + 1} ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              ' ${widget.teams[index].getScore()}',
                              style: TextStyle(fontSize: 35),
                            ),
                          ],
                        )),
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
