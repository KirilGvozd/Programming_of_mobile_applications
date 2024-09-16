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

  Shoes(super.size, super.color, this.material, {required this.brand, required this.price});

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

void calculateTotalPrice(List<FashionItem?> items) {
  try {
    double total = items.fold(0.0, (sum, item) {
      if (item == null) {
        throw Exception("Товар не может быть null");
      }
      return sum + item.price;
    });
    print("Общая сумма: \$${total.toStringAsFixed(2)}");
  } catch (e) {
    print("Произошла ошибка: $e");
  }
}

void applyDiscount(List<FashionItem> items, double Function(double) discountFunction, {double minimumPrice = 50.0}) {
  for (var item in items) {
    if (item.price >= minimumPrice) {
      double discountedPrice = discountFunction(item.price);
      print("Товар ${item.brand} со скидкой: \$${discountedPrice.toStringAsFixed(2)} (изначально \$${item.price.toStringAsFixed(2)})");
    } else {
      print("Товар ${item.brand} не подходит для скидки, цена: \$${item.price.toStringAsFixed(2)}");
    }
  }
}

void main() {
  List<Shoes> shoesCollection = [
    Shoes('42', 'Black', 'Leather', brand: 'Nike', price: 100.0),
    Shoes('41', 'White', 'Canvas', brand: 'Adidas', price: 80.0),
    Shoes('41', 'Pink', 'Leather', brand: 'ASICS', price: 40.0),
  ];

  List<FashionItem?> items = [
    Shoes('42', 'Black', 'Leather', brand: 'Nike', price: 100.0),
    null
  ];

  calculateTotalPrice(items);

  double tenPercentDiscount(double price) {
    return price * 0.9;
  }

  applyDiscount(shoesCollection, tenPercentDiscount, minimumPrice: 60.0);

  shoesCollection.forEach((shoes) => shoes.wear());

  Set<String> brands = {'Nike', 'Adidas', 'Puma'};
  brands.add('Nike');
  print(brands);

  checkShoesSizes(shoesCollection);

  Bag bag = Bag('Gucci', 500.0);
  bag.pack(numberOfItems: 5);

  calculateTotalPrice([bag, shoesCollection[0], shoesCollection[1]]);

  Shoes.incrementSold();
  Shoes.incrementSold();
  print("Всего продано обуви: ${Shoes.totalShoesSold}");
}