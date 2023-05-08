import 'package:crossplateforme/mycard.dart';
import 'package:crossplateforme/product.dart';
import 'package:crossplateforme/store.dart';
import 'package:crossplateforme/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
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
  ValueNotifier<String> searchText = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _store = Store();
  }

  Widget cartIcon() {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
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
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          searchText.value = text;
        },
        appBarBuilder: (context) {
          return AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: AppBarWithSearchSwitch.of(context)?.startSearch,
              ),
              cartIcon(),
            ],
          );
        },
      ),
      body: Center(
        child: FutureBuilder(
          future: _store.getProducts(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              } else {
                return ValueListenableBuilder<String>(
                  valueListenable: searchText,
                  builder: (context, searchValue, _) {
                    List<Product> filteredProducts = _store.products
                        .where((product) => product.title
                            .toLowerCase()
                            .contains(searchValue.toLowerCase()))
                        .toList();
                    return filteredProducts.isNotEmpty
                        ? ListView.builder(
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              var product = filteredProducts[index];
                              return MyCard(
                                  title: product.title,
                                  price: product.price,
                                  imageUrl: product.image,
                                  onPressed: () {
                                    _cart.add(product);
                                  });
                            },
                          )
                        : const Text("No products");
                  },
                );
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
