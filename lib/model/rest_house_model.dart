class RestHouse {
  final String id;
  final String name;
  final String location;
  final String upazilla;
  final String contact;
  final String email;
  final int rooms;
  final List<String> amenities;

  RestHouse({
    required this.id,
    required this.name,
    required this.location,
    required this.upazilla,
    required this.contact,
    required this.email,
    required this.rooms,
    required this.amenities,
  });

  factory RestHouse.fromJson(Map<String, dynamic> json) {
    return RestHouse(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      upazilla: json['upazilla'],
      contact: json['contact'],
      email: json['email'],
      rooms: json['rooms'],
      amenities: List<String>.from(json['amenities']),
    );
  }
}