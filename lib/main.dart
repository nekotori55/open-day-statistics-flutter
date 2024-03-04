import 'package:flutter/material.dart';

import 'features/visitors_info/data/repositories/visitors_statistics_repository_impl.dart';
import 'features/visitors_info/presentation/manager/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var repository = VisitorStatisticsRepositoryImpl();

  runApp(App(
    repository: repository,
  ));
}


