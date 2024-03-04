import 'package:flutter/material.dart';

import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/Header/header.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/pop_up_button.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const Header(),
        body: TabBarView(
          children: [
            Center(child: Icon(Icons.equalizer)),
            Center(child: Icon(Icons.equalizer)),
            Center(child: Icon(Icons.equalizer)),
          ],
        ),
        floatingActionButton: PopUpButton(),
      ),
    );
  }
}
