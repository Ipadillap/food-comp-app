import 'package:flutter/material.dart';
import 'package:food_app/objects/index.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width.toDouble();
    double largo = MediaQuery.of(context).size.height.toDouble();

    return Container(
      width: ancho,
      height: largo,
      color: Color.fromARGB(255, 214, 226, 218),
      alignment: AlignmentDirectional.center,
      child: Text("Info Page")
    );
  }
}