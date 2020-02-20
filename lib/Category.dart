import 'dart:math';

class Category{

  int _index;
  Set<String> _set = new Set<String>();
  Category(this._index);

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
      'Car',
      'Tail',
      'Yo-Yo',
      'Baby',
      'Braces',
      'Shopping Cart',
      'Stapler',
      'Broom',
      'Cicle',
      'Scissors',
      'Hair',
      'Ballon',
      'Flute',
      'Pyjamas',
      'Rain',
      'Eartquake',
      'Nose',
      'Ice Cream Cone',
      'Glasses',
      'Ear',
      'Ball',
      'Banana Peel',
      'Hat',
      'Ironing Board',
      'Cheerleader',
      'Clock',
      'Hair Dryer',
      'Money',
      'Fiddle',
      'Chair',
      'Telephone',
      'Clown',
      'Elbow',
      'Grandma',
      'Doctor',
      'Horns',
      'Arm',
      'Shovel',
      'Fire',
      'Lollipop',
      'Drums',
      'Queen',
      'Hula Hoop',
      'ToothBrush',
      'Fork',
    ],
    ['Cat'],
    ['Running']
  ];

  int _generateRandomNumber(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }

  String getNextWord(){
    int size =  categories[_index].length;
    String word = categories[_index][_generateRandomNumber(size)];
    if (_set.contains(word) && size >_set.length)
      return getNextWord();
    _set.add(word);
    return word;
  }
}