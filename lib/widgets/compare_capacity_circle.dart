
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompareCapacityCircle extends StatefulWidget {
  final double ancho;
  final int current;
  final int maxCapacity;

  const CompareCapacityCircle({
    Key? key,
    required this.ancho,
    required this.current,
    required this.maxCapacity,
  }) : super(key: key);

  @override
  State<CompareCapacityCircle> createState() => _CompareCapacityCircleState();
}

class _CompareCapacityCircleState extends State<CompareCapacityCircle> {
  @override
  Widget build(BuildContext context) {
    double progress = widget.current / widget.maxCapacity;

    return Container(
      width: widget.ancho,
      height: widget.ancho,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: widget.ancho * 0.7,
                height: widget.ancho * 0.7,
                child: CircularProgressIndicator(
                  value: progress, // Progreso actual
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(
                      255, 62, 200, 107)),
                  strokeWidth: 5,
                ),
              ),

              // Círculo interno blanco con el texto (valor actual / capacidad máxima)
              Container(
                width: widget.ancho * 0.7,
                height: widget.ancho * 0.7,
                decoration:  BoxDecoration(
                  color: Color.fromARGB(216, 255, 255, 255),
                  shape: BoxShape.circle, // Hace que el contenedor sea circular
                ),
                alignment: Alignment.center,
                child: Text(
                  "${widget.current}/${widget.maxCapacity}",
                  style: GoogleFonts.lato(
                    textStyle:  TextStyle(
                      fontSize: widget.ancho*0.16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}