import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReadWriteFile{

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/highScore.txt');
  }

  Future<File> writeScores(String data) async {
    final file = await _localFile;
    // Write the file.
    final writeFinal = file.writeAsString(data);
    if (writeFinal != null)
    return writeFinal;
  }

  Future<List<int>> readScores() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      List<int> scores=contents.split(",").map(int.parse).toList();
      return scores;
    } catch (e) {
      print('empty');
      return [0,0,0,0];
    }
  }
}