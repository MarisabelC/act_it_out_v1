import 'dart:math';

class Category {
  int _index;
  String _language;
  Set<String> _set = {};
  Category(this._index, this._language);

  final _categories = {
    'es_ES': [
      [
        'trompeta',
        'martillo',
        'leche',
        'mecedora',
        'cohete',
        'avión',
        'escalera',
        'depertador',
        'disco',
        'lonchera',
        'pies',
        'piano',
        'sal',
        'guitarra',
        'ambulancia',
        'hombro',
        'carro',
        'bebé',
        'pulsera',
        'carro de mercado',
        'engrapadora',
        'cepillo',
        'tijera',
        'cabello',
        'pelota',
        'flauta',
        'pijamas',
        'lluvia',
        'terremoto',
        'nariz',
        'cono de helado',
        'lentes',
        'oido',
        'bomba',
        'banana',
        'sombrero',
        'mesa de planchar',
        'porrista',
        'reloj',
        'secador de cabello',
        'dinero',
        'violin',
        'silla',
        'telefono',
        'cornetas',
        'brazo',
        'pala',
        'fuego',
        'paleta',
        'tambor',
        'cepillo de diente',
        'tenedor',
      ],
      [
        'la sirenita',
        'el gato con botas',
        'ricitos de oro',
        'monsters inc',
        'hercules',
        'el joven manos de tijera ',
        'jack y las habichuelas magicas',
        'el rey leon',
        'superman',
        'alicia en el pais de las maravillas',
        'cenicienta',
        'dumbo',
        'mi pobre angelito',
        'pinocho',
        'el hombre araña',
        'harry potter',
        'rapunzel',
        'moby dick',
        'vengadores',
        'avatar',
        'aquaman',
      ],
      [
        'payaso',
        'abuela',
        'doctor',
        'vampiro',
        'Papá Noel',
        'zombi',
        'nadador',
        'capitán garfio',
        'bailarin',
        'el grinch',
        'batman',
        'mago',
        'los tres cochinitos',
        'piratas',
        'gigante',
        'homero simpson',
        'harry potter',
        'caperucita roja',
        'blanca nieves',
        'pinocho',
        'dumbo',
        'rapunzel',
        'el hombre increible',
        'lucas',
        'capitán america',
        'la mujer maravilla',
        'aquaman',
        'el hombre araña',
      ],
      [
        'gato',
        'caimán',
        'gallina',
        'vaca',
        'perro',
        'mosquito',
        'tortuga',
        'conejo',
        'pájaro',
        'canguro',
        'tiburón',
        'mono',
        'culebra',
        'pato',
        'rana',
        'araña',
        'pingüino',
        'puerco',
        'elefante',
        'pez',
        'castor',
        'zorro',
        'leopardo',
        'camello',
        'delfín',
        'caballo',
        'ballena'
      ],
      [
        'correr',
        'bailar',
        'aplaudir',
        'susurrar',
        'jugar escondite',
        'reir',
        'cocinar',
        'batear',
        'saltar',
        'pensar',
        'estornudar',
        'rebotar',
        'saludar',
        'tomar una foto',
        'beber',
        'hacer una taza de té',
        'llamar',
        'jugat juego de video',
        'alcanzar',
        'subirse a un montaña rusa',
        'hacer malabar',
        'llorar',
        'dibujar',
        'lavar el cabello',
        'besar',
        'abrazar',
        'dormir',
        'rezar',
        'cabalgar',
        'peinar',
        'hornear una torta',
        'parpadear',
        'pisar fuerte',
        'patear',
        'cortar el cabello',
        'maquillar',
        'lanzar',
        'ir al baño',
        'subir las escaleras',
        'leer',
        'saltar la cuerda',
        'hipar',
        'leer el periódico',
        'bañar al perro',
        'leer la revista',
        'comer pasta',
        'volar',
        'imitar',
        'cepillar los dientes',
        'aspirar',
        'cantar',
        'guiñar',
        'cortar el césped',
        'regar las plantas',
        'toser',
        'detener',
      ],
      [
        'lucha',
        'carrera de caballos',
        'carrera de carros',
        'salto alto',
        'surfear',
        'yoga',
        'bádminton',
        'aeróbicos',
        'ping pong',
        'pescar',
        'fútbol',
        'beisbol',
        'fútbol americano',
        'patinaje sobre hielo',
        'criquet',
        'tenis',
        'remo',
        'baloncesto',
        'nadar',
        'hockey',
        'tiro al arco',
        'patinar',
        'boxeo',
        'esgrima',
        'gimnasia',
        'vóleibol',
        'pesas',
        'ciclismo',
      ],
      ['paso']
    ],
    'en_US': [
      [
        'trumpet',
        'hammer',
        'milk',
        'rocking chair',
        'rocket',
        'airplane',
        'ladder',
        'alarm clock',
        'disco',
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
        'earthquake',
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
      [
        'the little mermaid',
        'puss in boots',
        'the very hungry caterpillar',
        'planes',
        'monsters inc',
        'cars',
        'hercules',
        'edward scissorhands',
        'mickey mouse',
        'jack and the beanstalk',
        'the lion king',
        'superman',
        'alice in wonderland',
        'cinderella',
        'the karate kid',
        "charlotte's web",
        'dumbo',
        'home alone',
        'pinocchio',
        'spider man',
        'harry potter',
        'rapunzel',
        'moby dick',
        'frozen',
      ],
      [
        'vampire',
        'the easter bunny',
        'zombie',
        'swimmer',
        'captain hook',
        'transformer',
        'dancer',
        'darth vader',
        'the grinch',
        'batman',
        'magician',
        'the three bears',
        'pirates',
        'giant',
        'homer simpson',
        'michael jackson',
        'harry potter',
        'woody',
        'snow white',
        'pinocchio',
        'dumbo',
        'rapunzel',
        'hulk',
        'luke',
        'captain america',
        'wonder woman',
        'spider man'
      ],
      [
        'alligator',
        'chicken',
        'cow',
        'dog',
        'mosquito',
        'turtle',
        'rabbit',
        'bird',
        'kangaroo',
        'shark',
        'chimpanzee',
        'snake',
        'duck',
        'cat',
        'frog',
        'spider',
        'penguin',
        'pig',
        'elephant',
        'fish',
        'beaver',
        'fox',
        'cheetah',
        'camel',
        'dolphin',
        'horse',
        'whale'
      ],
      [
        'running',
        'tap dancing',
        'clapping',
        'whispering',
        'hide and seek',
        'giggling',
        'making sandwich',
        'hitting baseball',
        'jumping',
        'thinking',
        'sneezing',
        'bouncing',
        'pinching',
        'waving',
        'taking a selfie',
        'drinking',
        'making a cup of tea',
        'scrolling on a phone',
        'playing video game',
        'cheering',
        'reaching',
        'going on a rollercoaster',
        'juggling',
        'crying',
        'high jump',
        'drawing',
        'washing hair',
        'kissing',
        'hugging',
        'skipping',
        'going to bed',
        'praying',
        'horse riding',
        'brushing hair',
        'baking a cake',
        'winking',
        'stomping',
        'kicking',
        'haircut',
        'putting on makeup',
        'flossing teeth',
        'sprinting',
        'pitching a baseball',
        'farting',
        'going to the bathroom',
        'walking up stairs',
        'reading',
        'jump rope',
        'hiccup',
        'reading the newspaper',
        'washing the dog',
        'reading a magazine',
        'eating spaguetti',
        'flying',
        'miming',
        'hula hooping',
        'cleaning teeth',
        'vacumming',
        'singing karaoke',
        'blinking',
        'mowing the lawn',
        'watering the garden',
        'coughing',
        'stopping',
        'having a nightmare'
      ],
      [
        'rowing',
        'wrestling',
        'horse racing',
        'car racing',
        'high jumping',
        'kayaking',
        'surfing',
        'yoga',
        'badminton',
        'aerobics',
        'ping pong',
        'fishing',
        'soccer',
        'baseball',
        'football',
        'ice hockey',
        'cricket',
        'tennis',
        'hockey sobre hielo',
        'karate',
        'triatlón',
        'golf',
        'ice skating',
        'karate',
        'triathlon',
        'golf',
        'baskeball',
        'swimming',
        'hockey',
        'archery',
        'skateboarding',
        'bowling',
        'boxing',
        'curling',
        'fencing',
        'fitness',
        'gymnastics',
        'volleyball',
        'weightlifting',
        'spinning',
      ],
      ['pass']
    ]
  };

  String getPass(){
    int index= _categories[_language].length-1;
    return _categories[_language][index][0];
  }
  int _generateRandomNumber(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }

  void resetCategory() {
    _set = {};
  }

  String getNextWord() {
    var index = _index;
    if (_index == _categories[_language].length-1)
      index = _generateRandomNumber(_categories.length-1);

    int size = _categories[_language][index].length;
    String word = _categories[_language][index][_generateRandomNumber(size)];
    if (!_set.contains(word)) {
      _set.add(word);
      return word;
    }
    if (size > _set.length) return getNextWord();

    return null;
  }
}
