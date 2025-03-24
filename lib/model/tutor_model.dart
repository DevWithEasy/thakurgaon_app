class Tutor {
  final String id;
  final String name;
  final String subject;
  final String location;
  final String upazilla;
  final String contact;
  final String email;

  Tutor({
    required this.id,
    required this.name,
    required this.subject,
    required this.location,
    required this.upazilla,
    required this.contact,
    required this.email,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      location: json['location'],
      upazilla: json['upazilla'],
      contact: json['contact'],
      email: json['email'],
    );
  }
}