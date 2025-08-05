import 'package:dio/dio.dart';
import '../../core/constants.dart';

class BreachApi {
  final Dio _dio = Dio(BaseOptions(
    headers: {'hibp-api-key': ApiKeys.hibpKey},
  ));

  Future<bool> emailInBreach(String email) async {
    final resp = await _dio.get(
      'https://haveibeenpwned.com/api/v3/breachedaccount/$email',
      options: Options(validateStatus: (_) => true),
    );
    return resp.statusCode == 200 && (resp.data as List).isNotEmpty;
  }
}