import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(text: "Карта России"),
        Tab(text: "Карта Области"),
        Tab(text: "Карта Калуги"),
      ],
      labelStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
