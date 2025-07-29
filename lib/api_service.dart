import 'dart:convert';
import 'package:food_app/widgets/food_Item_details.dart';
import 'package:food_app/widgets/food_item.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://f56f-2800-300-69f1-5040-5dfd-693c-3c32-498a.ngrok-free.app/api/v1';


  //------------------------OBTENCION DE INFO DE FILTROS------------------------

  // OBTENER LISTA DE GRUPOS ALIMENTARIOS
  Future<List<String>> getFoodGroups() async {
    final String url = '$_baseUrl/groups';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        final groups = jsonResponse.map<String>((group) => group['name'] as String).toList();

        return groups;
      } else {
        throw Exception(
            'Error al obtener los grupos alimentarios: Código de respuesta ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }

  // OBTENER LISTA DE TIPOS DE ALIMENTOS
  Future<List<String>> getFoodTypes() async {
    final String url = '$_baseUrl/types';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        final types = jsonResponse.map<String>((type) => type['name'] as String).toList();

        return types;
      } else {
        throw Exception(
            'Error al obtener los tipos de alimentos: Código de respuesta ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }

  // OBTENER LISTA DE REGIONES
  Future<Map<String, List<dynamic>>> getRegions() async {
    final String url = '$_baseUrl/origins';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        final regions = jsonResponse
            .where((origin) => origin['type'] == 'region')
            .map<String>((origin) => origin['name'] as String)
            .toList();

        final regionIds = jsonResponse
            .where((origin) => origin['type'] == 'region')
            .map<int>((origin) => origin['id'] as int)
            .toList();

        return {
          'names': regions,
          'ids': regionIds,
        };
      } else {
        throw Exception(
            'Error al obtener las regiones: Código de respuesta ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }

// OBTENER TODOS LOS NUTRIENTES Y SUS IDS CON UNIDADES
  Future<Map<String, List<dynamic>>> getAllNutrients() async {
    final String url = '$_baseUrl/nutrients';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        final List<dynamic> allNutrients = [
          ...?jsonResponse['macronutrients'],
          ...?jsonResponse['micronutrients']?['vitamins'],
          ...?jsonResponse['micronutrients']?['minerals'],
        ];

        final List<String> nutrientNames = [];
        final List<int> nutrientIds = [];

        for (var nutrient in allNutrients) {
          final nameWithUnit = nutrient['measurementUnit'] != null
              ? '${nutrient['name']} [${nutrient['measurementUnit']}]'
              : nutrient['name'];

          nutrientNames.add(nameWithUnit);
          nutrientIds.add(nutrient['id'] as int);

          if (nutrient['components'] != null && nutrient['components'] is List) {
            for (var component in nutrient['components']) {
              final componentNameWithUnit = component['measurementUnit'] != null
                  ? '${component['name']} [${component['measurementUnit']}]'
                  : component['name'];

              nutrientNames.add(componentNameWithUnit);
              nutrientIds.add(component['id'] as int);
            }
          }
        }

        print('CANTIDAD NUTRIENTES: '+ nutrientNames.length.toString());

        return {
          'names': nutrientNames,
          'ids': nutrientIds,
        };
      } else {
        throw Exception(
            'Error al obtener los nutrientes: Código de respuesta ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }


  //------------------------BUSQUEDA DE ALIMENTOS------------------------

  // OBTENER INFORMACIÓN BÁSICA DE UNA SERIE DE ALIMENTOS POR FILTROS
  Future<List<FoodItem>> getFoodsByFilters({
    String? name,
    String? type,
    String? region,
    String? group,
    String? nutrient,
    String? operator,
    String? value,
  }) async {
    final String url = Uri.parse('$_baseUrl/foods').replace(queryParameters: {
      if (name != null && name.isNotEmpty) 'name': name,
      if (region != null) 'region': region.toString(),
      if (group != null) 'group': group.toString(),
      if (type != null) 'type': type.toString(),
      if (nutrient != null) 'nutrient': nutrient.toString(),
      if (operator != null && operator.isNotEmpty) 'operator': operator,
      if (value != null) 'value': value.toString(),
    }).toString();

    List<FoodItem> itemsList = [];

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        itemsList = jsonResponse.map((foodJson) {
          return FoodItem(
            id: foodJson['id'] ?? '0',
            code: foodJson['code'] ?? '',
            groupId: foodJson['groupId'] ?? 0,
            typeId: foodJson['typeId'] ?? 0,
            commonNameEs: foodJson['commonName']?['es'] ?? '',
            scientificName: foodJson['scientificName'] ?? '',
            subspecies: foodJson['subspecies'],
            compare: false,
          );
        }).toList();
      } else {
        print('Error: Código de estado ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener alimentos: $e');
    }

    return itemsList;
  }

  Future<FoodItemDetails> getFoodDetailsByCode(String code) async {
    final String url = '$_baseUrl/foods/$code';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FoodItemDetails.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Error al obtener detalles del alimento: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al realizar la solicitud: $e');
    }
  }
}
