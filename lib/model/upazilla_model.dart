class Upazilla {
  final int id;
  final String name;
  final String bnName; // Bangla name
  final String url;

  Upazilla({
    required this.id,
    required this.name,
    required this.bnName,
    required this.url,
  });

  // Convert JSON to a Upazilla object
  factory Upazilla.fromJson(Map<String, dynamic> json) {
    return Upazilla(
      id: json['id'] as int,
      name: json['name'] as String,
      bnName: json['bn_name'] as String,
      url: json['url'] as String,
    );
  }

  // Convert a Upazilla object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bn_name': bnName,
      'url': url,
    };
  }
}