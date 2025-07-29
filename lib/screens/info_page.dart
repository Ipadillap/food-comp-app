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
    final extraTop = MediaQuery.of(context).padding.top;
    final ancho = MediaQuery.of(context).size.width;
    final largo = MediaQuery.of(context).size.height - kBottomNavigationBarHeight;
    final circleSize = 0.33;
    final colorSuperior = const Color(0xFFDB5375);
    final colorBackground = const Color(0xFFFAFAFA);
    final colorInfo = const Color(0xFFAACCC6);
    final borde = 35.0;
    final sizeWords = largo * 0.02;

    return Scaffold(
      backgroundColor: colorBackground,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Fondo decorativo
          Row(
            children: [
              Container(
                width: ancho * circleSize + 2,
                height: largo * 0.45,
                decoration: BoxDecoration(
                  color: colorSuperior,
                  border: Border.all(width: 0, color: colorSuperior),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(35)),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  height: largo * 0.45,
                  child: Container(
                    width: ancho * (1 - (circleSize * 2)),
                    height: largo * 0.41,
                    decoration: BoxDecoration(
                      color: colorSuperior,
                      border: Border.all(width: 0, color: colorSuperior),
                    ),
                  ),
                ),
              ),
              Container(
                width: ancho * circleSize + 2,
                height: largo * 0.45,
                decoration: BoxDecoration(
                  color: colorSuperior,
                  border: Border.all(width: 0, color: colorSuperior),
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35)),
                ),
              ),
            ],
          ),
          // Zona de bienvenida
          Container(
            width: ancho * 0.9,
            height: largo * 0.4,
            color: colorSuperior,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bienvenido a nuestra",
                  style: TextStyles.subtitle,
                ),
                Text(
                  "Base de Datos de Composición de Alimentos",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: largo * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Contenido principal
          Column(
            children: [
              SizedBox(height: largo * 0.34),
              // Icono
              Container(
                width: ancho * (1 - (circleSize * 2)),
                height: ancho * (1 - (circleSize * 2)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorBackground,
                  border: Border.all(width: 0, color: colorBackground),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
                child: Image.asset(
                  'lib/assets/icons/diet_food.png',
                  scale: ancho * 0.015,
                ),
              ),
              // Información + PageView
              Expanded(
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
                    SizedBox(
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
                          _buildInfoCard(
                            ancho: ancho,
                            largo: largo,
                            colorInfo: colorInfo,
                            sizeWords: sizeWords,
                            text:
                            "El Capítulo Chileno de Composición de Alimentos (CAPCHICAL) es una red nacional activa desde 1984 que reúne a investigadores, académicos e instituciones públicas y privadas. Su objetivo principal es generar, analizar y difundir información sobre la composición química y nutricional de los alimentos en Chile.",
                          ),
                          _buildInfoCard(
                            ancho: ancho,
                            largo: largo,
                            colorInfo: colorInfo,
                            sizeWords: sizeWords,
                            text:
                            "CAPCHICAL está integrado en la Red Latinoamericana de Composición de Alimentos, LATINFOODS, con 19 Capítulos en Latinoamérica, que a su vez es parte de la Red Internacional INNFODDS y que ha contado con el apoyo de FAO en la realización de sus actividades de carácter Internacional.",
                          ),
                          _buildObjetivosCard(
                            ancho: ancho,
                            largo: largo,
                            colorInfo: colorInfo,
                            sizeWords: sizeWords,
                            objetivos: [
                              "1) Generar y actualizar datos sobre alimentos chilenos para una base confiable en el MINSAL.",
                              "2) Colaborar con el gobierno en análisis de nutrientes y etiquetado nutricional.",
                            ],
                          ),
                          _buildObjetivosCard(
                            ancho: ancho,
                            largo: largo,
                            colorInfo: colorInfo,
                            sizeWords: sizeWords,
                            objetivos: [
                              "3) Formar especialistas en alimentación y salud.",
                              "4) Fomentar investigación en alimentos nativos y saludables.",
                              "5) Difundir conocimientos mediante seminarios y educación.",
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Indicadores de página
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFF28A537)
                                : const Color(0xFFBDDBC1),
                            borderRadius: BorderRadius.circular(50),
                            shape: BoxShape.rectangle,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required double ancho,
    required double largo,
    required Color colorInfo,
    required double sizeWords,
    required String text,
  }) {
    return Center(
      child: Container(
        width: ancho * 0.9,
        height: largo * 0.3,
        decoration: BoxDecoration(
          color: colorInfo,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(ancho * 0.05),
        child: Text(
          text,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: sizeWords,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _buildObjetivosCard({
    required double ancho,
    required double largo,
    required Color colorInfo,
    required double sizeWords,
    required List<String> objetivos,
  }) {
    return Center(
      child: Container(
        width: ancho * 0.9,
        height: largo * 0.3,
        decoration: BoxDecoration(
          color: colorInfo,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.all(ancho * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Objetivos CAPCHICAL\n",
              style: TextStyle(
                fontSize: sizeWords,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
            ...objetivos.map((obj) => Text(
              obj,
              style: TextStyle(
                fontSize: sizeWords,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            )),
          ],
        ),
      ),
    );
  }

}