class Category {
  final int id;
  final String title;
  final String route;
  final String image;
  final List<CategoryItem> items;

  Category({
    required this.id,
    required this.title,
    required this.route,
    required this.image,
    required this.items,
  });

  // Factory method to create a Category object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      route: json['route'],
      image: json['image'],
      items: (json['items'] as List)
          .map((item) => CategoryItem.fromJson(item))
          .toList(),
    );
  }

  // Convert a Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'route': route,
      'image': image,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CategoryItem {
  final String title;
  final String route;
  final String image;

  CategoryItem({
    required this.title,
    required this.route,
    required this.image,
  });

  // Factory method to create a CategoryItem object from JSON
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      title: json['title'],
      route: json['route'],
      image: json['image'],
    );
  }

  // Convert a CategoryItem object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'route': route,
      'image': image,
    };
  }
}