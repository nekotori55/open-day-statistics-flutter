import 'package:flutter/material.dart';
import 'titles.dart';
import 'nav_bar.dart';


class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 110,
      leadingWidth: 90,
      titleSpacing: 0,
      leading: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Image(
          image: AssetImage("assets/logo.png"),
        ),
      ),
      title: const Titles(),
      bottom: NavBar(
        controller: tabController,
      ),
    );
  }

  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
