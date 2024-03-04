import 'package:flutter/material.dart';
import 'form_container.dart';

class PopUpButton extends StatefulWidget {
  const PopUpButton({
    super.key,
  });

  @override
  State<PopUpButton> createState() => _PopUpButtonState();
}

class _PopUpButtonState extends State<PopUpButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        size: 30,
      ),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => FormContainer(),
        );
      },
    );
  }
}
