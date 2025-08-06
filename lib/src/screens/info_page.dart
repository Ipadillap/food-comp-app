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

    const borderRadius = 30.0;
    final circleRadius= largo*0.33 / 2;

    return Scaffold(
      backgroundColor: AppTheme.colors.surface,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Top zone
          Column(
            children: [
              Container(
                width: largo,
                height: extraTop,
                color: AppTheme.colors.primary,
              ),

              Container(
                width: largo,
                height: alto * 0.45 - circleRadius,
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

              Row(
                children: [
                  Container(
                    width: largo/2 -circleRadius,
                    height: circleRadius,
                    decoration: BoxDecoration(
                        color:AppTheme.colors.primary,
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(borderRadius) ,bottomLeft: Radius.circular(borderRadius))
                    ),
                  ),
                  Container(
                    width: 2 * circleRadius,
                    height: circleRadius,
                    color: AppTheme.colors.surface,
                  ),
                  Container(
                    width: largo/2 -circleRadius,
                    height: circleRadius,
                    decoration: BoxDecoration(
                      color:AppTheme.colors.primary,
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(borderRadius) ,bottomLeft: Radius.circular(borderRadius))
                    ),
                  ),
                ],
              ),

            ],
          ),

          // Circle zone
          Column(
            children: [
              SizedBox(
                width: largo,
                height: extraTop + alto * 0.42 - circleRadius,
              ),
              Stack(
                children: [
                  Container(
                    width: circleRadius * 2,
                    height: circleRadius,
                    color: AppTheme.colors.primary,
                  ),
                  Container(
                    width: circleRadius * 2,
                    height: circleRadius * 2,
                    decoration: BoxDecoration(
                      color: AppTheme.colors.surface,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              )
            ],
          ),

          // Picture
          Column(
            children: [
              SizedBox(
                width: largo,
                height: extraTop + alto * 0.45 - circleRadius,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: largo*0.02,
                  ),
                  Image.asset(
                    'lib/assets/icons/diet_food.png',
                    scale: largo * 0.014,
                  ),
                ],
              )
            ],
          ),

          // Bottom zone
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: largo,
                height: (alto * 0.55 - circleRadius) * 0.8,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    Center(child: Card1(width: largo, height: (alto * 0.55 - circleRadius) * 0.8),),
                    Center(child: Card2(width: largo, height: (alto * 0.55 - circleRadius) * 0.8),),
                    Center(child: Card3(width: largo, height: (alto * 0.55 - circleRadius) * 0.8),),
                    Center(child: Card4(width: largo, height: (alto * 0.55 - circleRadius) * 0.8),),
                  ],
                ),
              ),

              SizedBox(
                width: largo,
                height: alto*0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppTheme.colors.primary
                            : AppTheme.colors.primaryLight,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
