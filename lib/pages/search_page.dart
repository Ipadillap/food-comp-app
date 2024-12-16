import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/api_service.dart';
import 'package:food_app/components/index.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final List<FoodItem> compareList;
  final Function() quantityToCompare;
  final Function(int) onQuantityChanged;

  SearchPage({
    Key? key,
    required this.compareList,
    required this.quantityToCompare,
    required this.onQuantityChanged
  }) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueSelected = TextEditingController();

  String typeSelected = "";
  final typeOptions = [
    'Seleccionar todos',
  ];
  String regionSelected = "";
  final regionOptions = [
    'Seleccionar todos'
  ];
  final regionIDs = [];
  String groupSelected = "";
  final groupOptions = [
    'Seleccionar todos',
  ];
  String nutrientSelected = "";
  final nutrientsOptions = [
    'Seleccionar todos',
  ];
  final nutrientsIDs = [];
  String operatorSelected = "=";



  List<FoodItem> itemsList = [];
  List<Widget> cardsList = [];

  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  final Duration animationDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    setState(() {
      loadRegionOptions();
      loadTypesOptions();
      loadGroupsOptions();
      loadNutrientsOptions();
      _searchFood(
          _nameController.text,
          typeSelected,
          regionSelected,
          groupSelected,
          nutrientSelected,
          operatorSelected,
          0.toString(),
      );
    });
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double extraTop = MediaQuery.of(context).padding.top;
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble() - kBottomNavigationBarHeight - extraTop;
    Color colorBusqueda = Color.fromARGB(255, 104, 166, 145);
    Color colorBackground = Color.fromARGB(255, 250, 250, 250);
    Color colorFilterText = Color.fromARGB(255, 255, 255, 255);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBackground,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: ancho,
            height: largo + extraTop,
            color: colorBackground,
            child: SingleChildScrollView(
              child: Column(
                children: cardsList,
              ),
            ),
          ),

          // COLUMNA DE BUSCADOR Y FILTROS
          Column(
            children: [
              // SEPARADOR SUPERIOR
              Container(
                height: extraTop,
                width: ancho,
                color: colorBusqueda,
              ),

              // TITLE CONTAINER
              Container(
                  width: ancho,
                  height: largo * 0.08,
                  decoration: BoxDecoration(
                    color: colorBusqueda,
                    border: Border.all(color: colorBusqueda),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: largo * 0.08,
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "CAPCHICAL",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
              ),

              // SEARCH BAR
              Container(
                width: ancho,
                height: largo * 0.08,
                decoration: BoxDecoration(
                  color: colorBusqueda,
                  border: Border.all(color: colorBusqueda),
                ),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // BOTON DE BUSQUEDA
                    Container(
                      child: Container(
                        width: largo * 0.055,
                        height: largo * 0.055,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: const Color.fromARGB(255, 236, 236, 236),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          color: const Color.fromARGB(255, 64, 80, 103),
                          onPressed: () {
                            setState(() {
                              _searchFood(
                                _nameController.text,
                                typeSelected,
                                regionSelected,
                                groupSelected,
                                nutrientSelected,
                                operatorSelected,
                                _valueSelected.text,
                              );
                            });
                          },
                          iconSize: largo * 0.06 * 0.5,
                        ),
                      ),
                    ),

                    // FONDO DE CAMPO DE BUSQUEDA
                    Container(
                      height: largo * 0.055,
                      width: ancho * 0.65,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 236, 236),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),

                      // TEXTFIELD DE CAMPO DE BUSQUEDA
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nameController,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'Buscar por nombre...',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(157, 41, 52, 65),
                                    fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: ancho * 0.02,
                    ),

                    // BOTON DE FILTRO
                    Container(
                      child: Container(
                        width: largo * 0.055,
                        height: largo * 0.055,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: const Color.fromARGB(255, 236, 236, 236),
                        ),
                        child: IconButton(
                          icon: ImageIcon(
                            AssetImage('lib/assets/icons/filter.png'),
                          ),
                          color: const Color.fromARGB(255, 64, 80, 103),
                          onPressed: _toggleExpansion,
                          iconSize: largo * 0.06 * 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //FILTROS DESPLEGABLES
              Column(
                children: [
                  SizeTransition(
                    sizeFactor: _sizeAnimation,
                    axisAlignment: -1.0,
                    child: Container(
                      width: ancho,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: colorBusqueda,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: largo * 0.02,
                          ),

                          // FILTRO TIPO DE ALIMENTO
                          Column(
                            children: [
                              Container(
                                width: ancho * 0.8,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  "Tipo de alimento",
                                  style: TextStyle(
                                    color: colorFilterText,
                                  ),
                                ),
                              ),
                              OptionSelectorWidget(
                                hintText: 'Selecciona una opción',
                                options: typeOptions,
                                onSelected: (selected) {
                                  final safeSelected = selected ?? '';
                                  final selectedIndex =
                                      typeOptions.indexOf(safeSelected);
                                  if (selectedIndex == 0 ||
                                      selectedIndex == -1) {
                                    typeSelected = '';
                                  } else {
                                    typeSelected = '$selectedIndex';
                                  }
                                },
                                ancho: ancho * 0.9,
                                largo: largo * 0.055,
                                cantOptions: 4,
                                seeArrow: true,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: largo * 0.02,
                          ),

                          // FILTRO REGIONES DE ORIGEN
                          Column(
                            children: [
                              Container(
                                width: ancho * 0.8,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  "Regiones de origen",
                                  style: TextStyle(
                                    color: colorFilterText,
                                  ),
                                ),
                              ),
                              OptionSelectorWidget(
                                hintText: 'Selecciona una opción',
                                options: regionOptions,
                                onSelected: (selected) {
                                  final safeSelected = selected ?? '';
                                  final selectedIndex = regionOptions.indexOf(safeSelected);

                                  if (selectedIndex == 0 || selectedIndex == -1) {
                                    regionSelected = '';
                                  } else {
                                    regionSelected = '${regionIDs[selectedIndex]}';
                                  }
                                },
                                ancho: ancho * 0.9,
                                largo: largo * 0.055,
                                cantOptions: 4,
                                seeArrow: true,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: largo * 0.02,
                          ),

                          // FILTRO GRUPO ALIMENTARIO
                          Column(
                            children: [
                              Container(
                                width: ancho * 0.8,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  "Grupo alimentario",
                                  style: TextStyle(
                                    color: colorFilterText,
                                  ),
                                ),
                              ),
                              OptionSelectorWidget(
                                hintText: 'Selecciona una opción',
                                options: groupOptions,
                                onSelected: (selected) {
                                  final safeSelected = selected ?? '';
                                  final selectedIndex =
                                      groupOptions.indexOf(safeSelected);
                                  if (selectedIndex == 0 ||
                                      selectedIndex == -1) {
                                    groupSelected = '';
                                  } else {
                                    groupSelected = '$selectedIndex';
                                  }
                                  print(selectedIndex);
                                },
                                ancho: ancho * 0.9,
                                largo: largo * 0.055,
                                cantOptions: 4,
                                seeArrow: true,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: largo * 0.02,
                          ),

                          Container(
                            width: ancho * 0.8,
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "Medicion de nutrientes",
                              style: TextStyle(
                                color: colorFilterText,
                              ),
                            ),
                          ),

                          Container(
                            width: ancho*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                // SELECTOR DE NUTRIENTE
                                OptionSelectorWidget(
                                  hintText: 'Seleccionar',
                                  options: nutrientsOptions,
                                  onSelected: (selected) {
                                    final safeSelected = selected ?? '';
                                    final selectedIndex = nutrientsOptions.indexOf(safeSelected);
                                    if (selectedIndex == -1) {
                                      nutrientSelected = '';
                                    } else {
                                      nutrientSelected = '${nutrientsIDs[selectedIndex]}';
                                    }
                                  },
                                  ancho: ancho * 0.45,
                                  largo: largo * 0.055,
                                  cantOptions: 4,
                                  seeArrow: true,
                                ),

                                // SELECTOR DE COMPARADOR
                                MatematicSelectorWidget(
                                  hintText: '=',
                                  options: const ['=', '<', '>', '<=', '>=',],
                                  onSelected: (selected) {
                                    operatorSelected = selected.toString();
                                    print(operatorSelected);
                                  },
                                  ancho: ancho * 0.15,
                                  largo: largo * 0.05,
                                  cantOptions: 3,
                                  color: const Color.fromARGB(255, 236, 236, 236),
                                  borderColor:
                                  const Color.fromARGB(255, 185, 185, 185),
                                  seeArrow: false,
                                ),

                                // TEXTFIELD DE VALOR
                                Container(
                                  height: largo * 0.06,
                                  width: ancho * 0.25,
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 214, 226, 218),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: const Color.fromARGB(255, 0, 113, 91),
                                      width: ancho * 0.005,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _valueSelected,
                                    maxLines: 1,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                                      LengthLimitingTextInputFormatter(8),
                                    ],
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                                      isDense: true,
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 41, 52, 65),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        _valueSelected.text = "0";
                                        _valueSelected.selection = TextSelection.fromPosition(
                                          TextPosition(offset: _valueSelected.text.length),
                                        );
                                      } else {
                                        final doubleValue = double.tryParse(value) ?? 0.0;
                                        print("Valor ingresado como double: $doubleValue");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: ancho,
                    height: largo * 0.04,
                    decoration: BoxDecoration(
                      color: colorBusqueda,
                      border: Border.all(color: colorBusqueda),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }

  // INTERACCION CON AL API PARA OBTENER INFORMACION BASICA DE ALIMENTOS POR FILTRO
  Future<void> _searchFood(String name, String type, String region, String group, String nutrient, String operator, String value) async {

    if(value == ""){
      value = "0";
    }

    if (nutrient == ""){
      operator = "";
      value = "";
    }

    setState(() {
      _isLoading = true;
    });



    try {
      final List<FoodItem> items = await _apiService.getFoodsByFilters(
          name: name, type: type, region: region, group: group, nutrient: nutrient, operator: operator, value: value);

      setState(() {
        itemsList = items;
      });

      _generateCards(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
          MediaQuery.of(context).padding.top
      );
    } catch (e) {
      print('Error durante la búsqueda: $e');
      setState(() {
        itemsList = [];
        cardsList.clear();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  // OBTENER TODAS LAS REGIONES DE LA DB
  Future<void> loadRegionOptions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, List<dynamic>> regionsData = await _apiService.getRegions();
      final List<String> regions = regionsData['names'] as List<String>;
      final List<int> regionIds = regionsData['ids'] as List<int>;

      setState(() {
        regionOptions.clear();
        regionOptions.add('Seleccionar todos');
        regionOptions.addAll(regions);

        regionIDs.clear();
        regionIDs.add(-1);
        regionIDs.addAll(regionIds);
      });
    } catch (e) {
      print('Error al cargar las opciones de regiones: $e');
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // OBTENER TODOS LOS NUTRIENTES DE LA DB
  Future<void> loadNutrientsOptions() async {
    try {
      final Map<String, List<dynamic>> nutrientsData = await _apiService.getAllNutrients();
      final List<String> nutrients = nutrientsData['names'] as List<String>;
      final List<int> nutrientsIds = nutrientsData['ids'] as List<int>;
      setState(() {
        nutrientsOptions.clear();
        nutrientsOptions.addAll(nutrients);

        nutrientsIDs.clear();
        nutrientsIDs.addAll(nutrientsIds);
      });
    } catch (e) {
      print('Error al cargar los nutrientes: $e');
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // OBTENER TODAS LOS TIPOS DE LA DB
  Future<void> loadTypesOptions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<String> regions = await _apiService.getFoodTypes();

      setState(() {
        typeOptions.clear();
        typeOptions.add('Seleccionar todos');
        typeOptions.addAll(regions);
      });
    } catch (e) {
      print('Error al cargar las opciones de tipos: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // OBTENER TODoS LOS GRUPOS DE LA DB
  Future<void> loadGroupsOptions() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final List<String> groups = await _apiService.getFoodGroups();
      setState(() {
        groupOptions.clear();
        groupOptions.add('Seleccionar todos');
        groupOptions.addAll(groups);
      });
    } catch (e) {
      print('Error al cargar los grupos alimentarios: $e');
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

// GENERA LAS CARTAS DE ALIMENTOS EN BASE A LA CANTIDAD DE ALIMENTOS EN ITEMS
  void _generateCards(double ancho, double largo, double extraTop) {
    largo = largo - extraTop - kBottomNavigationBarHeight;
    cardsList.clear();

    cardsList.add(Container(
      height: extraTop + largo * 0.08 + largo * 0.08 + largo * 0.04,
    ));
    cardsList.add(SizedBox(
      height: largo * 0.02,
    ));

    for (FoodItem item in itemsList) {
      final bool alreadyInCompareList = widget.compareList.any((element) => element.code == item.code);
      if (alreadyInCompareList && !item.compare) {
        item.changeState();
        print("food encontrado");
      }
    }

    for (FoodItem item in itemsList) {
      cardsList.add(
        FoodCard(
          ancho: ancho * 0.9,
          largo: largo * 0.135,
          data: item,
          compareList: widget.compareList,
          quantityToCompare: widget.quantityToCompare,
          onQuantityChanged: widget.onQuantityChanged,
        ),
      );
      cardsList.add(SizedBox(
        height: largo * 0.02,
      ));
    }
  }

  // METODO PARA REFREZACART EL ESTADO DE LA VENTANA CUANDO S EVUELVA A INGRESAR A ESTA
  void resfresh() {
    setState(() {});
  }
}
