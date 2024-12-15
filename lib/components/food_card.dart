import 'package:flutter/material.dart';
import 'package:food_app/components/food_item.dart';
import 'package:food_app/components/index.dart';

class FoodCard extends StatefulWidget {
  final double ancho;
  final double largo;
  final FoodItem data;
  final List<FoodItem> compareList;

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

    return Stack(
      children: [
        // MANEJO DE REACION PARA OBTENER INFORMACION DEL ALIMENTO
        GestureDetector(
            onTap: () {
              showInfo(context, widget.data);
            },
            child: Material(
              elevation: 5,
              child: Container(
                height: widget.largo,
                width: widget.ancho,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border(bottom: BorderSide(color: Color.fromARGB(
                      255, 225, 122, 148), width: 4)),
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          // ICONO REPRESENTATIVO
                          Padding(
                            padding: EdgeInsets.only(
                                left: widget.ancho * 0.04,
                                right: widget.ancho * 0.02),
                            child: Container(
                              width: widget.largo * 0.8,
                              height: widget.largo * 0.8,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Icon(
                                Icons.fastfood,
                                size: widget.largo * 0.5,
                                color: const Color.fromARGB(255, 176, 198, 221),
                              ),
                            ),
                          ),

                          // INFO DEL ALIMENTO
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: widget.ancho * 0.55,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Code: " + widget.data.code,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: widget.ancho * 0.5,
                                alignment: Alignment.centerLeft,
                                child: Text("ID: " + widget.data.id),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),

        // BOTON AÑADIR A COMPARACION
        Container(
          width: widget.ancho,
          height: widget.largo,
          alignment: Alignment.centerRight,
          child: Padding(
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
          ),
        )
      ],
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

  void showInfo(BuildContext context, FoodItem data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodPage(foodItem: data),
      ),
    );
  }
}
