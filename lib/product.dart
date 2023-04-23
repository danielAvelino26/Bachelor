class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;

  Product(this.title, this.description, this.id, this.price, this.category,
      this.image);

  Product.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        id = json['id'],
        price = double.parse(json['price'].toString()),
        category = json['category'],
        image = json['image'];
}
