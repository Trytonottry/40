import 'package:workmanager/workmanager.dart';
import '../data/datasources/wifi_scanner.dart';
import '../data/datasources/ml_classifier.dart';
import '../data/repositories/scan_repository_impl.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, _) async {
    final scanner = WifiScanner();
    final classifier = await MlClassifier.load();
    final repo = ScanRepositoryImpl(scanner, classifier);

    await repo.performScan();
    return true;
  });
}