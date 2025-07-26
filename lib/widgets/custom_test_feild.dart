import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {

  
  final Widget? pIcon;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validate;
  final String? label;

  const CustomTextFeild({
    super.key,
    this.pIcon,
    required this.controller,
    this.isPassword = false,
    this.validate,
    required this.label,
  });

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        validator:widget.validate ,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.pIcon,
          suffixIcon: Visibility(
            visible: widget.isPassword,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
  }
}
