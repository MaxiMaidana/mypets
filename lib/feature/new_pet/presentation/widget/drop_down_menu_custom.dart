import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DropDownMenuCustom extends StatefulWidget {
  final List<String> items;
  final String valueCharged;
  final String initTitle;
  final Function(String) function;
  const DropDownMenuCustom({
    super.key,
    required this.items,
    required this.function,
    required this.valueCharged,
    required this.initTitle,
  });

  @override
  State<DropDownMenuCustom> createState() => _DropDownMenuCustomState();
}

class _DropDownMenuCustomState extends State<DropDownMenuCustom> {
  String? valueSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFF6750A4).withOpacity(0.3),
          borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: 8.5.h,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: Text(widget.valueCharged == ''
                ? widget.initTitle
                : widget.valueCharged),
          ),
          value: valueSelected,
          iconSize: 35,
          borderRadius: BorderRadius.circular(20),
          icon: const Icon(
            Icons.arrow_drop_down_outlined,
            color: Colors.black,
          ),
          items: widget.items.map((e) => _buildMenuItem(e)).toList(),
          onChanged: (v) => setState(() => valueSelected = v!),
        ),
      ),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        onTap: () => widget.function(item),
        child: Padding(
          padding: EdgeInsets.only(left: 3.w),
          child: Text(item),
        ),
      );
}
