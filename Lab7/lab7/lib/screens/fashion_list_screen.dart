import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fashion_provider.dart';

class FashionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fashionProvider = Provider.of<FashionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Fashion List')),
      body: ListView.builder(
        itemCount: fashionProvider.items.length,
        itemBuilder: (context, index) {
          final item = fashionProvider.items[index];
          return ListTile(
            title: Text(item.brand),
            subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: index);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                fashionProvider.deleteItem(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/detail');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
