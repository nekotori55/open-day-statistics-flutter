import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';
import 'dropdown_field.dart';

class VisitorForm extends StatelessWidget {
  const VisitorForm({super.key, required this.controller});

  final VisitorsViewController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 330,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownField(
                getItems: (s) => controller.getAllRegions(),
                label: "Регион"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownField(
                getItems: (s) => controller.getAllDistricts(),
                label: "Район"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownField(
                getItems: (s) => controller.getAllSchools(),
                label: "Школа"),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55),
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
    );
  }
}
