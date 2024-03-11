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

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.controller});

  final VisitorsViewController controller;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var currentTab = 0;

  var labels = ["Регион", "Район", "Школа"];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);

    widget.controller.addErrorListener((msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg!), backgroundColor: Theme.of(context).colorScheme.error),
      );
    });

    onTabChangeListener() {
      setState(() {
        currentTab = _tabController.index;
      });
    }

    _tabController.addListener(onTabChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: Header(tabController: _tabController),
        body: TabBarView(
          controller: _tabController,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatisticsMap(
                  mapSvg: RussiaSvg,
                  centerId: "RU-KLU",
                  fromPath: true,
                  getIdMap: () async {
                    var result = await widget.controller.getRegionStatistics();
                    return result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.id, value));
                  },
                ),
                StatisticsChart(
                  getIdMap: () async {
                    var result = await widget.controller.getRegionStatistics();
                    return (result.total, result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.name, value)));
                  },
                ),
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
                    var result = await widget.controller.getDistrictStatistics();
                    return result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.id, value));
                  },
                ),
                StatisticsChart(
                  getIdMap: () async {
                    var result = await widget.controller.getDistrictStatistics();
                    return (result.total, result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.name, value)));
                  },
                ),
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
                    var result = await widget.controller.getSchoolStatistics();
                    return result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.id, value));
                  },
                ),
                StatisticsChart(
                  getIdMap: () async {
                    var result = await widget.controller.getSchoolStatistics();
                    return (result.total, result.subjectToVisitorNumber
                        .map((key, value) => MapEntry(key.name, value)));
                  },
                ),
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
