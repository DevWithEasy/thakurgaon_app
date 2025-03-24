class Surveyor {
  final String id;
  final String name;
  final String specialization;
  final String location;
  final String upazilla;
  final String contact;
  final String email;

  Surveyor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.location,
    required this.upazilla,
    required this.contact,
    required this.email,
  });

  factory Surveyor.fromJson(Map<String, dynamic> json) {
    return Surveyor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      location: json['location'],
      upazilla: json['upazilla'],
      contact: json['contact'],
      email: json['email'],
    );
  }
}