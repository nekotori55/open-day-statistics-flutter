import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/base_view_model.dart';

class DropdownField<Model extends ViewModel> extends StatefulWidget {
  final String label;

  final Future<List<Model>> Function(String? s) getItems;
  final Function(Model? model)? onChanged;
  final bool enabled;
  final GlobalKey<DropdownSearchState> fieldGlobalKey;

  const DropdownField({
    super.key,
    required this.getItems,
    required this.label,
    this.onChanged,
    this.enabled = true,
    required this.fieldGlobalKey,
  });

  @override
  State<DropdownField<Model>> createState() => _DropdownFieldState<Model>();
}

class _DropdownFieldState<Model extends ViewModel>
    extends State<DropdownField<Model>> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationValue;

  final _userEditTextController = TextEditingController();
  static const _animationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    _animationValue = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Model>(
      key: widget.fieldGlobalKey,
      asyncItems: widget.getItems,
      enabled: widget.enabled,
      itemAsString: (item) => item.toStringByName(),
      onChanged: widget.onChanged,
      compareFn: (item1, item2) =>
          item1.toStringByName() == item2.toStringByName(),
      popupProps: PopupProps.menu(
          itemBuilder: (context, item, isSelected) => Container(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  child: Text(item.toStringByName()),
                ),
              ),
          searchFieldProps: TextFieldProps(
            controller: _userEditTextController,
            decoration: InputDecoration(
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _userEditTextController,
                builder: (context, v, c) => IconButton(
                  icon: const Icon(Icons.clear),
                  enableFeedback: false,
                  onPressed: _userEditTextController.value.text.isNotEmpty
                      ? () => _userEditTextController.clear()
                      : null,
                ),
              ),
            ),
          ),
          menuProps: MenuProps(
            positionCallback: (popupButtonObject, overlay) {

              var blm = popupButtonObject.size.topLeft(Offset(0, -popupButtonObject.size.height * 7));
              var brm = popupButtonObject.size.topRight(Offset(0, -popupButtonObject.size.height * 7));

              var rect = RelativeRect.fromSize(
                  Rect.fromPoints(
                    popupButtonObject.localToGlobal(blm, ancestor: overlay),
                    popupButtonObject.localToGlobal(brm, ancestor: overlay),
                  ),
                  Size(overlay.size.width, overlay.size.height),
                );

              // rect = rect.shift(Offset(0, rect.bottom - rect.top));

              return rect;
            },
            borderRadius: BorderRadius.circular(20),
            // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            backgroundColor: Colors.transparent,

            shadowColor: Colors.transparent,
            barrierDismissible: true,
          ),
          showSearchBox: true,
          showSelectedItems: true,
          searchDelay: const Duration(milliseconds: 100),
          onDismissed: () {
            _animationController.reverse();
          },
          containerBuilder: (context, child) => FadeTransition(
                opacity: _animationValue,
                child: Material(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shadowColor: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(20),
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
        textAlignVertical: TextAlignVertical.top,
        baseStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: null,
            overflow: TextOverflow.ellipsis),
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // contentPadding: EdgeInsets.all(8),
          isDense: true,
          labelText: widget.label,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              height: 0.4),
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
