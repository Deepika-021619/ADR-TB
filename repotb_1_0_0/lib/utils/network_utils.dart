import 'dart:io';

Future<String> getLocalIp() async {
  try {
    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
      includeLinkLocal: true,
    );
    for (var interface in interfaces) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 && 
            !addr.isLoopback && 
            (addr.address.startsWith('10.') || 
             addr.address.startsWith('192.168.'))) {
          return addr.address;
        }
      }
    }
  } catch (e) {
    print('Error getting IP: $e');
  }
  return '192.168.0.113'; // Fallback
}
