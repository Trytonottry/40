import 'package:workmanager/workmanager.dart';
import '../data/repositories/breach_repository_impl.dart';
import '../data/datasources/local_storage.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, _) async {
    final email = await LocalStorage.getEmail();
    if (email == null) return false;

    final repo = BreachRepositoryImpl();
    final breaches = await repo.check(email, null);
    if (breaches.isNotEmpty) {
      await NotificationService.show(
        'Dark-Breach Alert!',
        'Ваш e-mail найден в новом сливе! Откройте приложение.',
      );
    }
    await LocalStorage.setLastCheck(DateTime.now());
    return true;
  });
}