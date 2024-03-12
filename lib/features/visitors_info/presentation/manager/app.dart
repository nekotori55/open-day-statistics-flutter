import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/pages/main_page.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';

class App extends StatelessWidget {
  const App({super.key, required this.controller});

  final VisitorsViewController controller;

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF176DEA));
    var theme = ThemeData(
      colorScheme: colorScheme,
      dataTableTheme: DataTableThemeData(
        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        headingRowColor: MaterialStateColor.resolveWith((states) => colorScheme.primaryContainer),
      ),
      fontFamily: 'Gilroy',
      useMaterial3: true,
    );

    // theme.

    return MaterialApp(
      title: 'Open day statistics',
      theme: theme,
      home: MainPage(controller: controller),
    );
  }
}
