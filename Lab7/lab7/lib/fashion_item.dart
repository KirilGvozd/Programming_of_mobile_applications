abstract class FashionItem {
  String get brand;
  double get price;

  void wear();
}

abstract class Clothes implements FashionItem {
  String size;
  String color;

  Clothes(this.size, this.color);

  void clean();
}

class Shoes extends Clothes {
  String material;
  @override
  String brand;
  @override
  double price;

  Shoes(super.size, super.color, {required this.material, required this.brand, required this.price});

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
}

class Hat extends Clothes {
  String type;
  @override
  String brand;
  @override
  double price;

  Hat(super.size, super.color, {required this.type, required this.brand, required this.price});

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
