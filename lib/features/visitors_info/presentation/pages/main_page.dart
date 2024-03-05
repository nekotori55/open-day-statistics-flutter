import 'package:flutter/material.dart';

import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/Header/header.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/pop_up_button.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_sub_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/kl_city_svg.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/map.dart';
import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/map/svg/russia_svg.dart';

import 'package:open_day_statistics_flutter/features/visitors_info/presentation/widgets/form/form_container.dart';

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
            Map(mapSvg: RussiaSvg, centerId: "RU-KLU", fromPath: true),
            Map(mapSvg: KlSubSvg, centerId: "kl_kal", fromPath: true),
            Map(mapSvg: KlCitySvg, centerId: "0", fromPath: false),
          ],
        ),
        floatingActionButton: PopUpButton(
          form: FormContainer(
          ),
        ),
      ),
    );
  }
}
