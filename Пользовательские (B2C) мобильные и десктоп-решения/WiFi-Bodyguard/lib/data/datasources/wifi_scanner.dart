import 'dart:async';
import 'package:wifi_scan/wifi_scan.dart';

class WifiScanner {
  Stream<List<WiFiAccessPoint>> scan() async* {
    while (true) {
      final canScan = await WiFiScan.instance.canStartScan(askPermissions: true);
      if (canScan == CanStartScan.yes) {
        await WiFiScan.instance.startScan();
      }
      await Future.delayed(const Duration(seconds: 30));
      final result = await WiFiScan.instance.getScannedResults();
      yield result;
    }
  }
}