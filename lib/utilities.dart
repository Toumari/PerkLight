//Built-in
import 'dart:math';

//Third-Party
import 'package:shared_preferences/shared_preferences.dart';

List<int> generateSetOfRandomNumbers(int size, {int min = 0, int max = 100}) {
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
  if (size > (max - min)) throw Exception('size is greater than (max - min) which will cause an infinite loop');

  Set<int> values = new Set();
  for (int i = 0; i < size; i++) {
    // Keep generating numbers until we find one that's not in the set
    // This becomes more inefficient the closer size is to (max - min)
    while (!values.add(Random().nextInt(max - min) + min)) {}
  }
  return values.toList();
}

List<int> replaceIndexValue(List<int> values, List<int> targetIndexes, {int min = 0, int max = 100}) {
  if (max <= values.length) {
    return values;
  }

  for (int index in targetIndexes) {
    if (index < 0 || index > values.length) throw Exception('Index out of bounds');

    while (true) {
      int val = Random().nextInt(max - min) + min;
      if (!values.contains(val)) {
        values[index] = val;
        break;
      }
    }
  }

  return values;
}

Future<dynamic> loadFromSharedPreferences(key) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.get(key);
}

Future<bool> saveToSharedPreferences(key, value) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case (bool):
      return sp.setBool(key, value);
    case (double):
      return sp.setDouble(key, value);
    case (int):
      return sp.setInt(key, value);
    case (String):
      return sp.setString(key, value);
    case (List):
      return sp.setStringList(key, value);
    default:
      return false;
  }
}
