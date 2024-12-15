import 'package:flutter/material.dart';

class DesplegableWidget extends StatefulWidget {
  final String title;
  final Widget content;
  final double ancho;
  final Duration animationDuration;
  final bool isExpandableUp;
  final Color color;

  const DesplegableWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.ancho,
    this.animationDuration = const Duration(milliseconds: 200),
    this.isExpandableUp = false,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  _DesplegableWidgetState createState() => _DesplegableWidgetState();
}

class _DesplegableWidgetState extends State<DesplegableWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _sizeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isExpandableUp)
          SizeTransition(
            sizeFactor: _sizeAnimation,
            axisAlignment: -1.0,
            child: Container(
              width: widget.ancho,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: widget.color,
              ),
              child: widget.content,
            ),
          ),
        GestureDetector(
          onTap: _toggleExpansion,
          child: Container(
            width: widget.ancho,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: widget.color,
              border: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: Colors.black,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!widget.isExpandableUp)
          SizeTransition(
            sizeFactor: _sizeAnimation,
            axisAlignment: -1.0,
            child: Container(
              width: widget.ancho,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: widget.color,
              ),
              child: widget.content,
            ),
          ),
      ],
    );
  }
}
