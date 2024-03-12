import 'package:flutter/material.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/statistics-charts/statistics_charts.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/district_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/region_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/school_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitor_view_model.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/view/visitors_view_controller.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/Header/header.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/expandable_floating_button.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/location_form.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/leaders-table/leaders-table.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/statistics_map.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_city_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_sub_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/russia_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/pie-chart/visitors_pie_chart.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key, required this.controller});

  final VisitorsViewController controller;
  final FormController formController = FormController();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var currentTab = 0;

  var labels = ["Регион", "Район", "Школа"];

  late (Map<String, int>, {int total}) regionData;
  late (Map<String, int>, {int total}) districtData;
  late (Map<String, int>, {int total}) schoolData;

  void getData() async {
    widget.controller.getRegionStatistics().then((value) {
      setState(() {
        regionData = (
          value.subjectToVisitorNumber
              .map((key, value) => MapEntry(key.name, value)),
          total: value.total
        );
      });
    });
    widget.controller.getDistrictStatistics().then((value) {
      setState(() {
        districtData = (
          value.subjectToVisitorNumber
              .map((key, value) => MapEntry(key.name, value)),
          total: value.total
        );
      });
    });
    widget.controller.getSchoolStatistics().then((value) {
      setState(() {
        schoolData = (
          value.subjectToVisitorNumber
              .map((key, value) => MapEntry(key.name, value)),
          total: value.total
        );
      });
    });
  }

  @override
  void initState() {
    getData();
    _tabController = TabController(vsync: this, length: 3);

    widget.controller.addErrorListener((msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(msg!),
            backgroundColor: Theme.of(context).colorScheme.error),
      );
    });

    onTabChangeListener() {
      widget.formController.clearForm();
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
          ClipRect(
            child: Stack(
              children: [
                InteractiveViewer(
                  scaleFactor: 1000,
                  maxScale: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StatisticsMap(
                          mapSvg: RussiaSvg,
                          centerId: "RU-KLU",
                          fromPath: true,
                          getIdMap: () async {
                            var result =
                                await widget.controller.getRegionStatistics();
                            return result.subjectToVisitorNumber
                                .map((key, value) => MapEntry(key.id, value));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: StatisticsCharts(data: regionData, label: labels[0],)
                ),
              ],
            ),
          ),
          ClipRect(
            child: Stack(
              children: [
                InteractiveViewer(
                  scaleFactor: 1000,
                  maxScale: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StatisticsMap(
                          mapSvg: KlSubSvg,
                          centerId: "kl_kal",
                          fromPath: true,
                          getIdMap: () async {
                            var result =
                                await widget.controller.getDistrictStatistics();
                            return result.subjectToVisitorNumber
                                .map((key, value) => MapEntry(key.id, value));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: StatisticsCharts(data: districtData, label: labels[1]),
                ),
              ],
            ),
          ),
          ClipRect(
            child: Stack(
              children: [
                InteractiveViewer(
                  scaleFactor: 1000,
                  maxScale: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StatisticsMap(
                          mapSvg: KlCitySvg,
                          centerId: "0",
                          fromPath: false,
                          getIdMap: () async {
                            var result =
                                await widget.controller.getSchoolStatistics();
                            return result.subjectToVisitorNumber
                                .map((key, value) => MapEntry(key.id, value));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: StatisticsCharts(data: schoolData, label: labels[2],)
                )
              ],
            ),
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
              formController: widget.formController,
              onSend: (model) async {
                late VisitorViewModel visitor;

                final defaultRegion = RegionViewModel(id: "RU-KLU", name: "");
                final defaultDistrict =
                    DistrictViewModel(id: "kl_kal", name: "");

                if (model == null) return;

                switch (model) {
                  case RegionViewModel():
                    if (model.id == defaultRegion.id) {
                      _tabController.animateTo(1);
                      return;
                    }
                    visitor = VisitorViewModel(
                        district: null, region: model, school: null);
                  case DistrictViewModel():
                    if (model.id == defaultDistrict.id) {
                      _tabController.animateTo(2);
                      return;
                    }
                    visitor = VisitorViewModel(
                        district: model, region: defaultRegion, school: null);
                  case SchoolViewModel():
                    visitor = VisitorViewModel(
                        district: defaultDistrict,
                        region: defaultRegion,
                        school: model);
                }
                await widget.controller.addVisitor(visitor);
                getData();
                setState(() {});
              })),
    );
  }
}
