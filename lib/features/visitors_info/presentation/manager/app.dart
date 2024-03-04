import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:open_day_statistics_flutter/features/visitors_info/domain/repositories/visitor_statistics_repository.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/pages/main_page.dart';


class App extends StatelessWidget {
  const App({super.key, required this.repository});

  final VisitorStatisticsRepository repository;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open day statistics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176DEA)
        ),
        fontFamily: 'Gilroy',
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}
