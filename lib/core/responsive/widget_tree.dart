import 'package:flutter/material.dart';
import 'package:mypets/core/responsive/responsive_layout.dart';

class WidgetTree extends StatefulWidget {
  final Widget tiny;
  final Widget phone;
  final Widget tablet;
  final Widget largeTablet;
  final Widget computer;
  const WidgetTree({
    Key? key,
    required this.tiny,
    required this.phone,
    required this.tablet,
    required this.largeTablet,
    required this.computer,
  }) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      tiny: widget.tiny,
      phone: widget.phone,
      tablet: widget.tablet,
      largeTablet: widget.largeTablet,
      computer: widget.computer,
    );
  }
}
