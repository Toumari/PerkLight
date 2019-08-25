import 'dart:convert';
import 'dart:typed_data';
import 'widgets/perk.dart';
import 'package:crclib/crclib.dart';

class PerksSerialiser {
  static String encode(List<Perk> perks, bool perkType) {
    // Check perkType for bitwise operation
    int _perkType = perkType ? 1 : 0;

    // Toggle bit 8 when perkType is true (killerMode)
    int bitwise = 128 * _perkType;
    List<int> uInt8PerkIds = perks.map((i) => i.id ^ bitwise).toList();

    // CRC16 Checksum
    Uint16List chksum = Uint16List.fromList([Crc16Usb().convert(uInt8PerkIds)]);
    List<int> uInt8Chksum = Uint8List.view(chksum.buffer);

    // Concat bytes and output Base64 URL string
    List<int> uInt8Bytes = [...uInt8PerkIds, ...uInt8Chksum];
    return base64UrlEncode(uInt8Bytes);
  }

  static List<Perk> decode(String perks) {
    return <Perk>[];
  }
}