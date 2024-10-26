import 'package:flutter/material.dart';
import 'fashion_item.dart';
import 'file_storage.dart';

class FashionProvider with ChangeNotifier {
  final List<FashionItem> _items = [];
  final FileStorage _fileStorage = FileStorage();

  FashionProvider() {
    loadItemsFromFile();
  }

  List<FashionItem> get items => List.unmodifiable(_items);

  void addItem(FashionItem item) {
    _items.add(item);
    saveItemsToFile();
    notifyListeners();
  }

  void updateItem(int index, FashionItem newItem) {
    _items[index] = newItem;
    saveItemsToFile();
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    saveItemsToFile();
    notifyListeners();
  }

  // Сохранение данных в файл
  void saveItemsToFile() {
    final data = _items.map((item) => "${item.brand}, ${item.price}").join('\n');
    _fileStorage.writeFashionItems(data);
  }

  // Загрузка данных из файла
  Future<void> loadItemsFromFile() async {
    final data = await _fileStorage.readFashionItems();
    if (data.isNotEmpty) {
      final lines = data.split('\n');
      for (var line in lines) {
        final parts = line.split(', ');
        if (parts.length == 2) {
          final brand = parts[0];
          final price = double.tryParse(parts[1]) ?? 0.0;
          _items.add(Bag(brand, price)); // Пример для Bag; добавьте логику для других типов
        }
      }
      notifyListeners();
    }
  }
}
