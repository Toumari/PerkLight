import 'package:flutter/material.dart';

class Perk {
  String perkName;
  bool isEnabled;
  int id;

  Perk(this.perkName, this.isEnabled,this.id);

}


List fullList = ['Ace in the Hole', 'Adrenaline', 'Aftercare', 'Alert', 'Autodidact', 'Balanced Landing', 'Boil Over', 'Bond', 'Borrowed Time', 'Botany Knowledge', 'Breakdown', 'Buckle Up', 'Calm Spirit', 'Dance With Me', 'Dark Sense', 'Dead Hard', 'Decisive Strike', 'Déja Vu', 'Deliverance', "Detective's Hunch", 'Distortion', 'Diversion', 'Empathy', 'Flip-Flop', 'Head On', 'Hope', 'Iron Will', 'Kindred', 'Leader', 'Left Behind', 'Lightweight', 'Lithe', 'Mettle of Man', 'No Mither', 'No One Left Behind', 'Object of Obsession', 'Open-Handed', 'Pharmacy', "Plunderer's Instinct", 'Poised', 'Premonition', 'Prove Thyself', 'Quick & Quiet', 'Resilience', 'Saboteur', 'Self-Care', 'Slippery Meat', 'Small Game', 'Sole Survivor', 'Solidarity', 'Spine Chill', 'Sprint Burst', 'Stake Out', 'Streetwise', 'This Is Not Happening', 'Technician', 'Tenacity', 'Up the Ante', 'Unbreakable', 'Urban Evasion', 'Vigil', 'Wake Up!', "We'll Make It", "We're Gonna Live Forever", 'Windows of Opportunity',
  "A Nurse's Calling", 'Agitation', 'Bamboozle', 'Barbecue & Chilli', 'Beast of Prey', 'Bitter Murmur', 'Bloodhound', 'Blood Warden', 'Brutal Strength', 'Corrupt Intervention', 'Coulrophobia', 'Dark Devotion', 'Deerstalker', 'Discordance', 'Distressing', 'Dying Light', 'Enduring', 'Fire Up', "Franklin's Demise", 'Furtive Chase', "Hangman's Trick", 'Hex: Devour Hope', 'Hex: Haunted Grounds', 'Hex: Huntress Lullaby', 'Hex: No One Escapes Death', 'Hex: Ruin', 'Hex: The Third Seal', 'Hex: Thrill of the Hunt', "I'm All Ears", 'Infectious Fright', 'Insidious', 'Iron Grasp', 'Iron Maiden', 'Knock Out', 'Lightborn', 'Mad Grit', 'Make Your Choice', 'Monitor & Abuse', 'Monstrous Shrine', 'Overcharge', 'Overwhelming Presence', 'Play With Your Food', 'Pop Goes the Weasel', 'Predator', 'Rancor', 'Remember Me', 'Save the Best for Last', 'Shadowborn', 'Sloppy Butcher', 'Spies from the Shadows', 'Spirit Fury', 'Stridor', 'Surveillance', 'Territorial Imperative', 'Tinkerer', 'Thanataphobia', 'Thrilling Tremors', 'Unnerving Presence', 'Unrelenting', 'Whispers'
];

List killerList = [
"A Nurse's Calling", 'Agitation', 'Bamboozle', 'Barbecue & Chilli', 'Beast of Prey', 'Bitter Murmur', 'Bloodhound', 'Blood Warden', 'Brutal Strength', 'Corrupt Intervention', 'Coulrophobia',
  'Dark Devotion', 'Deerstalker', 'Discordance', 'Distressing', 'Dying Light', 'Enduring', 'Fire Up', "Franklin's Demise", 'Furtive Chase', "Hangman's Trick", 'Hex: Devour Hope',
  'Hex: Haunted Grounds', 'Hex: Huntress Lullaby', 'Hex: No One Escapes Death', 'Hex: Ruin', 'Hex: The Third Seal', 'Hex: Thrill of the Hunt', "I'm All Ears", 'Infectious Fright', 'Insidious',
  'Iron Grasp', 'Iron Maiden', 'Knock Out', 'Lightborn', 'Mad Grit', 'Make Your Choice', 'Monitor & Abuse', 'Monstrous Shrine', 'Overcharge', 'Overwhelming Presence', 'Play With Your Food',
  'Pop Goes the Weasel', 'Predator', 'Rancor', 'Remember Me', 'Save the Best for Last', 'Shadowborn', 'Sloppy Butcher', 'Spies from the Shadows', 'Spirit Fury', 'Stridor', 'Surveillance',
  'Territorial Imperative', 'Tinkerer', 'Thanataphobia', 'Thrilling Tremors', 'Unnerving Presence', 'Unrelenting', 'Whispers'
];

List survivorList = [
'Ace in the Hole', 'Adrenaline', 'Aftercare', 'Alert', 'Autodidact', 'Balanced Landing', 'Boil Over', 'Bond', 'Borrowed Time', 'Botany Knowledge',
  'Breakdown', 'Buckle Up', 'Calm Spirit', 'Dance With Me', 'Dark Sense', 'Dead Hard', 'Decisive Strike', 'Déja Vu', 'Deliverance', "detective's Hunch", 'Distortion',
  'Diversion', 'Empathy', 'Flip-Flop', 'Head On', 'Hope', 'Iron Will', 'Kindred', 'Leader', 'Left Behind', 'Lightweight', 'Lithe', 'Mettle of Man', 'No Mither',
  'No One Left Behind', 'Object of Obsession', 'Open-Handed', 'Pharmacy', "Plunderer's Instinct", 'Poised', 'Premonition', 'Prove Thyself', 'Quick & Quiet',
  'Resilience', 'Saboteur', 'Self-Care', 'Slippery Meat', 'Small Game', 'Sole Survivor', 'Solidarity', 'Spine Chill', 'Sprint Burst', 'Stake Out', 'Streetwise',
  'This Is Not Happening', 'Technician', 'Tenacity', 'Up the Ante', 'Unbreakable', 'Urban Evasion', 'Vigil', 'Wake Up!', "We'll Make It", "We're Gonna Live Forever", 'Windows of Opportunity'
];


List<Perk> returnAll() {
  List<Perk> allPerks = List<Perk>();
  for(var i=0;i<fullList.length;i++) {
    allPerks.add(Perk(fullList[i], true,i));
  }
  return allPerks;
}

List<Perk> returnKiller() {
  List<Perk> killerPerks = List<Perk>();
  for(var i=0;i<killerPerks.length;i++) {
    killerPerks.add(Perk(killerList[i],true,i));
  }
  return killerPerks;
}

List<Perk> returnSurvivor() {
  List<Perk> survivorPerks = List<Perk>();
  for(var i=0;i<survivorList.length;i++) {
    survivorPerks.add(Perk(survivorList[i],true,i));
  }
  return survivorPerks;
}
