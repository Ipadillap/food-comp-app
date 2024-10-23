import 'package:flutter/material.dart';

class FoodCard extends StatefulWidget {
  final double ancho;
  final double largo;

  const FoodCard({
    Key? key,
    required this.ancho,
    required this.largo,
  }) : super(key: key);
  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.largo,
      width: widget.ancho,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // ICONO REPRESENTATIVO
              Padding(
                padding: EdgeInsets.only(
                    left: widget.ancho * 0.04, right: widget.ancho * 0.02),
                child: Container(
                  width: widget.largo * 0.8,
                  height: widget.largo * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Icon(
                    Icons.fastfood,
                    size: widget.largo * 0.5,
                    color: const Color.fromARGB(255, 218, 89, 89),
                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: widget.ancho * 0.5,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "WHAT SUS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: widget.ancho * 0.5,
                    alignment: Alignment.centerLeft,
                    child: Text("80g"),
                  ),
                ],
              )
            ],
          ),

          // BOTON AÑADIR A COMPARACION
          Padding(
            padding: EdgeInsets.only(right: widget.ancho * 0.04),
            child: Container(
              width: widget.largo * 0.6,
              height: widget.largo * 0.6,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color.fromARGB(255, 64, 80, 103)),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
                iconSize: widget.largo * 0.4,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
