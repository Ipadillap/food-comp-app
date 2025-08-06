import 'package:food_app/src/services/api_service.dart';
import 'package:food_app/src/models/food_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test obtener comida por código y mostrar commonName', () async {
    final api = ApiService(baseUrl: 'http://[::1]:3000');
    final FoodDetails result = await api.getFoodByCode('CLA0001B');
    print('Common names: ${result.commonName}');
    expect(result.commonName, isNotNull);
  });
}