class Institute {
  final String id;
  final String name;
  final String type;
  final String upazilla;
  final String location;
  final String contact;
  final String email;

  Institute({
    required this.id,
    required this.name,
    required this.type,
    required this.upazilla,
    required this.location,
    required this.contact,
    required this.email,
  });

  // Factory constructor to create an object from JSON
  factory Institute.fromJson(Map<String, dynamic> json) {
    return Institute(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      upazilla: json['upazilla'],
      location: json['location'],
      contact: json['contact'],
      email: json['email'],
    );
  }

  // Convert an object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'upazilla': upazilla,
      'location': location,
      'contact': contact,
      'email': email,
    };
  }
}
