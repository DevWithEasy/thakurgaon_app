class TouristPlace {
  final int id;
  final String name;
  final String description;
  final String location;
  final String locationFromTo;
  final String image;

  TouristPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.locationFromTo,
    required this.image,
  });

  // Convert JSON to a TouristPlace object
  factory TouristPlace.fromJson(Map<String, dynamic> json) {
    return TouristPlace(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String? ?? '',
      locationFromTo: json['loaction_from_to'] as String? ?? '',
      image: json['image'] as String,
    );
  }

  // Convert a TouristPlace object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'loaction_from_to': locationFromTo,
      'image': image,
    };
  }
}