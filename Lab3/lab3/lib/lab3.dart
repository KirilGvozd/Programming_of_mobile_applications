import 'dart:convert';
import 'dart:async';

class FashionStore {
  final StreamController<String> _singleController = StreamController<String>();

  Stream<String> get singleSubscriptionStream => _singleController.stream;

  void addNewItem(String item) {
    _singleController.sink.add(item);
  }

  void close() {
    _singleController.close();
  }
}

class BroadcastFashionStore {
  final StreamController<String> _broadcastController = StreamController<String>.broadcast();

  Stream<String> get broadcastStream => _broadcastController.stream;

  void addNewItem(String item) {
    _broadcastController.sink.add(item);
  }

  void close() {
    _broadcastController.close();
  }
}

abstract class FashionItem {
  String get brand;
  double get price;

  void wear();
}

// Mixin Discount
mixin Discount {
  double applyDiscount(double price, double discountPercentage) {
    return price * (1 - discountPercentage / 100);
  }
}

// Mixin Seasonal
mixin Seasonal {
  String season = "All Seasons";

  void setSeason(String season) {
    this.season = season;
  }

  void displaySeason() {
    print("Сезон: $season");
  }
}

abstract class Clothes implements FashionItem, Seasonal {
  String size;
  String color;

  Clothes(this.size, this.color);

  void clean();
}

class Shoes extends Clothes with Discount, Seasonal implements Comparable<Shoes> {
  String material;
  String brand;
  double price;

  Shoes(String size, String color, this.material, {required this.brand, required this.price})
      : super(size, color);

  @override
  void wear() {
    print("Надели обувь от $brand за \$${price.toStringAsFixed(2)}.");
  }

  @override
  void clean() {
    print("Чистим обувь из $material.");
  }

  static int totalShoesSold = 0;

  static void incrementSold() {
    totalShoesSold++;
  }

  @override
  int compareTo(Shoes other) {
    return price.compareTo(other.price);
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'color': color,
      'material': material,
      'brand': brand,
      'price': price,
    };
  }

  factory Shoes.fromJson(Map<String, dynamic> json) {
    return Shoes(
      json['size'],
      json['color'],
      json['material'],
      brand: json['brand'],
      price: json['price'],
    );
  }

  Future<void> fetchData() async {
    print("Начинается загрузка данных о товаре...");
    await Future.delayed(const Duration(seconds: 5));
    print("Данные о товаре загружены для $brand.");
  }
}

class Hat extends Clothes with Seasonal {
  String type;
  String brand;
  double price;

  Hat({required this.type, String size = 'M', required String color, required this.brand, required this.price})
      : super(size, color);

  @override
  void wear() {
    print("Надели $type от $brand за \$${price.toStringAsFixed(2)}.");
  }

  @override
  void clean() {
    print("Чистим головной убор.");
  }
}

class Bag implements FashionItem {
  String _brand;
  double _price;

  Bag(this._brand, this._price);

  @override
  String get brand => _brand;

  set brand(String value) => _brand = value;

  @override
  double get price => _price;

  set price(double value) => _price = value;

  @override
  void wear() {
    print("Носим сумку от $_brand.");
  }

  void pack({int numberOfItems = 3}) {
    print("Пакуем $numberOfItems вещей в сумку от $_brand.");
  }
}

class FashionCollection extends Iterable<FashionItem> {
  List<FashionItem> _items;

  FashionCollection(this._items);

  @override
  Iterator<FashionItem> get iterator => _FashionIterator(_items);
}

class _FashionIterator implements Iterator<FashionItem> {
  final List<FashionItem> _items;
  int _currentIndex = -1;

  _FashionIterator(this._items);

  @override
  bool moveNext() {
    _currentIndex++;
    return _currentIndex < _items.length;
  }

  @override
  FashionItem get current {
    if (_currentIndex >= 0 && _currentIndex < _items.length) {
      return _items[_currentIndex];
    }
    throw RangeError('Индекс $_currentIndex вне диапазона коллекции');
  }
}

