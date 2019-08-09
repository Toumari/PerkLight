import 'package:flutter/material.dart';

class Perk {
  String perkName;
  bool isEnabled;

  Perk(this.perkName, this.isEnabled);

}

List<Perk> returnAll() {
  List<Perk> perks = List<Perk>();
  perks.add(Perk('test1', true));
  return perks;
}
