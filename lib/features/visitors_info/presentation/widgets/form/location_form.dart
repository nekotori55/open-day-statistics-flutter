import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../view/base_view_model.dart';
import 'dropdown_field.dart';

class FormController {
  void Function() clearForm = () {};
}

class FloatingActionButtonForm extends StatefulWidget {
  const FloatingActionButtonForm({
    super.key,
    required this.getItems,
    required this.label,
    required this.onSend,
    required this.formController,
  });

  final Future<List<ViewModel>> Function(String?) getItems;
  final String label;
  final Function(ViewModel?) onSend;
  final FormController formController;

  @override
  State<FloatingActionButtonForm> createState() => _FloatingActionButtonFormState(formController);
}

class _FloatingActionButtonFormState extends State<FloatingActionButtonForm> {
  _FloatingActionButtonFormState(FormController controller) {
    controller.clearForm = clearForm;
  }

  static final GlobalKey<DropdownSearchState> dropdownFieldGlobalKey =
      GlobalKey();

  ViewModel? _selected;

  bool singleMode = true;

  void clearForm() {
    dropdownFieldGlobalKey.currentState?.clear();
  }

  @override
  Widget build(BuildContext context) {
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
              clearForm();
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
          child: singleMode
              ? const Icon(Icons.person_add)
              : const Icon(Icons.people),
        ),
      ],
    );
  }
}
