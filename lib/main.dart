import 'package:crossplateforme/mycard.dart';
import 'package:crossplateforme/store.dart';
import 'package:crossplateforme/cart_page.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

void main() {
  runApp(const MyApp());
  print('render');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'E-Commerce'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Store _store;
  final Cart _cart = Cart();

  @override
  void initState() {
    super.initState();
    _store = Store();
  }

  Widget cartIcon() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cart: _cart),
              ),
            );
          },
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(
              minWidth: 18,
              minHeight: 18,
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: _cart.itemCountNotifier,
              builder: (context, count, _) {
                return Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            cartIcon(),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: _store.getProducts(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              } else {
                return _store.products.isNotEmpty
                    ? ListView.builder(
                        itemCount: _store.products.length,
                        itemBuilder: (context, index) {
                          var product = _store.products[index];
                          return MyCard(
                              title: product.title,
                              price: product.price,
                              imageUrl: product.image,
                              onPressed: () {
                                _cart.add(product);
                                print(_cart.itemCountNotifier.value);
                              });
                        },
                      )
                    : const Text("No products");
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
