import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onToggleVisibility,
    this.onChanged,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    obscureText: obscureText,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: onToggleVisibility == null
          ? null
          : IconButton(
              onPressed: onToggleVisibility,
              tooltip: obscureText ? 'Mostrar senha' : 'Ocultar senha',
              icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
    ),
  );
}
