import 'package:flutter/material.dart';
import 'package:food_app/src/theme/app_text_styles.dart';
import 'package:food_app/src/theme/app_themes.dart';
import 'package:food_app/src/widgets/cards/card_1.dart';
import 'package:food_app/src/widgets/cards/card_2.dart';
import 'package:food_app/src/widgets/cards/card_3.dart';
import 'package:food_app/src/widgets/cards/card_4.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  static const title = "Base de Datos de Composición de Alimentos";
  static const subTitle = "Bienvenido a nuestra";


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final extraTop = MediaQuery.of(context).padding.top;
    final largo = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height - kBottomNavigationBarHeight - extraTop;

    const topZoneFactor = 0.45;

    return Scaffold(
      backgroundColor: AppTheme.colors.surface,
      body: Column(
        children: [
          Container(
            height: extraTop,
            color: AppTheme.colors.primary,
          ),

          Expanded(
            child: Stack(
              children: [

                // Top zone
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: topZoneFactor,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          color: AppTheme.colors.primary,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(subTitle,style: AppTextStyles.subTitle(alto)),
                              Text(title,style: AppTextStyles.title(alto), textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Container(
                                decoration: BoxDecoration(
                                    color:AppTheme.colors.primary,
                                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30.0) ,bottomLeft: Radius.circular(30.0))
                                ),
                              ),
                            ),

                            Expanded(flex: 8, child: Container()),

                            Expanded(
                              flex: 9,
                              child: Container(
                                decoration: BoxDecoration(
                                    color:AppTheme.colors.primary,
                                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30.0) ,bottomLeft: Radius.circular(30.0))
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ),



              ],
            ),
          )
        ],
      )
    );
  }
}
