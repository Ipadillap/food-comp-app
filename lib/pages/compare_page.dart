import 'package:flutter/material.dart';
import 'package:food_app/objects/food_compare_card.dart';
import 'package:food_app/objects/food_item.dart';

class ComparePage extends StatefulWidget {
  final List<FoodItem> compareList;

  ComparePage({
    Key? key,
    required this.compareList,
  }) : super(key: key);

  @override
  ComparePageState createState() => ComparePageState();
}

class ComparePageState extends State<ComparePage> {
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble();

    List<Widget> compare = [];

    for (int i = 0; i < widget.compareList.length; i++) {
      compare.add(FoodCompareCard(
        ancho: ancho * 0.9,
        largo: largo * 0.1,
        data: widget.compareList[i],
        compareList: widget.compareList,
        refresh: resfresh,
      ));
    }

    return Container(
        width: ancho,
        height: largo,
        color: Color.fromARGB(255, 214, 226, 218),
        alignment: AlignmentDirectional.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: compare,
          ),
        ));
  }

  void resfresh() {
    setState(() {});
  }
}
