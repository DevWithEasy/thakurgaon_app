class Hospital {
  final String name;
  final String address;
  final List<String> contact;
  final String email;
  final String type;
  final String upazilla;
  final List<int> doctors;

  Hospital({
    required this.name,
    required this.address,
    required this.contact,
    required this.email,
    required this.type,
    required this.upazilla,
    required this.doctors,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'] as String,
      address: json['address'] as String,
      contact: List<String>.from(json['contact'] as List<dynamic>),
      email: json['email'] as String,
      type: json['type'] as String,
      upazilla: json['upazilla'] as String,
      doctors: List<int>.from(json['doctors'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'contact': contact,
      'email': email,
      'type': type,
      'upazilla': type,
      'doctors': doctors,
    };
  }
}