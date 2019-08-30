import 'package:perklight/classes/perk.dart';

class Build {
  Build(this.id, {this.name, this.saved, this.perks});

  final String id;

  String name;
  bool saved = false;
  List<Perk> perks;

  void loadPerks() {
    // TODO: decode the id and load references to actual perk instances into the "perks" member for ease of access
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'saved': saved
  };

  Build.fromJson(Map<String, dynamic> inJson) :
    name = inJson['name'],
    id = inJson['id'];
}