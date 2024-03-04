import 'package:flutter/material.dart';
import 'dropdown_field.dart';
class VisitorForm extends StatelessWidget {
  const VisitorForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 330,
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownField(items: [], label: "Регион"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownField(items: [], label: "Район"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownField(items: [], label: "Школа"),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(55),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.background,
                ),
                onPressed: () {},
                child: Text(
                  "Отправить",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}