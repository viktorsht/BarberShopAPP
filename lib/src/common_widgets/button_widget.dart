import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String message;
  final Color messageColor;
  final Color buttonColor;
  final VoidCallback onPressed;
  final Color? borderColor;
  const ButtonWidget({super.key, required this.message, required this.buttonColor, required this.messageColor, required this.onPressed, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: buttonColor,
          border: borderColor == null ? Border.all(color: buttonColor) : Border.all(color: borderColor!),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              color: messageColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}