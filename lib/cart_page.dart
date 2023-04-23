import 'package:crossplateforme/cart.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Cart cart;

  const CartPage({super.key, required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panier')),
      body: ValueListenableBuilder<int>(
        valueListenable: widget.cart.itemCountNotifier,
        builder: (context, value, child) {
          return widget.cart.items.isNotEmpty
              ? ListView.builder(
                  itemCount: widget.cart.items.length,
                  itemBuilder: (context, index) {
                    var item = widget.cart.items[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item.product.image),
                      ),
                      title: Text(item.product.title),
                      subtitle: Text('Prix: ${item.product.price} €'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              widget.cart.remove(item.product);
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              widget.cart.add(item.product);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const Center(child: Text('Votre panier est vide.'));
        },
      ),
      bottomNavigationBar: widget.cart.items.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder<int>(
                valueListenable: widget.cart.itemCountNotifier,
                builder: (context, value, child) {
                  return SafeArea(
                    child: Text(
                      'Total: ${widget.cart.getTotalPrice().toStringAsFixed(2)} €',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            )
          : null,
    );
  }
}
