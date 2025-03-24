class CoachingCenter {
  final String id;
  final String name;
  final String location;
  final String contact;
  final String email;
  final String upazilla;

  CoachingCenter({
    required this.id,
    required this.name,
    required this.location,
    required this.contact,
    required this.email,
    required this.upazilla,
  });

  factory CoachingCenter.fromJson(Map<String, dynamic> json) {
    return CoachingCenter(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      contact: json['contact'],
      email: json['email'],
      upazilla: json['upazilla'],
    );
  }
}