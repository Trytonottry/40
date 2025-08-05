import '../../domain/entities/scan_result.dart';
import '../datasources/ml_classifier.dart';
import '../datasources/url_features.dart';

class ScanRepositoryImpl {
  late final MlClassifier _classifier;

  Future<void> init() async => _classifier = await MlClassifier.load();

  ScanResult scan(String url) {
    final features = extractFeatures(url);
    final label = _classifier.predict(features);
    return ScanResult(
      url: url,
      isPhish: label == 1,
    );
  }
}