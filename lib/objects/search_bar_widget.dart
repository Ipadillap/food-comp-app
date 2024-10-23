import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final double ancho;
  final double largo;

  const SearchBarWidget({
    Key? key,
    required this.ancho,
    required this.largo,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.ancho,
      height: widget.largo,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          // Campo de búsqueda
          Container(
            height: widget.largo,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 236, 236, 236),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Nombre o ID de alimento',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(157, 41, 52, 65),
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // Lógica para manejar el texto de búsqueda
                    },
                  ),
                ),
              ],
            ),
          ),

          // Botón de búsqueda
          Container(
            width: widget.largo,
            height: widget.largo,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 236, 236, 236),
            ),
            child: Container(
              width: widget.largo,
              height: widget.largo,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 64, 80, 103),
              ),
              child: IconButton(
                icon: const Icon(Icons.search),
                color: const Color.fromARGB(255, 236, 236, 236),
                onPressed: () {},
                iconSize: widget.largo * 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
