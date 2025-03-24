class Info {
  final String title;
  final String description;

  Info({
    required this.title,
    required this.description,
  });

  // Factory method to create a Info object from JSON
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  // Method to convert the Info object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}