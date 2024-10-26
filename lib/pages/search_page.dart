import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/objects/food_item.dart';
import 'package:food_app/objects/index.dart';

class SearchPage extends StatefulWidget {
  List<FoodItem> compareList;

  SearchPage({
    Key? key,
    required this.compareList,
  }) : super(key: key);
  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final DraggableScrollableController _scrollController = DraggableScrollableController();
  final GlobalKey<FoodCardState> foodCardState = GlobalKey<FoodCardState>();


  bool isKeyboardVisible = false;
  bool scrollOpen = false;
  int cant = 10;
  List<Widget> lista = [];
  double minExpand = 0.17;
  double maxExpand = 0.68;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double position = _scrollController.size;

      if (position >= 0.50 && !scrollOpen) {
        setState(() {
          scrollOpen = true;
        });
      } else if (position < 0.50 && scrollOpen) {
        setState(() {
          scrollOpen = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    double extraTop = MediaQuery.of(context).padding.top;
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble();
    double teclado = MediaQuery.of(context).viewInsets.bottom;
  
    lista.clear();
    for (int i = 0; i < 6; i++) {
      
      FoodItem food= FoodItem(id: i, name: "FOOD "+(i+1).toString(), compare: false);
      lista.add(FoodCard(ancho: ancho * 0.9, largo: largo * 0.1, data: food, compareList: widget.compareList,));
    }
    //lista.clear();

    if (teclado > 0 && !isKeyboardVisible && !scrollOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          maxExpand,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
      isKeyboardVisible = true;
    } else if (teclado == 0 && isKeyboardVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          minExpand,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
      isKeyboardVisible = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // FONDO DE VENTANA PRINCIPAL
          Container(
              width: ancho,
              height: largo,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: extraTop,
                    width: ancho,
                    color: Color.fromARGB(255, 214, 226, 218),
                  ),
                  Container(
                    height: largo * 0.75,
                    child: SingleChildScrollView(
                      child: Column(
                        children: lista,
                      ),
                    ),
                  )
                ],
              )),

          // DRAGGABLE SCROLLABLE SHEET
          DraggableScrollableSheet(
            controller: _scrollController,
            initialChildSize: minExpand,
            minChildSize: minExpand,
            maxChildSize: maxExpand,
            snap: true,
            snapSizes: [minExpand, maxExpand],
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                width: ancho,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey
                          .withOpacity(0.5), // Color de la sombra con opacidad
                      spreadRadius: 5, // Expansión de la sombra
                      blurRadius: 7, // Suavidad de la sombra
                      offset:
                          Offset(0, 3), // Desplazamiento de la sombra (x, y)
                    ),
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController, // Controla el deslizamiento
                  child: Column(
                    children: [

                      // Indicador de arrastre
                      Container(
                        width: ancho * 0.3,
                        height: ancho * 0.1,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 64, 80, 103),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        ),
                        child: IconButton(onPressed: (){
                          setState(() {
                            filterTogle();
                          });
                        },
                        icon: Icon(Icons.dehaze_rounded, color: Colors.white,)),
                      ),

                      SizedBox(height: largo * 0.025),

                      // BUSCADOR
                      SearchBarWidget(ancho: ancho * 0.9, largo: largo * 0.06),

                      SizedBox(height: largo * 0.03),

                      // FILTRO DATA_SET
                      Column(
                        children: [
                          Container(
                            width: ancho * 0.8,
                            alignment: AlignmentDirectional.centerStart,
                            child: const Text("Data Set"),
                          ),
                          OptionSelectorWidget(
                            hintText: 'Selecciona una opción',
                            options: const ['Opción 1', 'Opción 2', 'Opción 3'],
                            onSelected: (selected) {
                              print('Opción seleccionada: $selected');
                            },
                            ancho: ancho * 0.9,
                            largo: largo * 0.05,
                            cantOptions: 4,
                            seeArrow: true,
                          ),
                        ],
                      ),
                      SizedBox(height: largo * 0.03),

                      // FILTRO CATEGORIES
                      Column(
                        children: [
                          Container(
                            width: ancho * 0.8,
                            alignment: AlignmentDirectional.centerStart,
                            child: const Text("Categories"),
                          ),
                          OptionSelectorWidget(
                            hintText: 'Selecciona una opción',
                            options: const [
                              'Opción 1',
                              'Opción 2',
                              'Opción 3',
                              'Opción 4',
                              'Opción 5',
                              'Opción 6',
                              'Opción 7',
                              'Opción 8',
                              'Opción 9',
                              'Opción 10',
                              'Opción 11',
                              'Opción 12',
                              'Opción 13',
                              'Opción 14',
                              'Opción 15',
                              'Opción 16',
                              'Opción 17',
                              'Opción 18',
                            ],
                            onSelected: (selected) {
                              print('Opción seleccionada: $selected');
                            },
                            ancho: ancho * 0.9,
                            largo: largo * 0.05,
                            cantOptions: 4,
                            seeArrow: true,
                          ),
                        ],
                      ),
                      SizedBox(height: largo * 0.03),

                      // FILTRO SUB_CATEGORIES
                      Column(
                        children: [
                          Container(
                            width: ancho * 0.8,
                            alignment: AlignmentDirectional.centerStart,
                            child: const Text("Sub Categories"),
                          ),
                          OptionSelectorWidget(
                            hintText: 'Selecciona una opción',
                            options: const [
                              'Opción 1',
                              'Opción 2',
                              'Opción 3',
                              'Opción 4',
                            ],
                            onSelected: (selected) {
                              print('Opción seleccionada: $selected');
                            },
                            ancho: ancho * 0.9,
                            largo: largo * 0.05,
                            cantOptions: 4,
                            seeArrow: true,
                          ),
                        ],
                      ),

                      SizedBox(height: largo * 0.03),

                      Container(
                        width: ancho * 0.8,
                        height: largo * 0.05,
                        alignment: AlignmentDirectional.center,
                        child: const Text("Nutrient Content"),
                      ),
                      _buildNutrientContent(ancho, largo),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

void filterTogle() {
  if (_scrollController.size == minExpand) {
    _scrollController.animateTo(
      maxExpand,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  } else {
    _scrollController.animateTo(
      minExpand,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}


  Widget _buildNutrientContent(double ancho, double largo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OptionSelectorWidget(
          hintText: 'Nutrient',
          options: const ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'],
          onSelected: (selected) {
            print('Opción seleccionada: $selected');
          },
          ancho: ancho * 0.4,
          largo: largo * 0.05,
          cantOptions: 4,
          seeArrow: true,
        ),
        SizedBox(width: ancho * 0.05),
        MatematicSelectorWidget(
          hintText: '=',
          options: const ['=', '<', '>'],
          onSelected: (selected) {
            print('Opción seleccionada: $selected');
          },
          ancho: ancho * 0.15,
          largo: largo * 0.05,
          cantOptions: 3,
          color: const Color.fromARGB(255, 236, 236, 236),
          borderColor: const Color.fromARGB(255, 185, 185, 185),
          seeArrow: false,
        ),
        SizedBox(width: ancho * 0.05),
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
            maxLines: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
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
              // Lógica para manejar el valor ingresado
            },
          ),
        ),
      ],
    );
  }
  
  void resfresh() {
    print("s");
    for(int i=0; i<lista.length; i++){
      foodCardState.currentState?.resfresh();
    }
  }
}
