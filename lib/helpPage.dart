import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key key, this.title, this.language}) : super(key: key);
  final String title;
  final String language;
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  var _backgroundColor = Colors.deepPurpleAccent;

  var _rules = {'en_US':[
    'Players divided into two or more exclusive teams.',
    'A silent performance by the player to his or her teammates.'
        'To enforce a focus on physical acting out of the clues, silent mouthing of the words for lipreading,'
        ' spelling, and pointing are banned.',
    'A timer is used to limit the teams guesses.',
    'If a team member says the guessed word, a new word appears on the screen. ',
    'If team members do not know the word, they can say "pass" to get a new word.',
    'Points: one for every correctly guessed answer and one for every answer the opposing team failed to guess within the allotted time.'],
    'es_ES':['Los jugadores se dividen en 2 o mas equipos',
      'El objetivo es lograr que tu equipo adivine la respuesta usando solamente gestos.'
          'Cuando un jugador actúa una palabra o frase, ¡no tiene permitido hablar, apuntar o deletrear',
      'Cada equipo tiene un limite de tiempo para adivinar las palabras',
      'Si un miembro del equipo adivina la palabra o frase, una nueva palabra o frase aparecera en la pantalla',
      'Si los miembros del equipo no adivinan la palabra o frase, ellos pueden decir "paso" y una nueva palabra aperecera en la pantalla',
      'Puntos: un punto por cada palabra acertada y un punto para los equipos contrario por cada palabra o frase que el equipo no adivine'

  ]};
  @override
  Widget build(BuildContext context) {

    var screenHeight= MediaQuery.of(context).size.height/10;
    final List<double> _height = [screenHeight, 2.5*screenHeight, screenHeight, screenHeight, 1.5*screenHeight, 2*screenHeight];

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
          child: ListView.builder(
              itemCount: _rules[widget.language].length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: _height[index],
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      '${_rules[widget.language][index]}',
                      style: TextStyle(fontSize: 20),
                    ));
              })),
    );
  }
}