void checkShoesSizes(List<Shoes> shoesCollection) {
  for (var shoes in shoesCollection) {
    if (shoes.size == '42') {
      print('Обнаружен размер 42!');
      break;
    }
    if (shoes.size == '41') {
      continue;
    }
    print('Размер обуви: ${shoes.size}');
  }
}

void calculateTotalPrice(List<FashionItem> items) {
  try {
    double total = items.fold(0.0, (sum, item) => sum + item.price);
    print("Общая сумма: \$${total.toStringAsFixed(2)}");
  } catch (e) {
    print("Произошла ошибка: $e");
  }
}

void main() async {
  List<Shoes> shoesCollection = [
    Shoes('42', 'Black', 'Leather', brand: 'Nike', price: 100.0),
    Shoes('41', 'White', 'Canvas', brand: 'Adidas', price: 80.0)
  ];

  // Comparable realization
  shoesCollection.sort();
  print("Сортированные туфли по цене:");
  for (var shoes in shoesCollection) {
    print('${shoes.brand}: \$${shoes.price}');
  }

  var shoes1 = Shoes('42', 'Black', 'Leather', brand: 'Nike', price: 100.0);
  var shoes2 = Shoes('41', 'White', 'Canvas', brand: 'Adidas', price: 80.0);
  var shoes3 = Shoes('40', 'Blue', 'Suede', brand: 'Puma', price: 120.0);
  var fashionItems = FashionCollection([shoes1, shoes2, shoes3]);

  // Iterable realization
  print("Перебор коллекции моды:");
  for (var item in fashionItems) {
    item.wear();
  }

  shoesCollection.forEach((shoes) => shoes.wear());

  // Mixins classes
  shoesCollection[0].setSeason('Winter');
  shoesCollection[0].displaySeason();

  double discountedPrice = shoesCollection[0].applyDiscount(shoesCollection[0].price, 10);
  print("Цена обуви со скидкой: \$${discountedPrice.toStringAsFixed(2)}");

  Bag bag = Bag('Gucci', 500.0);
  bag.pack(numberOfItems: 5);

  calculateTotalPrice([bag, shoesCollection[0], shoesCollection[1]]);

  Shoes.incrementSold();
  Shoes.incrementSold();
  print("Всего продано обуви: ${Shoes.totalShoesSold}");

  // Serialization to JSON
  var jsonString = jsonEncode(shoes3.toJson());
  print("Сериализованный объект Shoes в JSON: $jsonString");

  // Deserialization from JSON
  var jsonData = '{"size":"42","color":"Black","material":"Leather","brand":"Nike","price":100.0}';
  var deserializedShoes = Shoes.fromJson(jsonDecode(jsonData));
  print("Десериализованный объект Shoes из JSON: ${deserializedShoes.brand}, цена: \$${deserializedShoes.price}");

  // Async await realization
  await shoes2.fetchData();
  print("Shoes after fetching the data.");
  shoes2.wear();

  // Single Subscription
  var fashionStore = FashionStore();

  fashionStore.singleSubscriptionStream.listen((item) {
    print("Single Subscription Stream: Новый товар поступил: $item");
  });

  fashionStore.addNewItem("Nike Shoes");
  fashionStore.addNewItem("Adidas T-shirt");

  // Broadcast Stream
  var broadcastFashionStore = BroadcastFashionStore();

  broadcastFashionStore.broadcastStream.listen((item) {
    print("Broadcast Stream - Подписчик 1: Новый товар поступил: $item");
  });

  broadcastFashionStore.broadcastStream.listen((item) {
    print("Broadcast Stream - Подписчик 2: Новый товар поступил: $item");
  });

  broadcastFashionStore.addNewItem("Puma Shoes");
  broadcastFashionStore.addNewItem("Reebok Shorts");

  await Future.delayed(const Duration(seconds: 5));
  fashionStore.close();
  broadcastFashionStore.close();
}
