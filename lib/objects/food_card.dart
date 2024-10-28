import 'package:flutter/material.dart';
import 'package:food_app/objects/food_item.dart';

class FoodCard extends StatefulWidget {
  final double ancho;
  final double largo;
  final FoodItem data;
  List<FoodItem> compareList;

  FoodCard({
    Key? key,
    required this.ancho,
    required this.largo,
    required this.data,
    required this.compareList,
  }) : super(key: key);
  @override
  State<FoodCard> createState() => FoodCardState();
}

class FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    bool add_state = widget.data.compare;

    return Container(
      height: widget.largo,
      width: widget.ancho,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border(bottom: BorderSide(color: Colors.blueGrey, width: 1)),
          borderRadius: BorderRadius.all(Radius.circular(0))),
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
                    color: const Color.fromARGB(255, 188, 199, 191),
                  ),
                ),
              ),

              // INFO DEL ALIMENTO
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: widget.ancho * 0.5,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.data.name,
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
              width: widget.largo * 0.5,
              height: widget.largo * 0.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: add_state
                      ? Color.fromARGB(255, 218, 89, 89)
                      : Color.fromARGB(255, 79, 180, 123)),
              child: IconButton(
                onPressed: () {
                  widget.data.changeState();
                  changeState(add_state);
                },
                icon: add_state ? Icon(Icons.remove) : Icon(Icons.add),
                iconSize: widget.largo * 0.3,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  void changeState(bool add_state) {
    if (add_state) {
      setState(() {
        for (int i = 0; i < widget.compareList.length; i++) {
          if (widget.compareList[i].id == widget.data.id) {
            widget.compareList.removeAt(i);
            i = widget.compareList.length;
          }
        }
      });
    } else {
      setState(() {
        widget.compareList.add(widget.data);
      });
    }
  }
}
