import 'package:flutter/material.dart';
import '../../data/datasources/local_storage.dart';
import '../../services/background_worker.dart';
import '../../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _ctrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    NotificationService.init();
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
      'breach_check',
      'check',
      frequency: const Duration(hours: 6),
    );
    LocalStorage.getEmail().then((e) => _ctrl.text = e ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dark-Breach Radar')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              decoration: const InputDecoration(labelText: 'Ваш e-mail'),
            ),
            ElevatedButton(
              onPressed: () async {
                await LocalStorage.setEmail(_ctrl.text.trim());
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Сохранено')));
              },
              child: const Text('Сохранить'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ChecklistScreen())),
              child: const Text('Чек-лист «что делать»'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Чек-лист за 10 минут')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. Сменить пароль на уникальный.'),
            Text('2. Включить 2FA.'),
            Text('3. Проверить связанные аккаунты.'),
            Text('4. Удалить старые приложения.'),
            Text('5. Подписаться на мониторинг.'),
          ],
        ),
      ),
    );
  }
}