class Uddokta {
  final String id;
  final String name;
  final String business;
  final String location;
  final String upazilla;
  final String contact;
  final String email;
  final String image;

  Uddokta({
    required this.id,
    required this.name,
    required this.business,
    required this.location,
    required this.upazilla,
    required this.contact,
    required this.email,
    required this.image,
  });

  factory Uddokta.fromJson(Map<String, dynamic> json) {
    return Uddokta(
      id: json['id'],
      name: json['name'],
      business: json['business'],
      location: json['location'],
      upazilla: json['upazilla'],
      contact: json['contact'],
      email: json['email'],
      image: json['image'],
    );
  }
}