class Job {
  final String id;
  final String title;
  final String company;
  final String category;
  final String location;
  final String deadline;
  final String salary;
  final String description;
  final String image;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.category,
    required this.location,
    required this.deadline,
    required this.salary,
    required this.description,
    required this.image,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      category: json['category'],
      location: json['location'],
      deadline: json['deadline'],
      salary: json['salary'],
      description: json['description'],
      image: json['image'],
    );
  }
}