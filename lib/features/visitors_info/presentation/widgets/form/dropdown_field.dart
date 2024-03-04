import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final List<String> items;
  final String label;

  const DropdownField({
    super.key,
    required this.items,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: items,
      clearButtonProps: ClearButtonProps(isVisible: true),
      popupProps: PopupProps.menu(
          showSearchBox: true,
          showSelectedItems: true,
          searchDelay: Duration.zero,
          emptyBuilder: (context, searchEntry) {
            return Center(
                child: Text(
                  searchEntry.isEmpty ? "Нет данных" : "По запросу ничего не найдено",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ));
          }),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
          overflow: TextOverflow.ellipsis,
        ),
        dropdownSearchDecoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
