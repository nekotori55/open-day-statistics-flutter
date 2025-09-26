import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/data/data_sources/local/visitor_statistics_local_datasource_impl.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller_impl.dart';
import 'package:window_manager/window_manager.dart';

import 'features/visitors_info/data/repositories/visitors_statistics_repository_impl.dart';
import 'features/visitors_info/presentation/manager/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ds = VisitorStatisticsLocalDatasourceImpl();
  final repository =
      VisitorStatisticsRepositoryImpl(useCache: true, datasource: ds);
  final VisitorsViewController controller =
      VisitorsViewControllerImpl(repository: repository);

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    // await windowManager.setFullScreen(true);
  });

  runApp(App(
    controller: controller,
  ));

  ds.closeConnection();
}
