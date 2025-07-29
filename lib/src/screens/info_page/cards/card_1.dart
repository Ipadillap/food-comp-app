import 'package:flutter/material.dart';
import 'package:food_app/src/theme/app_themes.dart';

class Card1 extends StatelessWidget {
  final double width;
  final double height;

  const Card1({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * 0.5,
          height: height * 0.15,
          decoration: BoxDecoration(
              color: AppTheme.colors.primary,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(13),topLeft: Radius.circular(13)),
          ),
        ),
        Container(
          width: width * 0.8,
          height: height * 0.85,
          decoration: BoxDecoration(
            color: AppTheme.colors.white,
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
        )
      ],
    );
  }
}