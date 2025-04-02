class Item {
  final String title;
  final String description;
  final String details;

  Item({required this.title, required this.description, required this.details});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      description: json['description'],
      details: json['details'],
    );
  }
}
