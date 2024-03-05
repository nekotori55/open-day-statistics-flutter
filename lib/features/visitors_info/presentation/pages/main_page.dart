import 'package:flutter/material.dart';

import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/Header/header.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/pop_up_button.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/visitor_form.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_sub_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_city_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/russia_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/statistics_map.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/form_container.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/chart/statistics_chart.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.controller});

  final VisitorsViewController controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const Header(),
        body: TabBarView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatisticsMap(
                  mapSvg: RussiaSvg,
                  centerId: "RU-KLU",
                  fromPath: true,
                  getIdMap: () async {
                    var result = await controller.getRegionStatistics();
                    return result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.id, value));
                  },
                ),
                StatisticsChart(dataMap: {
                  "Flutter": 5,
                  "React": 3,
                  "Xamarin": 2,
                  "Ionic": 2,
                  "Абоба": 10,
                  "Боба": 10,
                  "Оба": 10,
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatisticsMap(
                  mapSvg: KlSubSvg,
                  centerId: "kl_kal",
                  fromPath: true,
                  getIdMap: () async {
                    var result = await controller.getDistrictStatistics();
                    return result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.id, value));
                  },
                ),
                StatisticsChart(dataMap: {
                  "Flutter": 5,
                  "React": 3,
                  "Xamarin": 2,
                  "Ionic": 2,
                  "Абоба": 10,
                  "Боба": 10,
                  "Оба": 10,
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatisticsMap(
                  mapSvg: KlCitySvg,
                  centerId: "0",
                  fromPath: false,
                  getIdMap: () async {
                    var result = await controller.getSchoolStatistics();
                    return result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.id, value));
                  },
                ),
                StatisticsChart(dataMap: {
                  "Flutter": 5,
                  "React": 3,
                  "Xamarin": 2,
                  "Ionic": 2,
                  "Абоба": 10,
                  "Боба": 10,
                  "Оба": 10,
                }),
              ],
            ),
          ],
        ),
        floatingActionButton: PopUpButton(
          form: FormContainer(
            child: VisitorForm(controller: controller),
          ),
        ),
      ),
    );
  }
}
