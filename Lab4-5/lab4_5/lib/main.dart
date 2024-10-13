import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFT Mockup',
      theme: ThemeData(
        fontFamily: 'Arial', // Используй любой шрифт, который тебе подходит
        primarySwatch: Colors.blue,
      ),
      home: PageOne(),
    );
  }
}

// Первая страница
class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'nolade.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://shorturl.at/t9YtA', // Ссылка на аватарку
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'EXPLORE THE ',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(Icons.whatshot, color: Colors.red, size: 36),
                  ),
                  TextSpan(
                    text: ' MOST POPULAR\nNFT.',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    'https://shorturl.at/t9YtA', // Болванка для аватара
                  ),
                ),
                SizedBox(width: 10),
                Text('@laydesigner', style: TextStyle(fontSize: 16, color: Colors.black54)),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: Text(
                    'New',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                // Контейнер с изображением
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16), // Обрезаем изображение по границе контейнера
                    child: Image.network(
                      'https://shorturl.at/PpUYB', // Болванка для изображения
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Овалы поверх изображения
                Positioned(
                  top: 16, // Отступ сверху
                  left: 16, // Отступ слева
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white, // Цвет фона овала
                      borderRadius: BorderRadius.circular(30), // Делаем овальной формы
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12, // Тень для объема
                          spreadRadius: 2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      '25',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),

                Positioned(
                  top: 16, // Отступ сверху (чтобы на одном уровне)
                  right: 16, // Отступ справа
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5), // Цвет фона овала
                      borderRadius: BorderRadius.circular(30), // Делаем овальной формы
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12, // Тень для объема
                          spreadRadius: 2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          '785 Volume',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(height: 30),
            Text(
              '00:29:14',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 30),
            // Кнопка перехода на вторую страницу
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageTwo()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'View NFT',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Вторая страница

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Изображение на заднем фоне
          Positioned.fill(
            child: Image.network(
              'https://shorturl.at/lQVXm', // Болванка для фонового изображения
              fit: BoxFit.cover,
            ),
          ),

          // Верхний блок с заголовком и иконками
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Левая часть: кнопка назад и заголовок
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10),
                      Text(
                        '@laydesigner',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Правая часть: аватарка и кнопка "сердце"
                  Row(
                    children: [
                      // Кнопка избранного (сердце)
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {
                          // Действие при нажатии на кнопку "сердце"
                        },
                      ),

                      // Аватарка
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150', // Болванка для аватарки
                        ),
                        radius: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Остальные элементы страницы
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок "Monkey Hypebeast"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Monkey Hypebeast',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: 20),

              // Таймер
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '02:35:56',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left, // Выравнивание текста влево
                ),
              ),

              SizedBox(height: 40),

              // Квадраты с информацией
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Первый квадрат с информацией
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white, // Полупрозрачный черный цвет
                        borderRadius: BorderRadius.circular(16), // Скругленные края
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Floor price',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '3.52 ETH',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16),
                          // Красный овал с показателями
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.red, // Красный фон для овала
                              borderRadius: BorderRadius.circular(50), // Овальная форма
                            ),
                            child: Text(
                              '-12%', // Пример показателя
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Второй квадрат с информацией
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5), // Полупрозрачный черный цвет
                        borderRadius: BorderRadius.circular(16), // Скругленные края
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sales',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '456',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 24),
                          // Красный овал с показателями
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green, // Красный фон для овала
                              borderRadius: BorderRadius.circular(50), // Овальная форма
                            ),
                            child: Text(
                              '+5%', // Пример показателя
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Нижняя часть с овалом и кругом
          Positioned(
            bottom: 30, // Положение элементов
            left: 30,
            right: 30,
            child: Stack(
              children: [
                // Овал (Volume)
                Container(
                  width: 180,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50), // Овальная форма
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    '785 Volume',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Круг, который накладывается на овал (иконка ETH)
                Positioned(
                  right: 140,
                  top: 2,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.attach_money,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

