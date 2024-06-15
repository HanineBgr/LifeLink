import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final IconData? icon;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.icon,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color fillColor = isDarkMode ? Colors.grey[800]! :Color.fromARGB(255, 242, 249, 255);

    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color iconColor = Color.fromARGB(218, 91, 169, 233);

    return TextFormField(
      obscureText: widget.icon == Icons.password ? !_isPasswordVisible : false,
      keyboardType: widget.icon == Icons.email ? TextInputType.emailAddress : TextInputType.text,
      controller: widget.controller,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: widget.icon != null ? Icon(widget.icon, color: iconColor) : null,
        suffixIcon: widget.icon == Icons.password
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: iconColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: iconColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: iconColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color.fromARGB(255, 107, 190, 150)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        labelText: widget.label,
        labelStyle: TextStyle(color: Colors.grey),
        errorStyle: TextStyle(color: Colors.red),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
