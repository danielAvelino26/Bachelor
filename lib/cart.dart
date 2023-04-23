import 'dart:async';
import 'package:crossplateforme/product.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}

// create a class Cart that contains a product and a quantity
class Cart {
  final List<CartItem> items = [];
  ValueNotifier<int> itemCountNotifier = ValueNotifier(0);

  // add a product to the cart, if it already exists, increase the quantity
  void add(Product product) {
    var item =
        items.firstWhereOrNull((element) => element.product.id == product.id);

    if (item == null) {
      items.add(CartItem(product, 1));
    } else {
      item.quantity++;
    }
  }

  // remove a product from the cart, if the quantity is 1, remove the product
  void remove(Product product) {
    var item =
        items.firstWhereOrNull((element) => element.product.id == product.id);

    if (item != null) {
      if (item.quantity == 1) {
        items.remove(item);
      } else {
        item.quantity--;
      }
    }
  }

  // return the total price of the cart
  double getTotalPrice() {
    return items.fold(0, (previousValue, element) {
      return previousValue + element.product.price * element.quantity;
    });
  }
}
