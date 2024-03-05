import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatefulWidget {
  final List<String> items;
  final String label;

  const DropdownField({
    super.key,
    required this.items,
    required this.label,
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationValue;

  final _userEditTextController = TextEditingController();
  static const _animationDuration = Duration(milliseconds: 100);

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _animationValue = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: widget.items,

      popupProps: PopupProps.menu(
          searchFieldProps: TextFieldProps(
            controller: _userEditTextController,
            decoration: InputDecoration(
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _userEditTextController,
                builder: (context, v, c) => IconButton(
                  icon: const Icon(Icons.clear),
                  enableFeedback: false,
                  // color: Theme.of(context).disabledColor,
                  onPressed: _userEditTextController.value.text.isNotEmpty
                      ? () => _userEditTextController.clear()
                      : null,
                ),
              ),
            ),
          ),
          menuProps: MenuProps(
            animation: _animationController,
            animationDuration: _animationDuration,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          showSearchBox: true,
          showSelectedItems: true,
          searchDelay: Duration.zero,
          onDismissed: () => _animationController.reverse(),
          containerBuilder: (context, child) => FadeTransition(
                opacity: _animationValue,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20)),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: child,
                ),
              ),
          emptyBuilder: (context, searchEntry) => Center(
              child: Text(
                  searchEntry.isEmpty
                      ? "Нет данных"
                      : "По запросу ничего не найдено",
                  style: const TextStyle(fontSize: 18, color: Colors.grey)))),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.5,
            overflow: TextOverflow.ellipsis),
        dropdownSearchDecoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
          ),
        ),
      ),

      onBeforePopupOpening: (_) {
        return Future(() {
          _animationController.forward();
          return true;
        });
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _userEditTextController.dispose();
    super.dispose();
  }
}
