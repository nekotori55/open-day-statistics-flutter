import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/district_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/region_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/school_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitor_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';
import 'dropdown_field.dart';

class VisitorForm extends StatefulWidget {
  const VisitorForm({super.key, required this.controller});

  final VisitorsViewController controller;

  @override
  State<VisitorForm> createState() => _VisitorFormState();
}

class _VisitorFormState extends State<VisitorForm> {
  RegionViewModel? selectedRegion;
  DistrictViewModel? selectedDistrict;
  SchoolViewModel? selectedSchool;

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
              getItems: (s) => widget.controller.getAllRegions(),
              label: "Регион",
              onChanged: (model) => setState(() {
                selectedRegion = model;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownField(
              getItems: (s) => widget.controller.getAllDistricts(),
              label: "Район",
              enabled: selectedRegion?.id == "RU-KLU",
              onChanged: (model) => setState(() {
                selectedDistrict = model;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownField(
              getItems: (s) => widget.controller.getAllSchools(),
              label: "Школа",
              enabled: selectedDistrict?.id == "kl_kal",
              onChanged: (model) => setState(() {
                selectedSchool = model;
              }),
            ),
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
              onPressed: (selectedRegion != null) &&
                      (selectedDistrict != null ||
                          selectedRegion?.id != "RU-KLU") &&
                      (selectedSchool != null ||
                          selectedDistrict?.id != "kl_kal")
                  ? () {
                      widget.controller.addVisitor(VisitorViewModel(
                          district: selectedDistrict,
                          region: selectedRegion!,
                          school: selectedSchool));
                    }
                  : null,
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
