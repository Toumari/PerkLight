import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

/// Generates a List of the specified [size] containing unique integers in the range [min] (inclusive) to [max] (exclusive).
List<int> generateSetOfRandomNumbers(int size, {int min = 0, int max = 100}) {
  if (size > (max - min)) throw Exception('size is greater than (max - min) which will cause an infinite loop');

  Set<int> values = new Set();
  for (int i = 0; i < size; i++) {
    // Keep generating numbers until we find one that's not in the set
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
