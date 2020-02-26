
class Team{
  Score _score = Score();
  final int id;
  Team(this.id);

  void incrementScore(){
    _score.incrementScore();
  }

  int getScore(){
    return _score.getScore();
  }

}

class Score{
  int _score=0;

  void incrementScore(){
    _score += 1 ;
  }

  int getScore(){
    print(_score);
    return _score;
  }
}