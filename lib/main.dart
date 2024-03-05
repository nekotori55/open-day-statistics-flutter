import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/data_sources/local/visitor_statistics_local_datasource_impl.dart';

import 'features/visitors_info/data/repositories/visitors_statistics_repository_impl.dart';
import 'features/visitors_info/presentation/manager/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = VisitorStatisticsRepositoryImpl(useCache: true, datasource: VisitorStatisticsLocalDatasourceImpl());

  runApp(App(
    repository: repository,
  ));
}


