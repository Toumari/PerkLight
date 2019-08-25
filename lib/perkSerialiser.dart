import 'dart:convert';
import 'dart:typed_data';
import 'package:crclib/crclib.dart';

class PerksSerialiser {
  static String encode(List<int> perksIds, bool perkType) {
    // Check perkType for bitwise operation
    int _perkType = perkType ? 1 : 0;

    // Toggle bit 8 when perkType is true (killerMode)
    int bitwise = 128 * _perkType;
    List<int> uInt8PerkIds = perksIds.map((i) => i ^ bitwise).toList();

    // CRC16 Checksum
    Uint16List chksum = Uint16List.fromList([Crc16Usb().convert(uInt8PerkIds)]);
    List<int> uInt8Chksum = Uint8List.view(chksum.buffer);

    // Concat bytes and output Base64 URL string
    List<int> uInt8Bytes = [...uInt8PerkIds, ...uInt8Chksum];
    return base64UrlEncode(uInt8Bytes);
  }

  static Map<String, dynamic> decode(String perks) {
    // Decode Bas64 string
    Uint8List uInt8Bytes = base64Decode(perks);
    assert(uInt8Bytes.length == 6);

    // Split
    Uint8List uInt8PerkIds = uInt8Bytes.sublist(0, 4);
    Uint8List uInt8Chksum = uInt8Bytes.sublist(4);

    // CRC16 Checksum assertion
    Uint16List uInt16Chksum = uInt8Chksum.buffer.asUint16List();
    int chksum = Crc16Usb().convert(uInt8PerkIds);
    assert(chksum == uInt16Chksum[0]);

    // Calculate perkType from 8th bit and ensure all bytes are the same
    int sum = uInt8PerkIds.reduce((total, next) => total + (next & 128)) ~/ 128;
    assert(sum == 0 || sum == 4);

    bool perkType;
    switch(sum) {
      case 0:
        perkType = false;
        break;
      case 4:
        perkType = true;
    }

    int _perkType = perkType ? 1 : 0;
    int bitwise = 128 * _perkType;

    List<int> perkIds = uInt8PerkIds.map((item) => item ^ bitwise).toList();
    return {'list': perkIds, 'type': perkType};
  }
}