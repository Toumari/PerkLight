//Built-in
import 'dart:convert';
import 'dart:math';

//Third-Party
import 'package:shared_preferences/shared_preferences.dart';

//First-Party
import 'widgets/perk.dart';



Set<int> generateSetOfRandomNumbers(int size, { int min = 0, int max = 100 }) {
  /**
   * Generates a Set of the specified size containing unique integers in the range min (inclusive) to max (exclusive)
   * e.g.:
   *   generateSetOfRandomNumbers(4, min: 2, max: 20) will generate a set of 4 unique numbers, the smallest being 2 and the biggest being 19
   * 
   * :param size: int The number of integers that the Set will contain
   * :param min: int The min value for the randomly generated integer (inclusive)
   * :param max: int The max value for the randomly generated integer (exclusive)
   * :return: Set<int> A set containing size amount of unique integers in the range min <= x <  max
   */
  if (size > (max - min))
    throw Exception('size is greater than (max - min) which will cause an infinite loop');

  Set<int> values = new Set();
  for (int i = 0; i < size; i++) {
    // Keep generating numbers until we find one that's not in the set
    // This becomes more inefficient the closer size is to (max - min)
    while (!values.add(Random().nextInt(max - min) + min)) {}
  }
  return values;
}


//Encodes a list of Perks into Json, then subsequently saves the list into Shared Preferences
void encodeList(chosen, key) async {
  List<Perk> perks = chosen;
  final String perkKey = key;
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString(perkKey, json.encode(perks));
}

//Gets a list of Perks from Shared Preferences using key provided to function call
Future<List<Perk>> getList(key) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  var stringPreference = sp.get(key);
  if (stringPreference == null) {
    return null;
  }
  List<Perk> perks = [];
  json
      .decode(stringPreference)
      .forEach((map) => perks.add(new Perk.fromJson(map)));
  return perks;
}