import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopUpContainer extends StatefulWidget {
  final double ancho;
  final double largo;

  const PopUpContainer({Key? key, required this.ancho, required this.largo})
      : super(key: key);

  @override
  State<PopUpContainer> createState() => _PopUpContainerState();
}

class _PopUpContainerState extends State<PopUpContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Configurar AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Duración de la animación
      vsync: this,
    );

    // Curva de animación para el efecto de "pop"
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    // Iniciar la animación al aparecer el widget
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Función para reiniciar y ejecutar la animación
  void animate() {
    _controller.reset(); // Reinicia la animación
    _controller.forward(); // Ejecuta la animación nuevamente
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation, // Escala animada
      child: Container(
        height: widget.largo * 0.25,
        width: widget.ancho * 0.8,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        alignment: Alignment.center,
        child: Text(
          "No se seleccionó ningún\nalimento para comparar",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: widget.ancho * 0.05,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 236, 107, 107),
            ),
          ),
        ),
      ),
    );
  }
}
