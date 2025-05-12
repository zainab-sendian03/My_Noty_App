import 'package:firebase_test/core/functions/vailInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final int min;
  final int max;
  final bool visPassword;
  final bool showVisPasswordToggle;
  final void Function()? onTapIcon;
  final String? validationType;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.min,
    required this.max,
    this.visPassword = false,
    this.showVisPasswordToggle = false,
    this.onTapIcon,
    this.validationType,
    this.keyboardType,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _visPassword;
  late TextEditingController conf_pass;

  @override
  void initState() {
    super.initState();
    _visPassword = widget.visPassword;
    conf_pass = TextEditingController();
  }

  void _handleTapIcon() {
    if (widget.onTapIcon != null) {
      widget.onTapIcon!();
    }

    setState(() {
      _visPassword = !_visPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var iconSize = screenWidth * 0.05;
    var padding = screenWidth * 0.04;
    return TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: (valid) {
          return validInput(valid!, widget.max, widget.min,
              type: widget.validationType);
        },
        obscureText: _visPassword,
        decoration: InputDecoration(
            errorMaxLines: 2,
            suffixIcon: widget.showVisPasswordToggle
                ? IconButton(
                    icon: Icon(
                      _visPassword ? Icons.visibility_off : Icons.visibility,
                      color: Color.fromARGB(255, 235, 142, 2),
                      size: iconSize,
                    ),
                    onPressed: _handleTapIcon,
                  )
                : null,
            hintText: widget.hintText,
            contentPadding:
                EdgeInsets.symmetric(vertical: padding, horizontal: padding),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 235, 142, 2), width: 2.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )));
  }
}
