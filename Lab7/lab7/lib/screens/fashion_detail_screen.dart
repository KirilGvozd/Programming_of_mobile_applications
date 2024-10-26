import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fashion_provider.dart';
import '../fashion_item.dart';

class FashionDetailScreen extends StatefulWidget {
  @override
  _FashionDetailScreenState createState() => _FashionDetailScreenState();
}

class _FashionDetailScreenState extends State<FashionDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _brand = '';
  double _price = 0.0;

  @override
  Widget build(BuildContext context) {
    final fashionProvider = Provider.of<FashionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Fashion Item')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Brand'),
                onSaved: (value) => _brand = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value ?? '0'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  final newItem = Bag(_brand, _price);
                  fashionProvider.addItem(newItem);
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
