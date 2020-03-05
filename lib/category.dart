import 'dart:math';

class Category{

  int _index;
  Set<String> _set ={};
  Category(this._index);

  final categories = [
    [
      'trumpet',
      'hammer',
      'milk',
      'rocking chair',
      'rocket',
      'airplane',
      'ladder',
      'lunchbox',
      'feet',
      'piano',
      'salt',
      'guitar',
      'ambulance',
      'shoulder',
      'car',
      'tail',
      'baby',
      'braces',
      'shopping cart',
      'stapler',
      'broom',
      'cycle',
      'scissors',
      'hair',
      'balloon',
      'flute',
      'pajamas',
      'rain',
      'eartquake',
      'nose',
      'ice cream cone',
      'glasses',
      'ear',
      'ball',
      'banana peel',
      'hat',
      'ironing board',
      'cheerleader',
      'clock',
      'hair dryer',
      'money',
      'fiddle',
      'chair',
      'telephone',
      'clown',
      'elbow',
      'grandma',
      'doctor',
      'horns',
      'arm',
      'shovel',
      'fire',
      'lollipop',
      'drums',
      'queen',
      'hula hoop',
      'toothbrush',
      'fork',
    ],
    ['cat'],
    ['running']
  ];

  int _generateRandomNumber(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }

  void resetCategory(){
    _set={};
  }

  String getNextWord(){
    int size =  categories[_index].length;
    String word = categories[_index][_generateRandomNumber(size)];
    if (!_set.contains(word)) {
      _set.add(word);
      return word;
    }
    if ( size > _set.length)
      return getNextWord();

    return null;

  }
}