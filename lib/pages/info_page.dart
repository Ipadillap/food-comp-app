import 'package:flutter/material.dart';
import 'package:food_app/theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double extraTop = MediaQuery.of(context).padding.top;
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble() - kBottomNavigationBarHeight;
    final PageController _pageController = PageController();
    double circleSize = 0.33;
    Color colorSuperior = const Color.fromARGB(255, 219, 83, 117);
    Color colorBackground = Color.fromARGB(255, 250, 250, 250);
    Color colorInfo = Color.fromARGB(255, 170, 204, 198);
    double borde = 35;
    double sizeWords = largo*0.02;

    return Scaffold(
      backgroundColor: colorBackground,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // DISENO DE FONDO
          Row(
            children: [
              Container(
                width: ancho * circleSize + 2,
                height: largo * 0.45,
                decoration: BoxDecoration(
                    color: colorSuperior,
                    border: Border.all(width: 0, color: colorSuperior),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(borde))),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: ancho * (1 - (circleSize * 2)),
                  height: largo * 0.45,
                  child: Container(
                    width: ancho * (1 - (circleSize * 2)),
                    height: largo * 0.41,
                    decoration: BoxDecoration(
                        color: colorSuperior,
                        border: Border.all(width: 0, color: colorSuperior)),
                  ),
                ),
              ),
              Container(
                width: ancho * circleSize + 2,
                height: largo * 0.45,
                decoration: BoxDecoration(
                    color: colorSuperior,
                    border: Border.all(width: 0, color: colorSuperior),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(borde))),
              ),
            ],
          ),

          //ZONA DE BIENVENIDA A CAPCHICAL
          Container(
            width: ancho * 0.9,
            height: largo * 0.4,
            color: colorSuperior,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bienvenido a",
                  style: TextStyles.subtitle,
                ),
                Text(
                  "CAPCHICAL",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                )
              ],
            ),
          ),

          Column(
            children: [
              SizedBox(
                height: largo * 0.34,
              ),

              // ZONA DE IMAGEN O ICONO
              Container(
                width: ancho * (1 - (circleSize * 2)),
                height: ancho * (1 - (circleSize * 2)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: colorBackground,
                    border: Border.all(width: 0, color: colorBackground),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Image.asset(
                  'lib/assets/icons/diet_food.png',
                  scale: ancho * 0.015,
                ),
              ),

              //ZONA DE INFORMACION DE CAPCHICAL
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Un poco sobre nosotros",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(218, 0, 0, 0),
                        ),
                      ),
                    ),
                    Container(
                      height: largo * 0.38,
                      width: ancho,
                      child: PageView(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (int index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: [
                          // INFORMACION GENERAL 1
                          GestureDetector(
                            child: Container(
                              child: Center(
                                child: Container(
                                  width: ancho * 0.9,
                                  height: largo * 0.3,
                                  decoration: BoxDecoration(
                                      color: colorInfo,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(ancho * 0.05),
                                      child: Text(
                                          "El Capítulo Chileno de Composición de Alimentos (CAPCHICAL) es una red nacional activa desde 1984 que reúne a investigadores, académicos e instituciones públicas y privadas. Su objetivo principal es generar, analizar y difundir información sobre la composición química y nutricional de los alimentos en Chile.",
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              fontSize: sizeWords,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),
                                          )
                                      )),
                                ),
                              ),
                            ),
                          ),

                          // INFORMACION GENERAL 2
                          GestureDetector(
                            child: Container(
                              child: Center(
                                child: Container(
                                  width: ancho * 0.9,
                                  height: largo * 0.3,
                                  decoration: BoxDecoration(
                                      color: colorInfo,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(ancho * 0.05),
                                    child: Text(
                                      "CAPCHICAL está integrado en la Red Latinoamericana de Composición de Alimentos, LATINFOODS, con 19 Capítulos en Latinoamérica, que a su vez es parte de la Red Internacional INNFODDS y que ha contado con el apoyo de FAO en la realización de sus actividades de carácter Internacional.",
                                      style: TextStyle(
                                        fontSize: sizeWords,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87,
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // INFORMACION OBJETIVOS 1
                          GestureDetector(
                            child: Container(
                              child: Center(
                                child: Container(
                                    width: ancho * 0.9,
                                    height: largo * 0.3,
                                    decoration: BoxDecoration(
                                        color: colorInfo,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(ancho * 0.05),
                                      child: Column(
                                        children: [
                                          Text("Objetivos CAPCHICAL\n",
                                            style: TextStyle(
                                              fontSize: sizeWords,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),),
                                          Text(
                                              "1) Generar y actualizar datos sobre alimentos chilenos para una base confiable en el MINSAL.",
                                            style: TextStyle(
                                              fontSize: sizeWords,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),),
                                          Text(
                                              "2) Colaborar con el gobierno en análisis de nutrientes y etiquetado nutricional.",
                                              style: TextStyle(
                                                fontSize: sizeWords,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black87,
                                              ),),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),

                          // INFORMACION OBJETIVOS 2
                          GestureDetector(
                            child: Container(
                              child: Center(
                                child: Container(
                                    width: ancho * 0.9,
                                    height: largo * 0.3,
                                    decoration: BoxDecoration(
                                        color: colorInfo,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(ancho * 0.05),
                                      child: Column(
                                        children: [
                                          Text("Objetivos CAPCHICAL\n",
                                            style: TextStyle(
                                              fontSize: sizeWords,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),),
                                          Text(
                                              "3) Formar especialistas en alimentación y salud.",
                                            style: TextStyle(
                                              fontSize: sizeWords,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),),
                                          Text(
                                              "4) Fomentar investigación en alimentos nativos y saludables.",
                                            style: TextStyle(
                                              fontSize: sizeWords,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),),
                                          Text(
                                              "5) Difundir conocimientos mediante seminarios y educación.",
                                            style: TextStyle(
                                              fontSize: sizeWords,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black87,
                                            ),),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: _currentPage == index ? 10 : 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Color.fromARGB(255, 40, 165, 55)
                                  : Color.fromARGB(255, 189, 219, 193),
                              borderRadius: BorderRadius.circular(50),
                              shape: BoxShape.rectangle,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          )


        ],
      ),
    );
  }
}
