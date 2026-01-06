import 'package:flutter/material.dart';

class TextInputLoginField extends StatefulWidget {
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final double? borderRadius;
  const TextInputLoginField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.decoration,
    this.validator,
    this.borderRadius,
  });

  @override
  State<TextInputLoginField> createState() => _TextInputLoginFieldState();
}

class _TextInputLoginFieldState extends State<TextInputLoginField> {
  late bool _hidden;

  @override
  void initState() {
    super.initState();
    _hidden = widget.isPassword;
  }

  void _togglePasswordVisibility() async {
    setState(() {
      _hidden = !_hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder buildBorder(
        {double width = 1.0, Color color = Colors.grey}) {
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
          borderSide: BorderSide(color: color, width: width));
    }

    return TextFormField(
        obscureText: _hidden,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.validator,
        autovalidateMode: AutovalidateMode.onUnfocus,
        decoration: (widget.decoration ?? const InputDecoration()).copyWith(
            contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            enabledBorder:
                buildBorder(color: const Color(0xFF195658), width: 1.0),
            focusedBorder:
                buildBorder(color: const Color(0xFF195658), width: 1.0),
            errorBorder: buildBorder(color: Colors.redAccent, width: 1.0),
            focusedErrorBorder:
                buildBorder(color: Colors.redAccent, width: 1.0),
            disabledBorder:
                buildBorder(color: const Color(0xFFD9D9D9), width: 1.0),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _hidden ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null));
  }
}
