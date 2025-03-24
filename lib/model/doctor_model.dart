class Doctor {
  final int id;
  final String name;
  final List<String> specialization;
  final String designation;
  final String department;
  final String hospital;
  final List<String> qualifications;
  final String experience;
  final List<Chamber> chambers;
  final String about;
  final List<String> languages;
  final String image;
  final String contact;
  final String email;
  final String consultationFee;
  final String upazilla;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.designation,
    required this.department,
    required this.hospital,
    required this.qualifications,
    required this.experience,
    required this.chambers,
    required this.about,
    required this.languages,
    required this.image,
    required this.contact,
    required this.email,
    required this.consultationFee,
    required this.upazilla,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: List<String>.from(json['specialization']),
      designation: json['designation'],
      department: json['department'],
      hospital: json['hospital'],
      qualifications: List<String>.from(json['qualifications']),
      experience: json['experience'],
      chambers: (json['chambers'] as List)
          .map((chamber) => Chamber.fromJson(chamber))
          .toList(),
      about: json['about'],
      languages: List<String>.from(json['languages']),
      image: json['image'],
      contact: json['contact'],
      email: json['email'],
      consultationFee: json['consultationFee'],
      upazilla: json['upazilla'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'designation': designation,
      'department': department,
      'hospital': hospital,
      'qualifications': qualifications,
      'experience': experience,
      'chambers': chambers.map((chamber) => chamber.toJson()).toList(),
      'about': about,
      'languages': languages,
      'image': image,
      'contact': contact,
      'email': email,
      'consultationFee': consultationFee,
      'upazilla': upazilla,
    };
  }
}

class Chamber {
  final String name;
  final String address;
  final String contact;
  final String visitingHours;

  Chamber({
    required this.name,
    required this.address,
    required this.contact,
    required this.visitingHours,
  });

  factory Chamber.fromJson(Map<String, dynamic> json) {
    return Chamber(
      name: json['name'],
      address: json['address'],
      contact: json['contact'],
      visitingHours: json['visiting_hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'contact': contact,
      'visiting_hours': visitingHours,
    };
  }
}
