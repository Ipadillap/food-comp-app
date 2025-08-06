import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_details.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  /// GET /api/foods/{code}
  Future<FoodDetails> getFoodByCode(String code) async {
    final url = Uri.parse('$baseUrl/api/foods/$code');
    final response = await http.get(url, headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      // Extrae el commonName, puede ser null
      final Map<String, String?>? commonName =
      data['commonName'] != null
          ? Map<String, String?>.from(data['commonName'])
          : null;

      // Retorna una instancia del objeto solo con commonName
      return FoodDetails(commonName: commonName);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}