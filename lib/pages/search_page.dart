import 'package:flutter/material.dart';
import 'package:food_app/objects/index.dart'; // Asegúrate de tener la importación correcta
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    double extraTop = MediaQuery.of(context).padding.top;
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble();
    double teclado = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // FONDO DE VENTANA PRINCIPAL
          Container(
            width: ancho,
            height: largo,
            color: const Color.fromARGB(255, 212, 220, 231),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.17, // Estado cerrado
            minChildSize: 0.17, // Mínimo cerrado
            maxChildSize: 0.75, // Estado abierto completo
            snap: true, // Habilita los estados "pegajosos"
            snapSizes: [0.17, 0.75], // Define los tamaños donde "pegarse"
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                width: ancho,
                decoration: const BoxDecoration(
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
                      // Espaciado
                      SizedBox(height: largo * 0.03),

                      Container(
                        width: ancho * 0.4,
                        height: largo * 0.008,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 224, 224, 224),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      // Espaciado
                      SizedBox(height: largo * 0.03),

                      // BUSCADOR
                      SearchBarWidget(ancho: ancho * 0.9, largo: largo * 0.06),

                      // Espaciado
                      SizedBox(height: largo * 0.03),

                      // FILTRO DATA_SET
                      Column(
                        children: [
                          Container(
                            width: ancho * 0.8,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Data Set"),
                          ),
                          OptionSelectorWidget(
                            hintText: 'Selecciona una opción',
                            options: [
                              'Opción 1',
                              'Opción 2',
                              'Opción 3',
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

                      // Espaciado
                      SizedBox(height: largo * 0.03),

                      // FILTRO CATEGORIES
                      Column(
                        children: [
                          Container(
                            width: ancho * 0.8,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Categories"),
                          ),
                          OptionSelectorWidget(
                            hintText: 'Selecciona una opción',
                            options: [
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

                      // Espaciado
                      SizedBox(height: largo * 0.03),

                      // FILTRO SUB_CATEGORIES
                      Column(
                        children: [
                          Container(
                            width: ancho * 0.8,
                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Sub Categories"),
                          ),
                          OptionSelectorWidget(
                            hintText: 'Selecciona una opción',
                            options: [
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

                      // Espaciado
                      SizedBox(height: largo * 0.03),

                      // Espaciado
                      Container(
                        width: ancho * 0.8,
                        height: largo * 0.05,
                        alignment: AlignmentDirectional.center,
                        child: Text("Nutrient Content"),
                      ),

                      // FILTROS, CATEGORÍAS, ETC.
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

  Widget _buildNutrientContent(double ancho, double largo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SELECTOR NUTRIENTE
        OptionSelectorWidget(
          hintText: 'Nutrient',
          options: [
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
          ancho: ancho * 0.4,
          largo: largo * 0.05,
          cantOptions: 4,
          seeArrow: true,
        ),

        SizedBox(width: ancho * 0.05),

        // RELACION
        MatematicSelectorWidget(
          hintText: '=',
          options: [
            '=',
            '<',
            '>',
          ],
          onSelected: (selected) {
            print('Opción seleccionada: $selected');
          },
          ancho: ancho * 0.15,
          largo: largo * 0.05,
          cantOptions: 3,
          color: Color.fromARGB(255, 236, 236, 236),
          borderColor: Color.fromARGB(255, 185, 185, 185),
          seeArrow: false,
        ),

        SizedBox(width: ancho * 0.05),

        // CANTIDAD NUTRIENTE
        Container(
          height: largo * 0.06,
          width: ancho * 0.25,
          alignment:
              AlignmentDirectional.center, // Alinea el contenido del container
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 214, 226, 218),
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
            keyboardType: TextInputType.number, // Muestra el teclado numérico
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Solo permite números
              LengthLimitingTextInputFormatter(4), // Limita a 4 dígitos
            ],
            textAlign: TextAlign.center, // Centra el texto dentro del TextField
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 0), // Elimina padding vertical extra
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
}
