import 'dart:convert';

import 'package:perklight/utilities.dart';

class Perk {
  final int id;
  final String name;
  final String description;
  final String iconFilename;
  final String type;

  PerkPreference preference;
  final String preferenceKey;

  Perk(this.id, this.name, this.description, this.iconFilename, this.type) :
    preferenceKey = '${type}_perk_preference_$id';

  Perk.fromJson(Map<String, dynamic> m, this.type) :
    id = m['id'] ?? -1,
    name = m['name'] ?? 'Unknown Perk',
    description = m['description'] ?? 'This perk doesn\'t currently have a description assigned to it',
    iconFilename = m['iconFilename'],
    preferenceKey = '${type}_perk_preference_${m["id"]}';

  Future loadPreference() async {
    String _json = await loadFromSharedPreferences(preferenceKey);
    preference = PerkPreference.fromJson(json.decode(_json ?? '{"id":$id}'));
  }

  Future savePreference() async {
    await saveToSharedPreferences(preferenceKey, json.encode(preference));
  }

  String get iconPath {
    return 'assets/images/$type/$iconFilename';
  }
}

class PerkPreference {
  final int perkId;
  bool unlocked;
  bool enabled;

  Map<String, dynamic> toJson() => {
    'perkId': perkId,
    'unlocked': unlocked,
    'enabled': enabled
  };

  PerkPreference.fromJson(Map<String, dynamic> inJson) :
    perkId = inJson['perkId'],
    unlocked = inJson['unlocked'] ?? true,
    enabled = inJson['enabled'] ?? true;
}
