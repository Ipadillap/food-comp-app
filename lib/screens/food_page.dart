import 'dart:math';
import 'dart:ui';

import 'package:food_app/widgets/index.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:food_app/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodPage extends StatefulWidget {
  final FoodItem foodItem;

  const FoodPage({Key? key, required this.foodItem}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  FoodItemDetails? foodDetails;
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  bool _isWidgetVisible = true;
  int _currentPage = 0;
  final PageController _pageController = PageController();
  String selectedInfo = "General";

  Widget selectedWidget = Container(
    alignment: Alignment.center,
    child: const Text("Selecciona una opción", style: TextStyle(fontSize: 16)),
  );

  int selectedColorIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchFoodDetails();
  }

  Future<void> _fetchFoodDetails() async {
    try {
      final details = await _apiService.getFoodDetailsByCode(widget.foodItem.code);
      details.Verification();
      setState(() {
        foodDetails = details;
        _isLoading = false;
        selectedWidget = Column(
          children: [
            _buildGeneralInfo(),
            SizedBox(
              height: 30,
            ),
          ],
        );
      });
    } catch (e) {
      print('Error al obtener detalles del alimento: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isWidgetVisible) return const SizedBox.shrink();
    double extraTop = MediaQuery.of(context).padding.top;
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble() - extraTop;
    double topZone = largo * 0.3;
    double midZone = largo * 0.02;
    double bottomZone = largo * (1 - 0.3 - 0.02);
    Color colorBackground = Color.fromARGB(255, 255, 255, 255);
    Color colorSelected = Color.fromARGB(255, 219, 83, 117);
    Color colorParrafo = Color.fromARGB(255, 174, 174, 174);
    int cantOpcipones = 4;

    return Scaffold(
      body: _isLoading
          ? const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            color: const Color.fromARGB(255,104, 166, 145),
            strokeWidth: 5,
          ),
        ),
      )
          : foodDetails != null
              ? Column(
                  children: [
                    // ZONA SUPERIOR
                    Stack(
                      children: [

                        // IMAGEN DE FONDO
                        Container(
                          width: ancho,
                          height: topZone + extraTop,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Transform.translate(
                            offset: Offset(0, -100),
                            child: OverflowBox(
                              maxWidth: ancho * 2,
                              maxHeight: largo,
                              child: Image.asset(
                                'lib/assets/images/fondo.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // DESENFOQUE
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: ancho,
                              height: topZone + extraTop,
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  color: Colors.white.withOpacity(0),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ACLARANADO IMAGEN
                        Container(
                          width: ancho,
                          height: topZone + extraTop,
                          color: const Color.fromARGB(167, 255, 255, 255),
                          alignment: Alignment.center,
                        ),

                        // GRAFICOS
                        Column(
                          children: [
                            SizedBox(height: extraTop,),
                            Container(
                              alignment: Alignment.bottomCenter,
                              height: topZone,
                              child: PageView(
                                controller: _pageController,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (int index) {
                                  setState(() {
                                    _currentPage = index;
                                  });
                                },
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      child: Center(
                                        child: Container(
                                          width: ancho,
                                          height: topZone,
                                          child: buildGraphic1Widget(ancho, topZone),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      child: Center(
                                        child: Container(
                                          width: ancho,
                                          height: topZone,
                                          child: buildGraphic2Widget(ancho, topZone),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // BOTON DE RETROCESO
                        Column(
                          children: [
                            SizedBox(height: extraTop,),
                            Row(
                              children: [
                                Container(
                                    height: largo * 0.05,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.arrow_back_ios_new_rounded)
                                    )
                                ),
                              ],
                            ),
                          ],
                        )

                      ],
                    ),

                    // INTERMEDIO
                    Container(
                      height: midZone,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(2, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin:
                            const EdgeInsets.symmetric(horizontal: 5),
                            width: _currentPage == index ? 10 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? const Color.fromARGB(255, 104, 166, 145)
                                  : const Color.fromARGB(129, 170, 204, 198),
                              borderRadius: BorderRadius.circular(50),
                              shape: BoxShape.rectangle,
                            ),
                          );
                        }),
                      ),
                    ),

                    // ZONA INFERIOR
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // INFORAMCION
                        Container(
                          width: ancho,
                          height: bottomZone,
                          color: colorBackground,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              // NOMBRE DE ALIMENTO
                              Container(
                                alignment: Alignment.center,
                                width: ancho,
                                height: largo * 0.1,
                                color: colorBackground,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: ancho*0.9,
                                    height: largo*0.08,
                                    padding: EdgeInsets.only(left: ancho*0.1),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 104, 166, 145),
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                                    ),
                                    child: _buildTitle(),
                                  ),
                                ),
                              ),

                              // SELECTOR DE INFORMACION A MOSTRAR
                              Container(
                                height: largo * 0.08,
                                width: ancho ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    // GENERAL
                                    GestureDetector(
                                      onTap: selectedInfo == "General" ? null : () {
                                        setState(() {
                                          selectedInfo = "General";
                                          selectedWidget = Column(
                                            children: [
                                              _buildGeneralInfo(),
                                            ],
                                          );
                                        });
                                      },
                                      child: Container(
                                          height: largo * 0.05,
                                          width: ancho/cantOpcipones,
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "General",
                                                    style: TextStyle(
                                                      color: selectedInfo == "General" ? colorSelected : colorParrafo,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: largo*0.005,
                                                    height: largo*0.005,
                                                    decoration: BoxDecoration(
                                                        color: selectedInfo == "General" ? colorSelected : Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ),

                                    // ETIQUETADO
                                    GestureDetector(
                                      onTap: selectedInfo == "Etiquetado" ? null : () {
                                        setState(() {
                                          selectedInfo = "Etiquetado";
                                          selectedWidget =
                                              SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    _buildEnergyWidget(ancho),
                                                    _buildNutrientWidget(ancho),
                                                    _buildMicronutrientsWidget(ancho),
                                                  ],
                                                ),
                                              );
                                        });
                                      },
                                      child: Container(
                                          height: largo * 0.05,
                                          width: ancho/cantOpcipones,
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Etiquetado",
                                                    style: TextStyle(
                                                      color: selectedInfo == "Etiquetado" ? colorSelected : colorParrafo,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: largo*0.005,
                                                    height: largo*0.005,
                                                    decoration: BoxDecoration(
                                                        color: selectedInfo == "Etiquetado" ? colorSelected : Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ),

                                    // CODIGOS LANGUALES
                                    GestureDetector(
                                      onTap: selectedInfo == "Detalles" ? null : () {
                                        setState(() {
                                          selectedInfo = "Detalles";
                                          selectedWidget =
                                              SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    _buildLangualWidget(ancho)
                                                  ],
                                                ),
                                              );
                                        });
                                      },
                                      child: Container(
                                          height: largo * 0.05,
                                          width: ancho/cantOpcipones,
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Detalles",
                                                    style: TextStyle(
                                                      color: selectedInfo == "Detalles" ? colorSelected : colorParrafo,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: largo*0.005,
                                                    height: largo*0.005,
                                                    decoration: BoxDecoration(
                                                        color: selectedInfo == "Detalles" ? colorSelected : Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ),

                                    // REFERENCIAS
                                    GestureDetector(
                                      onTap: selectedInfo == "Referencias" ? null : () {
                                        setState(() {
                                          selectedInfo = "Referencias";
                                          selectedWidget =
                                              SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        _buildReferences(ancho)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                        });
                                      },
                                      child: Container(
                                          height: largo * 0.05,
                                          width: ancho/cantOpcipones,
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Referencias",
                                                    style: TextStyle(
                                                      color: selectedInfo == "Referencias" ? colorSelected : colorParrafo,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: largo*0.005,
                                                    height: largo*0.005,
                                                    decoration: BoxDecoration(
                                                        color: selectedInfo == "Referencias" ? colorSelected : Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              // INFORMACION SELECCIONADA
                              Container(
                                width: ancho * 0.8,
                                height: largo * 0.5,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      selectedWidget,
                                      Container(
                                        height: largo * 0.04,
                                        width: ancho,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),


                        // SECTOR TRANSPARANTE
                        IgnorePointer(
                          ignoring: true,
                          child: Container(
                            width: ancho,
                            height: bottomZone,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: largo * 0.1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(0, 255, 255, 255),
                                        colorBackground,
                                      ],
                                      stops: [0.0, 0.8],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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


  // CONSTRUCCION DE GRAFICOS
  Widget buildGraphicWidget( String title, List<NutrientMeasurement> nutrients, double ancho, double largo, {bool excludeWaterAsh = false}) {
    if (foodDetails == null || nutrients.isEmpty) {
      return const Center(
        child: Text(
          "No hay información disponible para el gráfico.",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    final filteredNutrients = nutrients
        .where((nutrient) =>
    nutrient.name != "Cenizas" &&
        (!excludeWaterAsh || nutrient.name != "Humedad (agua)") &&
        nutrient.average > 0)
        .map((nutrient) => {
      "label": nutrient.name,
      "value": nutrient.average.toDouble(),
      "color": _getColorForIndex(nutrients.indexOf(nutrient)),
    })
        .toList();

    if (filteredNutrients.isEmpty) {
      return const Center(
        child: Text(
          "No hay datos válidos para mostrar.",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    final total = filteredNutrients.fold<double>(
        0, (sum, nutrient) => sum + (nutrient["value"] as double));

    return Container(
      width: ancho,
      height: largo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: ancho,
            height: largo * 0.2,
            child: Text(
              title,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          Container(
            width: ancho,
            height: largo * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ancho * 0.4,
                  height: largo * 0.8,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: ancho * 0.04,
                      sections: filteredNutrients.map((nutrient) {
                        return PieChartSectionData(
                          color: nutrient["color"] as Color,
                          value: nutrient["value"] as double,
                          title: "",
                          radius: ancho * 0.13,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  width: ancho * 0.5,
                  height: largo * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...filteredNutrients.map((nutrient) {
                        final percentage =
                            (nutrient["value"] as double) / total * 100;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                color: nutrient["color"] as Color,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "${percentage.toStringAsFixed(1)}% ${nutrient["label"]} ${(nutrient["value"] as double).toStringAsFixed(2)} ${nutrients.first.measurementUnit}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildGraphic1Widget(double ancho, double largo) {
    return buildGraphicWidget(
      "Composición",
      foodDetails!.nutrientMeasurements.mainNutrients,
      ancho,
      largo,
    );
  }

  Widget buildGraphic2Widget(double ancho, double largo) {
    return buildGraphicWidget(
      "Contenido energético",
      foodDetails!.nutrientMeasurements.mainNutrients,
      ancho,
      largo,
      excludeWaterAsh: true,
    );
  }

  Color _getColorForIndex(int index) {
    const colors = [
      Color.fromARGB(255, 209, 75, 75),
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.cyan,
      Colors.brown,
      Colors.pink,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }

  Widget _buildTitle() {
    if (foodDetails == null) {
      return const Center(
        child: Text(
          "No hay información disponible.",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    final commonName = foodDetails!.commonName ?? "Nombre no disponible";

    final firstPart = commonName.split(',').first.trim();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstPart,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )
            ),
            Text(
              foodDetails!.code,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(197, 255, 255, 255),
                  ),
                )
            ),
          ],
        ),
      ],
    );
  }


  // CONSTRUCCION DE INFORMACION GENERAL

  Widget _buildGeneralInfo() {
    if (foodDetails == null) {
      return const Center(
        child: Text("Información no disponible."),
      );
    }

    List<Widget> infoWidgets = [];

    infoWidgets.add(_buildInfoRow("Código:", foodDetails!.code));

    final commonNameEs = foodDetails!.commonName;
    if (commonNameEs != null && commonNameEs.isNotEmpty) {
      infoWidgets.add(
        _buildInfoRow("Nombre:", commonNameEs),
      );
    }

    if (foodDetails!.scientificName != null) {
      infoWidgets.add(
        _buildInfoRow("Nombre Científico:", foodDetails!.scientificName!),
      );
    }

    if (foodDetails!.origins != null && foodDetails!.origins!.isNotEmpty) {
      for (int i = 0; i < foodDetails!.origins!.length; i++) {
        final origin = foodDetails!.origins![i];
        infoWidgets.add(
          _buildInfoRow("Origen ${i + 1}:", origin.name),
        );
      }
    }

    if (foodDetails!.observation != null) {
      infoWidgets.add(
        _buildInfoRow("Observación:", foodDetails!.observation!),
      );
    }

    infoWidgets.add(
      _buildInfoRow(
          "Grupo de comida:",
          "${foodDetails!.group.name} (Código: ${foodDetails!.group.code})"),
    );

    infoWidgets.add(
      _buildInfoRow(
          "Tipo de alimento:",
          "${foodDetails!.type.name} (Código: ${foodDetails!.type.code})"),
    );

    if (foodDetails!.brand != null) {
      infoWidgets.add(
        _buildInfoRow("Marca:", foodDetails!.brand!),
      );
    }

    if (foodDetails!.strain != null) {
      infoWidgets.add(
        _buildInfoRow("Cepa:", foodDetails!.strain!),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infoWidgets,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    double extraTop = MediaQuery.of(context).padding.top;
    double largo = MediaQuery.of(context).size.height.toDouble() - extraTop;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: largo * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: largo * 0.02,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }


  // CONSTRUCCION DE INFORMACION NUTRIENTES

  Widget _buildEnergyWidget(double ancho) {
    return _buildDesplegableWidget(
      "Valor energético",
      "Información energética",
      foodDetails?.nutrientMeasurements.energy ?? [],
      ancho,
    );
  }

  Widget _buildNutrientWidget(double ancho) {
    if (foodDetails == null) {
      return const Center(
        child: Text(
          "No hay información nutricional disponible.",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    final nutrientsWithComponents = foodDetails!.nutrientMeasurements.mainNutrients
        .where((nutrient) => nutrient.components.isNotEmpty)
        .toList();

    final nutrientsWithoutComponents = foodDetails!.nutrientMeasurements.mainNutrients
        .where((nutrient) => nutrient.components.isEmpty)
        .toList();

    return DesplegableWidget(
      title: "Nutrientes principales",
      ancho: ancho * 0.9,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (nutrientsWithoutComponents.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _buildNutrientTable(
                "Nutrientes generales",
                nutrientsWithoutComponents,
                ancho,
              ),
            ),
          ...nutrientsWithComponents.map(
                (nutrient) => DesplegableWidget(
              title: nutrient.name,
              ancho: ancho * 0.9,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNutrientTable(
                    "Información de ${nutrient.name}",
                    [nutrient, ...nutrient.components],
                    ancho,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicronutrientsWidget(double ancho) {
    return DesplegableWidget(
      title: "Micronutrientes",
      ancho: ancho,
      content: Column(
        children: [
          _buildDesplegableWidget(
            "Vitaminas",
            "Vitaminas",
            foodDetails?.nutrientMeasurements.vitamins ?? [],
            ancho,
          ),
          const SizedBox(height: 8),
          _buildDesplegableWidget(
            "Minerales",
            "Minerales",
            foodDetails?.nutrientMeasurements.minerals ?? [],
            ancho,
          ),
        ],
      ),
      color: Colors.white,
    );
  }

  Widget _buildDesplegableWidget(String title, String tableTitle, List<NutrientMeasurement> nutrients, double ancho) {
    if (nutrients.isEmpty) {
      return const Center(
        child: Text(
          "No hay información disponible.",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return DesplegableWidget(
      title: title,
      ancho: ancho,
      content: _buildNutrientTable(tableTitle, nutrients, ancho),
    );
  }

  Widget _buildNutrientTable(String title, List<NutrientMeasurement> nutrients, double ancho) {
    double extraTop = MediaQuery.of(context).padding.top;
    double largo = MediaQuery.of(context).size.height.toDouble() - extraTop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 10),

        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.grey, width: 0.5),
          children: [
             TableRow(
              decoration: BoxDecoration(color: Color.fromARGB(255, 230, 230, 230)),
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Nombre",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: largo * 0.016,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Unidad",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: largo * 0.016,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    "Promedio",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: largo * 0.016,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      )
                  ),
                ),
              ],
            ),
            ...nutrients.map(
                  (nutrient) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      nutrient.name,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: largo * 0.016,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      100.toString()+ " "+ nutrient.measurementUnit,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: largo * 0.016,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      nutrient.average.toStringAsFixed(2),
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: largo * 0.016,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }


  // CONSTRUCCION DE INFORMACION LANGUAL (FALTA OPTIMIZAR BIEN)

  Widget _buildLangualWidget(double ancho) {
    if (foodDetails == null || foodDetails!.langualCodes.isEmpty) {
      return Center(
        child: Text(
          "No hay información sobre los códigos Langual.",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.016,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      );
    }

    return _buildLangualCodeTable(
      "Códigos Langual",
      foodDetails!.langualCodes,
      ancho,
    );
  }

  Widget _buildLangualCodeTable(String title, List<LangualCode> langualCodes, double ancho) {
    double extraTop = MediaQuery.of(context).padding.top;
    double largo = MediaQuery.of(context).size.height.toDouble() - extraTop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: largo * 0.023,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(3),
          },
          border: TableBorder.all(color: Colors.grey, width: 0.5),
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              children: [
                _buildTableCell("Categoría", isHeader: true),
                _buildTableCell("Código", isHeader: true),
                _buildTableCell("Descripción", isHeader: true),
              ],
            ),
            ...langualCodes.expand((langualCode) {
              final List<TableRow> rows = [];

              if (langualCode.children.isNotEmpty) {
                rows.add(
                  TableRow(
                    children: [
                      _buildCategoryCell(langualCode.descriptor),
                      _buildTableCell(langualCode.children[0].code),
                      _buildTableCell(langualCode.children[0].descriptor),
                    ],
                  ),
                );

                for (int i = 1; i < langualCode.children.length; i++) {
                  rows.add(
                    TableRow(
                      children: [
                        _buildTableCell(""),
                        _buildTableCell(langualCode.children[i].code),
                        _buildTableCell(langualCode.children[i].descriptor),
                      ],
                    ),
                  );
                }
              } else {
                rows.add(
                  TableRow(
                    children: [
                      _buildCategoryCell(langualCode.descriptor),
                      _buildTableCell(""),
                      _buildTableCell(""),
                    ],
                  ),
                );
              }
              return rows;
            }).toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCell(String descriptor) {
    final parts = descriptor.split(" ");
    final String letter = parts.first;
    final String rest = parts.skip(1).join(" ");

    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      color: const Color.fromARGB(255, 230, 230, 230),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$letter\n$rest",
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, bool isCategory = false}) {
    final cellStyle = GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: isHeader ? MediaQuery.of(context).size.height * 0.016 : MediaQuery.of(context).size.height * 0.016,
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        color: Colors.black87,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      color: isCategory
          ? const Color.fromARGB(255, 230, 230, 230)
          : Colors.transparent,
      child: Text(
        text,
        style: cellStyle,
        textAlign: TextAlign.left,
      ),
    );
  }


  // CONSTRUCCION DE INFORMACION DE REFERENCIAS
  Widget _buildReferences(double ancho) {
    if (foodDetails?.references == null || foodDetails!.references!.isEmpty) {
      return const Center(
        child: Text("Información no disponible."),
      );
    }

    double extraTop = MediaQuery.of(context).padding.top;
    double largo = MediaQuery.of(context).size.height.toDouble() - extraTop;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...foodDetails!.references!.map((reference) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Título: ${reference.title}",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: largo * 0.02,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                ),
                SizedBox(height: largo*0.01,),
                Text("Tipo: ${reference.type}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: largo * 0.02,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),),
                SizedBox(height: largo*0.01,),
                Text("Autores: ${reference.authors.join(", ")}",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: largo * 0.02,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),),
                SizedBox(height: largo*0.01,),
                if (reference.refYear != null)
                  Text("Año: ${reference.refYear}",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: largo * 0.02,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 20,
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }


}
