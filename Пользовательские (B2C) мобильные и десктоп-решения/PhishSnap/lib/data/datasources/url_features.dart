import 'dart:convert';
import 'package:crypto/crypto.dart';

// Упрощённый оффлайн-анализ
Float32List extractFeatures(String url) {
  final uri = Uri.tryParse(url) ?? Uri();
  final domain = uri.host;
  final features = <double>[];

  // 1. Punycode
  features.add(domain.startsWith('xn--') ? 1 : 0);

  // 2. Длина домена
  features.add(domain.length.toDouble());

  // 3. Кол-во дефисов
  features.add('-'.allMatches(domain).length.toDouble());

  // 4. Кол-во цифр
  features.add(RegExp(r'\d').allMatches(domain).length.toDouble());

  // 5. Расстояние Левенштейна до популярных доменов (оффлайн-словарь)
  const popular = ['paypal', 'amazon', 'google', 'apple', 'microsoft'];
  final minDist = popular
      .map((p) => levenshtein(p.toLowerCase(), domain.toLowerCase()))
      .reduce((a, b) => a < b ? a : b);
  features.add(minDist.toDouble());

  // 6. Кол-во поддоменов
  features.add(domain.split('.').length.toDouble());

  // 7. Использование IP вместо домена
  features.add(RegExp(r'^\d+\.\d+\.\d+\.\d+$').hasMatch(domain) ? 1 : 0);

  // 8. Age-домена (для оффлайна фиксируем 0, либо кэшируем WHOIS)
  features.add(0); // placeholder

  // Дополняем до 28 нулями (модель ожидает 28 признаков)
  while (features.length < 28) features.add(0);

  return Float32List.fromList(features);
}

int levenshtein(String a, String b) {
  final m = a.length, n = b.length;
  final d = List.generate(m + 1, (_) => List<int>.filled(n + 1, 0));
  for (var i = 0; i <= m; i++) d[i][0] = i;
  for (var j = 0; j <= n; j++) d[0][j] = j;
  for (var i = 1; i <= m; i++) {
    for (var j = 1; j <= n; j++) {
      final cost = a[i - 1] == b[j - 1] ? 0 : 1;
      d[i][j] = [
        d[i - 1][j] + 1,
        d[i][j - 1] + 1,
        d[i - 1][j - 1] + cost
      ].reduce((a, b) => a < b ? a : b);
    }
  }
  return d[m][n];
}