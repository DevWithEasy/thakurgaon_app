class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final String location;
  final String upazilla;
  final String contact;
  final String email;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.location,
    required this.upazilla,
    required this.contact,
    required this.email,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
      location: json['location'],
      upazilla: json['upazilla'],
      contact: json['contact'],
      email: json['email'],
    );
  }
}