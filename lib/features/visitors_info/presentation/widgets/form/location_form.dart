import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../view/base_view_model.dart';
import 'dropdown_field.dart';

class MyLittleFormy extends StatefulWidget {
  const MyLittleFormy({
    super.key,
    required this.getItems,
    required this.label,
    required this.onSend,
  });

  final Future<List<ViewModel>> Function(String?) getItems;
  final String label;
  final Function(ViewModel?) onSend;

  @override
  State<MyLittleFormy> createState() => _MyLittleFormyState();
}

class _MyLittleFormyState extends State<MyLittleFormy> {

  static final GlobalKey<DropdownSearchState> dropdownFieldGlobalKey = GlobalKey();

  ViewModel? _selected;

  bool singleMode = true;


  @override
  Widget build(BuildContext context) {
    dropdownFieldGlobalKey.currentState?.clear();
    return Row(
      children: [
        const SizedBox(
          width: 8,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250),
          child: DropdownField(
            fieldGlobalKey: dropdownFieldGlobalKey,
            getItems: widget.getItems,
            label: widget.label,
            onChanged: (model) => _selected = model,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSend(_selected);

            if (singleMode) {
              dropdownFieldGlobalKey.currentState?.clear();
            }
          },

          onLongPress: () {
            setState(() {
              singleMode = !singleMode;
            });
          },

          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          child: singleMode ? const Icon(Icons.person_add) : const Icon(Icons.people),
        ),
      ],
    );
  }
}
