import '../../domain/entities/ap_risk.dart';

class ApRiskModel extends ApRisk {
  ApRiskModel({
    required super.bssid,
    required super.ssid,
    required super.risk,
    required super.lat,
    required super.lng,
    super.ts,
  });

  Map<String, dynamic> toMap() => {
        'bssid': bssid,
        'ssid': ssid,
        'risk': risk,
        'lat': lat,
        'lng': lng,
        'ts': ts?.millisecondsSinceEpoch,
      };

  factory ApRiskModel.fromMap(Map<String, dynamic> m) => ApRiskModel(
        bssid: m['bssid'],
        ssid: m['ssid'],
        risk: m['risk'],
        lat: m['lat'],
        lng: m['lng'],
        ts: DateTime.fromMillisecondsSinceEpoch(m['ts']),
      );
}