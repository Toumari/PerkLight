import 'dart:convert';
import 'dart:typed_data';
import 'package:crclib/crclib.dart';
import 'package:uri/uri.dart';

import 'package:perklight/classes/perk.dart';

class PerksSerialiser {
  static const URL = 'https://perklight.app/build';

  static String encode({ List<int> perkIds, PerkType perkType }) {
    // Toggle bit 8 using perkType index (only works with 2 types)
    int bitwise = 128 * perkType.index;
    List<int> uInt8PerkIds = perkIds.map((i) => i ^ bitwise).toList();

    // CRC16 Checksum
    Uint16List chksum = Uint16List.fromList([Crc16Usb().convert(uInt8PerkIds)]);
    List<int> uInt8Chksum = Uint8List.view(chksum.buffer);

    // Concat bytes and output Base64 URL string
    List<int> uInt8Bytes = [...uInt8PerkIds, ...uInt8Chksum];

    // Create Bas64 URL string
    String output = base64UrlEncode(uInt8Bytes);

    return output;
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

    // Set perkType
    PerkType perkType;
    switch(sum) {
      case 0:
        perkType = PerkType.survivor;
        break;
      case 4:
        perkType = PerkType.killer;
        break;
    }

    // Toggle bit 8 using perkType index (only works with 2 types)
    int bitwise = 128 * perkType.index;
    List<int> perkIds = uInt8PerkIds.map((item) => item ^ bitwise).toList();

    Map<String, dynamic> output = {'list': perkIds, 'type': perkType};

    return output;
  }

  static String serialiseUrl({ List<int> perkIds, PerkType perkType }) {
    String base64 = PerksSerialiser.encode(perkIds: perkIds, perkType: perkType);

    var template = new UriTemplate("$URL/{buildId}");
    String url = template.expand({'buildId': base64});

    return url;
  }

  static Map<String, dynamic> deserialiseUrl(String url) {
    if(!url.startsWith(URL)) {
      throw Exception('Not valid URL');
    }

    Map<String, dynamic> output;
    List<String> pathSegments = Uri.parse(url).pathSegments;

    switch (pathSegments[0]) {
      case 'build':
        output = PerksSerialiser.decode(pathSegments[1]);
        break;
      default:
        throw Exception('Not valid url');
    }

    return output;
  }
}
