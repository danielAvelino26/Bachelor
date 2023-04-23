import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crossplateforme/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//StreamBuilder already prepared for the Store
class StoreStreamBuilder<T> extends StatelessWidget {
  final Widget Function(Store?) builder;

  const StoreStreamBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Store>(
        initialData: Store(),
        stream: Store().getStream(),
        builder: (context, snapshot) => builder(snapshot.data));
  }
}

class Store {
  // Private Constructor and instance declarations
  Store._privateConstructor();
  static final Store _instance = Store._privateConstructor();
  factory Store() {
    return _instance;
  }

  //Stream declarations
  StreamController<Store> storeStreamController =
      StreamController<Store>.broadcast();
  Stream<Store> getStream() {
    return storeStreamController.stream;
  }

  void update() {
    storeStreamController.sink.add(_instance);
  }

  StoreStreamBuilder builder(Widget Function(Store?) builderFunction) {
    return StoreStreamBuilder(builder: builderFunction);
  }

  // START EDITING HERE

  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var products = (jsonDecode(response.body) as List)
          .map((e) => Product.fromJson(e))
          .toList();
      return products;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  //Properties
  List<Product> products = [];

  Future<void> getProducts() async {
    products = await fetchProducts();
    update();
  }
}
