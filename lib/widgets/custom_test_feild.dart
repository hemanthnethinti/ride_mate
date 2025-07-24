import 'package:flutter/material.dart';

class CustomTextFeild extends StatefulWidget {

  final String hinttext;
  final IconData pIcon;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validate;

  const CustomTextFeild({
    super.key,
    required this.hinttext,
    required this.pIcon,
    required this.controller,
    this.isPassword = false,
    this.validate,
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
          hintText: widget.hinttext,
          prefixIcon: Icon(widget.pIcon),
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
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
  }
}
