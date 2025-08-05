import '../entities/breach.dart';

abstract class BreachRepository {
  Future<List<Breach>> check(String email, String? phone);
}