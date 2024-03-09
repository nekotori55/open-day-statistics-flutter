import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/dropdown_field.dart';

class ExpandableFloatingButton extends StatefulWidget {
  const ExpandableFloatingButton({
    super.key,
    required this.children
  });

  final List<Widget> children;

  @override
  State<ExpandableFloatingButton> createState() => _ExpandableFloatingButtonState();
}

class _ExpandableFloatingButtonState extends State<ExpandableFloatingButton> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: FittedBox(
        child: FloatingActionButton.extended(
          clipBehavior: Clip.none,
          extendedIconLabelSpacing: 0,
          splashColor: Colors.transparent,
          extendedPadding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              expanded = !expanded;
            });
          },
          label: Row(
            children: [
              AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  child: Row(
                    children: expanded
                        ? [
                            AnimatedOpacity(
                              opacity: expanded ? 1 : 0,
                              duration: const Duration(milliseconds: 500),
                              child: Row(
                                children: widget.children,
                              ),
                            ),
                          ]
                        : [Container()],
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(expanded ? Icons.close : Icons.person_add),
              ),
            ],
          ),
          // icon: Icon(Icons.close),
        ),
      ),
    );
  }
}
