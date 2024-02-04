import 'package:flutter/material.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  ConfirmPasswordTextField({
    super.key,
    required this.confirmPasswordController,
    required this.onChanged,
  });

  final TextEditingController confirmPasswordController;
  final void Function(String p1) onChanged;

  @override
  State<ConfirmPasswordTextField> createState() => _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.confirmPasswordController,
      decoration: InputDecoration(
        labelText: 'Confirm password',
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(
              () {
                _obscureText = !_obscureText;
              },
            );
          },
        ),
      ),
      obscureText: _obscureText,
      onChanged: widget.onChanged,
    );
  }
}
