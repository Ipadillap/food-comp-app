import 'package:flutter/material.dart';
import 'package:food_app/components/food_compare_card.dart';
import 'package:food_app/components/food_Item_details.dart';
import 'package:food_app/components/food_item.dart';
import 'package:food_app/api_service.dart';
import 'package:food_app/components/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/components/desplegable_widget.dart';

class ComparePage extends StatefulWidget {
  final List<FoodItem> compareList;

  ComparePage({
    Key? key,
    required this.compareList,
  }) : super(key: key);

  @override
  ComparePageState createState() => ComparePageState();
}

class ComparePageState extends State<ComparePage> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;

  List<List<String>> data = [];

  List<FoodItemDetails> compareFoods = [];

  Future<void> _fetchFoodDetails() async {
    try {
      _isLoading = true;
      compareFoods.clear();
      if (widget.compareList.length > 10) {
        print("error: Se ha superado el máximo de alimentos a comparar");
      } else {
        for (int index = 0; index < widget.compareList.length; index++) {
          final auxDetails = await _apiService.getFoodDetailsByCode(widget.compareList[index].code);
          compareFoods.add(auxDetails);
        }
      }
      setState(() {
        print(compareFoods.length.toString());
        _isLoading = false;
      });
    } catch (e) {
      print('Error al obtener detalles del alimento: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFoodDetails();
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble() - kBottomNavigationBarHeight;
    Color colorBackground = const Color.fromARGB(255, 121, 157, 194);

    return Container(
      width: ancho,
      height: largo,
      color: colorBackground,
      alignment: AlignmentDirectional.center,
      child: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : widget.compareList.isNotEmpty
          ? Column(
        children: [
          Container(
            height: largo * 0.35,
            width: ancho,
            color: Colors.transparent,
          ),

          Container(
            width: double.infinity,
            height: largo * 0.6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildEnergyTable(compareFoods, ancho),
                  _buildMainNutrientsTable(compareFoods, ancho),
                  _buildMicronutrientsTable(compareFoods, ancho),
                ],
              ),
            ),
          )
        ],
      )
          : const Center(
        child: Text(
          "No se pudo obtener la información del alimento.",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildEnergyTable(List<FoodItemDetails> foodDetailsList, double ancho) {
    final uniqueEnergyIds = <int, NutrientMeasurement>{};
    for (var food in foodDetailsList) {
      for (var energy in food.nutrientMeasurements.energy) {
        if (!uniqueEnergyIds.containsKey(energy.nutrientId)) {
          uniqueEnergyIds[energy.nutrientId] = energy;
        }
      }
    }

    final sortedEnergies = uniqueEnergyIds.values.toList()
      ..sort((a, b) => a.nutrientId.compareTo(b.nutrientId));

    return DesplegableWidget(
      title: "Valores energético",
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: ancho,
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(color: Colors.grey, width: 0.5),
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color.fromARGB(255, 230, 230, 230)),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Energía",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Unidad",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...foodDetailsList.map((food) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ID: ${food.id}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ],
              ),
              ...sortedEnergies.map((energy) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        energy.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        energy.measurementUnit,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    ...foodDetailsList.map((food) {
                      final matchingEnergy = food.nutrientMeasurements.energy
                          .firstWhere((e) => e.nutrientId == energy.nutrientId, orElse: () => NutrientMeasurement(
                        nutrientId: -1,
                        name: "",
                        measurementUnit: "",
                        average: 0.0,
                        standardized: false,
                        dataType: "",
                      ));

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          matchingEnergy != null
                              ? matchingEnergy.average.toStringAsFixed(2)
                              : "-",
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
      ancho: ancho,
    );

  }

  Widget _buildMainNutrientsTable(List<FoodItemDetails> foodDetailsList, double ancho) {
    final uniqueMainNutrients = <int, NutrientMeasurementWithComponents>{};
    for (var food in foodDetailsList) {
      for (var nutrient in food.nutrientMeasurements.mainNutrients) {
        if (!uniqueMainNutrients.containsKey(nutrient.nutrientId)) {
          uniqueMainNutrients[nutrient.nutrientId] = nutrient;
        }
      }
    }

    final sortedMainNutrients = uniqueMainNutrients.values.toList()
      ..sort((a, b) => a.nutrientId.compareTo(b.nutrientId));

    return DesplegableWidget(
      title: "Nutrientes principales",
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(color: Colors.grey, width: 0.5),
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color.fromARGB(255, 230, 230, 230)),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Nutriente / Componente",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Unidad",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...foodDetailsList.map((food) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "ID: ${food.id}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ],
              ),
              ...sortedMainNutrients.expand((mainNutrient) {
                final mainNutrientRow = TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mainNutrient.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mainNutrient.measurementUnit,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    ...foodDetailsList.map((food) {
                      final matchingNutrient = food.nutrientMeasurements.mainNutrients
                          .firstWhere(
                            (n) => n.nutrientId == mainNutrient.nutrientId,
                        orElse: () => NutrientMeasurementWithComponents(
                          nutrientId: -1,
                          name: "",
                          measurementUnit: "",
                          average: 0.0,
                          standardized: false,
                          dataType: "",
                          components: [],
                        ),
                      );

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          matchingNutrient.nutrientId != -1
                              ? matchingNutrient.average.toStringAsFixed(2)
                              : "-",
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }),
                  ],
                );

                final componentRows = mainNutrient.components.map((component) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                        child: Text(
                          "- ${component.name}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          component.measurementUnit,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      ...foodDetailsList.map((food) {
                        final matchingComponent = food.nutrientMeasurements.mainNutrients
                            .where((n) => n.nutrientId == mainNutrient.nutrientId)
                            .expand((n) => n.components)
                            .firstWhere(
                              (c) => c.nutrientId == component.nutrientId,
                          orElse: () => NutrientMeasurement(
                            nutrientId: -1,
                            name: "",
                            measurementUnit: "",
                            average: 0.0,
                            standardized: false,
                            dataType: "",
                          ),
                        );

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            matchingComponent.nutrientId != -1
                                ? matchingComponent.average.toStringAsFixed(2)
                                : "-",
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }),
                    ],
                  );
                }).toList();

                return [mainNutrientRow, ...componentRows];
              }).toList(),
            ],
          ),
        ),
      ),
      ancho: ancho,
    );
  }

  Widget _buildMicronutrientsTable(List<FoodItemDetails> foodDetailsList, double ancho) {
    Map<int, NutrientMeasurement> _getUniqueMicronutrients(List<FoodItemDetails> foods, String key) {
      final uniqueMicronutrients = <int, NutrientMeasurement>{};
      for (var food in foods) {
        for (var nutrient in food.nutrientMeasurements.micronutrients[key] ?? []) {
          if (!uniqueMicronutrients.containsKey(nutrient.nutrientId)) {
            uniqueMicronutrients[nutrient.nutrientId] = nutrient;
          }
        }
      }
      return uniqueMicronutrients;
    }

    final uniqueVitamins = _getUniqueMicronutrients(foodDetailsList, "vitamins");
    final uniqueMinerals = _getUniqueMicronutrients(foodDetailsList, "minerals");

    uniqueVitamins.values.forEach((v) => print("${v.name} (ID: ${v.nutrientId})"));

    uniqueMinerals.values.forEach((m) => print("${m.name} (ID: ${m.nutrientId})"));

    Widget _buildMicronutrientTable(String title, Map<int, NutrientMeasurement> uniqueMicronutrients, String key) {
      final sortedMicronutrients = uniqueMicronutrients.values.toList()
        ..sort((a, b) => a.nutrientId.compareTo(b.nutrientId));

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          border: TableBorder.all(color: Colors.grey, width: 0.5),
          children: [
            TableRow(
              decoration: const BoxDecoration(color: Color.fromARGB(255, 230, 230, 230)),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Micronutriente (ID)", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Unidad", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...foodDetailsList.map((food) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ID: ${food.id}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ],
            ),
            ...sortedMicronutrients.map((micronutrient) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${micronutrient.name} (${micronutrient.nutrientId})",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      micronutrient.measurementUnit,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ...foodDetailsList.map((food) {
                    final matchingMicronutrient = food.nutrientMeasurements.micronutrients[key]
                        ?.firstWhere(
                          (n) => n.nutrientId == micronutrient.nutrientId,
                      orElse: () => NutrientMeasurement(
                        nutrientId: -1,
                        name: "",
                        measurementUnit: "",
                        average: 0.0,
                        standardized: false,
                        dataType: "",
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (matchingMicronutrient != null && matchingMicronutrient.nutrientId != -1)
                            ? matchingMicronutrient.average.toStringAsFixed(2)
                            : "-",
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }),
                ],
              );
            }).toList(),
          ],
        ),
      );
    }

    return DesplegableWidget(
      title: "Micronutrientes",
      ancho: ancho,
      content: Column(
        children: [
          DesplegableWidget(
            title: "Vitaminas",
            ancho: ancho,
            content: _buildMicronutrientTable("Vitaminas", uniqueVitamins, "vitamins"),
          ),
          const SizedBox(height: 16.0),
          DesplegableWidget(
            title: "Minerales",
            ancho: ancho,
            content: _buildMicronutrientTable("Minerales", uniqueMinerals, "minerals"),
          ),
        ],
      ),
    );
  }


  void resfresh() {
    setState(() {
      _fetchFoodDetails();
    });
  }
}
