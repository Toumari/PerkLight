import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:perklight/utilities.dart';

enum PerkType {
  survivor,
  killer
}

class Perk {
  final int id;
  final String name;
  final String description;
  final String iconFilename;
  final PerkType type;

  PerkPreference preference;
  final String preferenceKey;

  Perk(this.id, this.name, this.description, this.iconFilename, this.type) :
    preferenceKey = '${describeEnum(type)}_perk_preference_$id';

  Perk.fromJson(Map<String, dynamic> m, this.type) :
    id = m['id'] ?? -1,
    name = m['name'] ?? 'Unknown Perk',
    description = m['description'] ?? 'This perk doesn\'t currently have a description assigned to it',
    iconFilename = m['iconFilename'],
    preferenceKey = '${describeEnum(type)}_perk_preference_${m["id"]}';

  Future loadPreference() async {
    String _json = await loadFromSharedPreferences(preferenceKey);
    preference = PerkPreference.fromJson(json.decode(_json ?? '{"id":$id}'));
  }

  Future savePreference() async {
    await saveToSharedPreferences(preferenceKey, json.encode(preference));
  }

  String get iconPath {
    return 'assets/images/${describeEnum(type)}/$iconFilename';
  }
}

class KillerPerk extends Perk {
  KillerPerk(int id, String name, String description, String iconFilename) : super(id, name, description, iconFilename, PerkType.killer);
  KillerPerk.fromJson(Map<String, dynamic> m) : super.fromJson(m, PerkType.killer);
}

class SurvivorPerk extends Perk {
  SurvivorPerk(int id, String name, String description, String iconFilename) : super(id, name, description, iconFilename, PerkType.killer);
  SurvivorPerk.fromJson(Map<String, dynamic> m) : super.fromJson(m, PerkType.survivor);
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
