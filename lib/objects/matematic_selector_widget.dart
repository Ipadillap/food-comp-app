import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MatematicSelectorWidget extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final ValueChanged<String?> onSelected;
  final double ancho;
  final double largo;
  final Color color;
  final Color borderColor;
  final int cantOptions;
  final bool seeArrow;

  const MatematicSelectorWidget({
    Key? key,
    required this.hintText,
    required this.options,
    required this.onSelected,
    required this.ancho,
    required this.largo,
    required this.color,
    required this.borderColor,
    required this.cantOptions,
    required this.seeArrow,
  }) : super(key: key);

  @override
  _MatematicSelectorWidgetState createState() =>
      _MatematicSelectorWidgetState();
}

class _MatematicSelectorWidgetState extends State<MatematicSelectorWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.ancho,
      height: widget.largo,
      decoration: BoxDecoration(
        border: Border.all(color: widget.borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          barrierColor: const Color.fromARGB(52, 0, 0, 0),
          value: selectedOption,
          hint: Text(widget.hintText),
          isExpanded: true,
          items: widget.options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Container(
                alignment: Alignment.center,
                child: Text(option),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue;
            });
            widget.onSelected(newValue); // Notifica el valor seleccionado
          },
          customButton: widget.seeArrow
              ? null
              : Container(
                  width: widget.ancho,
                  height: widget.largo,
                  alignment: Alignment.center,
                  child: Text(
                    selectedOption ?? widget.hintText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ), // Si no queremos la flecha, renderizamos un widget personalizado
          dropdownStyleData: DropdownStyleData(
            padding: EdgeInsets.all(0),
            maxHeight:
                widget.largo * 5, // Limita el número de opciones visibles
            offset:
                const Offset(0, 0), // Posiciona el dropdown debajo del botón
          ),
          menuItemStyleData: MenuItemStyleData(
            height: widget.largo, // Ajusta la altura de cada opción
            padding: const EdgeInsets.all(0), // Evita padding adicional
          ),
        ),
      ),
    );
  }
}
