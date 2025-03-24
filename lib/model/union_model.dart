class Union {
  final int id;
  final int upazillaId;
  final String name;
  final String bnName; // Bangla name
  final String url;

  Union({
    required this.id,
    required this.upazillaId,
    required this.name,
    required this.bnName,
    required this.url,
  });

  // Convert JSON to an Union object
  factory Union.fromJson(Map<String, dynamic> json) {
    return Union(
      id: json['id'] as int,
      upazillaId: json['upazilla_id'] as int,
      name: json['name'] as String,
      bnName: json['bn_name'] as String,
      url: json['url'] as String,
    );
  }

  // Convert an Union object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'upazilla_id': upazillaId,
      'name': name,
      'bn_name': bnName,
      'url': url,
    };
  }
}