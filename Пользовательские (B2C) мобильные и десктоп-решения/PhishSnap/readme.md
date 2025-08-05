# PhishSnap

Оффлайн-камера-сканер QR/ссылок.  
Использует локальную TensorFlow-Lite модель для выявления:
- punycode-доменов
- typo-squatting
- возраста домена (заглушка)
- других признаков фишинга

## Run

### Mobile
```bash
flutter pub get
flutter run