import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/fashion_items.txt');
  }

  Future<void> writeFashionItems(String data) async {
    final file = await _localFile;
    await file.writeAsString(data);
  }

  Future<String> readFashionItems() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      return "Ошибка при чтении: $e";
    }
  }
}
