import 'package:flutter/material.dart';
import 'package:food_app/src/theme/app_themes.dart';
import 'package:food_app/src/theme/app_text_styles.dart';

class Card2 extends StatelessWidget {
  final double width;
  final double height;

  const Card2({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    String text_1 = "CAPCHICAL se fundó en 1984 gracias a la colaboración de académicos y laboratorios privados, expandiendo su red a nivel nacional e internacional. Inicialmente llamada CHILEFOODS, adoptó el nombre CAPCHICAL en 2009. Ha participado en proyectos clave de la FAO, impulsando el desarrollo de bases de datos de alimentos y el intercambio científico en Latinoamérica.";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * 0.5,
          height: height * 0.15,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.colors.primary,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(13),topLeft: Radius.circular(13)),
          ),
          child: Text("Historia & Trayectoria",style: AppTextStyles.subTitle(height * 2)),
        ),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'lib/assets/images/background_capchical.jpg',
                width: width * 0.8,
                height: height * 0.85,
                fit: BoxFit.cover,
              ),
            ),

            Container(
              width: width * 0.8,
              height: height * 0.85,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppTheme.colors.white.withOpacity(0.9),
                border: Border.all(
                  color: AppTheme.colors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 6),
                    blurRadius: 18,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.7,
                    height: height * 0.85,
                    child: Text(
                      text_1,
                      style: AppTextStyles.body(width * 1.7),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}