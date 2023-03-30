import 'package:flutter/material.dart';

class InputCustom extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final Function(String)? onChange;
  final bool isPassword;
  final String? Function(String?)? validate;
  final TextInputType? textInputType;
  final bool isEnable;
  final Widget? icon;
  const InputCustom({
    Key? key,
    required this.controller,
    this.hint,
    this.isPassword = false,
    this.isEnable = true,
    this.onChange,
    this.textInputType,
    this.validate,
    this.icon,
  }) : super(key: key);

  factory InputCustom.base({
    required controller,
    bool isPassword = false,
    bool isEnable = true,
    String? hint,
    Function(String)? onChange,
    String? Function(String?)? validate,
    TextInputType? textInputType,
    Widget? icon,
  }) =>
      InputCustom(
        validate: validate,
        controller: controller,
        isPassword: isPassword,
        hint: hint,
        onChange: onChange,
        textInputType: textInputType,
        isEnable: isEnable,
        icon: icon,
      );

  @override
  State<InputCustom> createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  late bool isValid;
  bool eyeOpen = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: widget.validate != null
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword && !eyeOpen ? true : false,
        autofocus: false,
        onChanged: widget.onChange,
        keyboardType: widget.textInputType,
        validator: widget.validate,
        enabled: widget.isEnable,
        decoration: InputDecoration(
          fillColor: const Color(0xFF6750A4).withOpacity(0.3),
          filled: true,
          hintStyle:
              const TextStyle().copyWith(color: Colors.black.withOpacity(0.3)),
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    eyeOpen = !eyeOpen;
                    setState(() {});
                  },
                  child: Icon(
                      eyeOpen
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye_rounded,
                      color: Colors.black.withOpacity(0.5)),
                )
              : widget.icon,
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFF6750A4),
              width: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
