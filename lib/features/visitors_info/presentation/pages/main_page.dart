import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/district_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/region_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/school_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitor_view_model.dart';

import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/Header/header.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_sub_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_city_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/russia_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/statistics_map.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/chart/statistics_chart.dart';

import '../widgets/form/expandable_floating_button.dart';
import '../widgets/form/location_form.dart';

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
      floatingActionButton: ExpandableFloatingButton(
          child: MyLittleFormy(
            label: labels[currentTab],
            getItems: (_) {
              switch (currentTab) {
                case 0:
                  return widget.controller.getAllRegions();
                case 1:
                  return widget.controller.getAllDistricts();
                case 2:
                  return widget.controller.getAllSchools();
                default:
                  throw ArgumentError();
              }
            },
            onSend: (model) async {
              late VisitorViewModel visitor;

              final defaultRegion = RegionViewModel(id: "RU-KLU", name: "");
              final defaultDistrict = DistrictViewModel(id: "kl_kal", name: "");

              if (model == null) return;

              switch (model) {
                case RegionViewModel():
                  visitor = VisitorViewModel(
                      district: null, region: model, school: null);
                case DistrictViewModel():
                  visitor = VisitorViewModel(
                      district: model, region: defaultRegion, school: null);
                case SchoolViewModel():
                  visitor = VisitorViewModel(district: defaultDistrict,
                      region: defaultRegion,
                      school: model);
              }
              await widget.controller.addVisitor(visitor);
            }
          )),
    );
  }
}
