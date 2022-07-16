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
  ];

  const invalidRangeLists = [
    [-255, -255, -255, -255],
    [0x80, 0x80, 0x80, 0x80],
    [0xFF, 0xFF, 0xFF, 0xFF],
    [0xFF, 0x02, 0x03, 0x04],
    [0x01, 0x01, 0x80, 0x01],
  ];

  const invalidListSizes = [
    <int>[],
    [0x80],
    [0xFF, 0xFF],
    [0xFF, 0xFF, 0xFF, 0xFF, 0xFF],
    [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF],
  ];

  const validStrings = [
    'gICAgLeT',
    'cHBwcMDk',
    'AQIDBF7U',
    '8PDw8Iis',
  ];

  const invalidLengthStrings = [
    '8BpfrIiszMz6',
  ];

  const invalidChecksum = [
    'gPCAgCeT',
    'cQBwFMDk',
    'ACIDBF7U',
    '8Brw8Iis',
  ];

  const invalidType = [
    'DPwK-rpY',
    '8Ez6Ks5z',
  ];

  group('valid input', () {
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

  group('invalid range input', () {
    group('encode', () {
      for(List<int> value in invalidRangeLists) {
        test('$value raises range exception', () {
          expect(() => PerksSerialiser.encode(perksIds: value, perkType: PerkType.survivor), throwsRangeError);
        });
      }
    });

  });

  group('invalid size input', () {
    group('encode', () {
      for(List<int> value in invalidListSizes) {
        test('$value raises range exception', () {
          expect(() => PerksSerialiser.encode(perksIds: value, perkType: PerkType.survivor), throwsRangeError);
        });
      }
    });
  });

  group('valid decode', () {
    for(String value in validStrings) {
      test('$value valid decode', () {
        expect(() => PerksSerialiser.decode(value), returnsNormally);
      });
    }
  });

  group('invalid input length', () {
    for(String value in invalidLengthStrings) {
      test('$value invalid length', () {
        expect(() => PerksSerialiser.decode(value), throwsRangeError);
      });
    }
  });

  group('invalid input checksum', () {
    for(String value in invalidChecksum) {
      test('$value invalid checksum', () {
        expect(() => PerksSerialiser.decode(value), throwsA(allOf(isException, predicate((e) => e.message == 'Checksum invalid'))));
      });
    }
  });

  group('invalid input type', () {
    for(String value in invalidType) {
      test('$value invalid type', () {
        expect(() => PerksSerialiser.decode(value), throwsA(allOf(isException, predicate((e) => e.message == 'Invalid type decode'))));
      });
    }
  });
}
