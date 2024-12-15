import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

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
      child: Row(
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
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: [
                            SizedBox(
                              width: widget.ancho * 0.05,
                            ),
                            Text(
                              selectedOption ?? widget.hintText,
                              style: TextStyle(color: theme),
                            ),
                          ],
                        )),
                    Row(
                      children: [
                        if (widget.seeArrow)
                          Icon(Icons.arrow_drop_down, color: theme),
                      ],
                    ),
                  ],
                ),
                items: widget.options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: widget.ancho * 0.05),
                      height: widget.largo * 1.5,
                      child: Text(option),
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

          if (selectedOption != null)
            IconButton(
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
        ],
      ),
    );
  }
}
