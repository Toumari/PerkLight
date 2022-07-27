class Item {
  final String name;
  final String description;
  final String imagePath;

  Item({this.name, this.description, this.imagePath});

  Item.fromJson(Map<String, dynamic> m)
      : name = m['name'],
        description = m['description'],
        imagePath = m['imagePath'];
}
