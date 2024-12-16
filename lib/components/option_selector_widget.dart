import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionSelectorWidget extends StatefulWidget {
  final String hintText;
  final List<String> options;
  final ValueChanged<String?> onSelected;
  final double ancho;
  final double largo;
  final int cantOptions;
  final bool seeArrow;

  const OptionSelectorWidget({
    Key? key,
    required this.hintText,
    required this.options,
    required this.onSelected,
    required this.ancho,
    required this.largo,
    required this.cantOptions,
    required this.seeArrow,
  }) : super(key: key);

  @override
  _OptionSelectorWidgetState createState() => _OptionSelectorWidgetState();
}

class _OptionSelectorWidgetState extends State<OptionSelectorWidget> {
  String? selectedOption;
  Color background = const Color.fromARGB(255, 214, 226, 218);
  Color theme = const Color.fromARGB(255, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.ancho,
      height: widget.largo,
      decoration: BoxDecoration(
        border: Border.all(color: background),
        borderRadius: BorderRadius.circular(10),
        color: background,
      ),
      child: Stack(
        children: [
          /// Dropdown personalizado (texto y flecha)
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    barrierColor: const Color.fromARGB(52, 0, 0, 0),
                    value: selectedOption,
                    isExpanded: true,
                    customButton: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.ancho - (widget.largo * 2 + 2),
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            children: [
                              SizedBox(
                                width: widget.ancho * 0.05, // Espacio inicial
                              ),
                              Expanded(
                                child: Text(
                                  selectedOption ?? widget.hintText,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: widget.largo * 0.35,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: widget.largo,
                          height: widget.largo,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.seeArrow)
                                Icon(Icons.arrow_drop_down, color: theme),
                            ],
                          ),
                        ),
                      ],
                    ),
                    items: widget.options.map((String option) {
                      final isSelected = option == selectedOption;
                      return DropdownMenuItem<String>(
                        value: option,
                        enabled: !isSelected, // Bloquea la opción si está seleccionada
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: widget.ancho * 0.05),
                          height: widget.largo * 1.5,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.grey.withOpacity(0.3) // Fondo más oscuro si está seleccionado
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            option,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: widget.largo * 0.35,
                                fontWeight: FontWeight.normal,
                                color: isSelected ? Colors.grey : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue;
                      });
                      widget.onSelected(newValue);
                    },
                    dropdownStyleData: DropdownStyleData(
                      padding: const EdgeInsets.all(0),
                      maxHeight: widget.largo * widget.cantOptions,
                      offset: const Offset(0, 0),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: widget.largo,
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (selectedOption != null)
            Positioned(
              right: widget.largo,
              top: 0,
              bottom: 0,
              child: Container(
                width: widget.largo,
                height: widget.largo,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: theme,
                    size: widget.largo * 0.5,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedOption = null;
                    });
                    widget.onSelected(null);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
