import 'package:flutter/material.dart';

class ExpandableFloatingButton extends StatefulWidget {
  const ExpandableFloatingButton({super.key, required this.child});

  final Widget? child;

  @override
  State<ExpandableFloatingButton> createState() =>
      _ExpandableFloatingButtonState();
}

class _ExpandableFloatingButtonState extends State<ExpandableFloatingButton>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: FittedBox(
        fit: BoxFit.fill,
        child: FloatingActionButton.extended(
          clipBehavior: Clip.none,
          extendedIconLabelSpacing: 0,
          splashColor: !expanded ? Colors.transparent : null,
          hoverColor: Colors.transparent,
          extendedPadding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              expanded = !expanded;
              if (expanded) {
                controller.forward();
              } else {
                controller.reverse();
              }
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
                              child: widget.child,
                            ),
                          ]
                        : [Container()],
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                // child: Icon(expanded ? Icons.close : Icons.person_add),
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animation,
                  // size: 4.0,
                ),
              ),
            ],
          ),
          // icon: Icon(Icons.close),
        ),
      ),
    );
  }
}
