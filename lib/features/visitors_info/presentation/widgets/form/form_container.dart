import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  const FormContainer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.centerRight,
      title: Text(
        "Анкета",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          letterSpacing: 3,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: child,
    );
  }
}
