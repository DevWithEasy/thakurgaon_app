class UddoktaProduct {
  final String id;
  final String entrepreneurId;
  final String name;
  final String category;
  final String description;
  final int price;
  final String image;

  UddoktaProduct({
    required this.id,
    required this.entrepreneurId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });

  factory UddoktaProduct.fromJson(Map<String, dynamic> json) {
    return UddoktaProduct(
      id: json['id'],
      entrepreneurId: json['entrepreneur_id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}