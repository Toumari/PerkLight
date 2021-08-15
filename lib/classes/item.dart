class Item {
  final String name;
  final String description;
  final String iconFilename;

  Item({this.name = '', this.description = '', this.iconFilename = ''});

  Item.fromJson(Map<String, dynamic> m):
      name = m['name'],
      description = m['description'],
      iconFilename = m['iconFilename'];

  String get iconPath {
    return 'assets/images/items/$iconFilename';
  }
}
