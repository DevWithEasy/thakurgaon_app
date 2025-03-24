class News {
  final String id;
  final String title;
  final String category;
  final String date;
  final String content;
  final String image;

  News({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.content,
    required this.image,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      date: json['date'],
      content: json['content'],
      image: json['image'],
    );
  }
}