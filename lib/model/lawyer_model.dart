class Lawyer {
  final String id;
  final String name;
  final String specialization;
  final String location;
  final String upazilla;
  final String contact;
  final String email;

  Lawyer({
    required this.id,
    required this.name,
    required this.specialization,
    required this.location,
    required this.upazilla,
    required this.contact,
    required this.email,
  });

  // Factory method to create a Lawyer object from JSON
  factory Lawyer.fromJson(Map<String, dynamic> json) {
    return Lawyer(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      location: json['location'],
      upazilla: json['upazilla'],
      contact: json['contact'],
      email: json['email'],
    );
  }

  // Method to convert a Lawyer object back to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'location': location,
      'upazilla': upazilla,
      'contact': contact,
      'email': email,
    };
  }
}