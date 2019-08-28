import 'dart:typed_data';
import 'dart:convert';

import 'package:test/test.dart';

import 'package:crclib/crclib.dart';

import 'package:perklight/classes/perkSerialiser.dart';
import 'package:perklight/classes/perk.dart';

void main() {
  // Encoding tests

  const validLists = [
    [0x00, 0x00, 0x00, 0x00],
    [0x01, 0x02, 0x03, 0x04],
    [0x01, 0x01, 0x01, 0x01],
    [0x70, 0x70, 0x70, 0x70],
    [0x7F, 0x7F, 0x7F, 0x7F],
    [0x80, 0x80, 0x80, 0x80],
    [0xFF, 0xFF, 0xFF, 0xFF],
  ];

  const invalidLists = [
  ];

  group('Known valid', () {
    group('encode', () {
      for(PerkType type in PerkType.values) {
        for(List<int> value in validLists) {
          String output = PerksSerialiser.encode(perksIds: value, perkType: type);
          Uint8List buffer = base64Decode(output);

          group('$value => $output as $type', () {
            test('encode is valid', () {
              var actual = buffer.sublist(0, 4);
              actual = actual.map((i) => i ^ 0x80 * type.index).toList();

              expect(actual, equals(value));
            });

            test('checksum is valid', () {
              Uint8List decodedList = buffer.sublist(0, 4);
              Uint8List decodedChksum = buffer.sublist(4);

              Uint16List actual = decodedChksum.buffer.asUint16List();
              Uint16List chksum = Uint16List.fromList([Crc16Usb().convert(decodedList)]);

              expect(actual, equals(chksum));
            });

            test('type bit count is valid', () {
              Uint8List decodedList = buffer.sublist(0, 4);
              int actual = decodedList.reduce((total, next) => total + (next & 128)) ~/ 128;

              expect(actual, anyOf(equals(0), equals(4)));
            });

            test('type is valid', () {
              Uint8List decodedList = buffer.sublist(0, 4);
              int sum = decodedList.reduce((total, next) => total + (next & 128)) ~/ 128;

              PerkType actual;
              switch(sum) {
                case 0:
                  actual = PerkType.survivor;
                  break;
                case 4:
                  actual = PerkType.killer;
                  break;
              }

              expect(actual, equals(type));
            });

            test('length is valid', () {
              expect(buffer, hasLength(4 + 2));
            });

          });
        }
      }
    });

    // Decoding tests
    group('decode', () {
      for(PerkType type in PerkType.values) {
        for(List<int> value in validLists) {
          String build = PerksSerialiser.encode(perksIds: value, perkType: type);

          group('$build => $value as $type', () {
            var output = PerksSerialiser.decode(build);

            test('list is valid', () {
              expect(output['list'], equals(value));
            });

            test('type is valid', () {
              expect(output['type'], equals(type));
            });

          });
        }
      }

    });

  });
}
