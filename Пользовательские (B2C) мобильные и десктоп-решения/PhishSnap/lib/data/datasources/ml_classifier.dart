import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class MlClassifier {
  late final Interpreter _interpreter;

  MlClassifier._(this._interpreter);

  static Future<MlClassifier> load() async {
    final interpreter =
        await Interpreter.fromAsset('lib/data/ml/phish_model.tflite');
    return MlClassifier._(interpreter);
  }

  // Вход: вектор из 28 признаков (см. url_features.dart)
  Future<int> predict(Float32List features) async {
    final input = [features];
    final output = List.filled(1 * 2, 0.0).reshape([1, 2]);
    _interpreter.run(input, output);
    return output[0][0] > output[0][1] ? 0 : 1; // 0 – safe, 1 – phish
  }
}