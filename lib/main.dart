import 'package:crossplateforme/mycard.dart';
import 'package:crossplateforme/store.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'E-Commerce'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
            // Vous pouvez naviguer vers la page du panier ici
            print(_cart.items.length);
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
            child: Text(
              "${_cart.items.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
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
                // Display an error message if something went wrong
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
                                print(_cart.items.length);
                              });
                        },
                      )
                    : const Text("No products");
              }
            } else {
              return const CircularProgressIndicator(); // Show a loading indicator while waiting for products
            }
          },
        ),
      ),
    );
  }
}
