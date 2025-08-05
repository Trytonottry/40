import '../../domain/entities/breach.dart';
import '../../domain/repositories/breach_repository.dart';
import '../datasources/breach_api.dart';

class BreachRepositoryImpl implements BreachRepository {
  final BreachApi _api = BreachApi();

  @override
  Future<List<Breach>> check(String email, String? _) async {
    final found = await _api.emailInBreach(email);
    if (found) {
      return [Breach('Public Breach', DateTime.now())];
    }
    return [];
  }
}