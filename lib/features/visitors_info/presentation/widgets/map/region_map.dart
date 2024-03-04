import 'package:flutter/material.dart';

import 'svg_painter.dart';
import 'models.dart';
import 'utils.dart';

class RegionMap extends StatefulWidget {
  const RegionMap({super.key, required String mapSvg, required String centerId}) : _centerId = centerId, _mapSvg = mapSvg;

  final String _mapSvg;
  final String _centerId;


  @override
  State<RegionMap> createState() => _RegionMapState();
}

class _RegionMapState extends State<RegionMap>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _init();
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    Tween<double> _shift = Tween(begin: 0.0, end: 13.0);

    _animation = _shift.animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Size? _size;
  List<SubjectPath>? _pathsList;
  List<CapitalPoint>? _pointsList;
  List<CapitalName>? _namesList;
  late Offset _centerOffset;

  void _init() {
    final value = getVectorImageFromStringXml(widget._mapSvg);
    var centerPath =
        value.pathsList.firstWhere((element) => element.id == widget._centerId).path;
    var centerOffset = centerPath.getBounds().center;

    setState(() {
      _pathsList = value.pathsList;
      _pointsList = value.pointsList;
      _namesList = value.namesList;
      _size = value.size;
      _centerOffset = centerOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      scaleFactor: 1000,
      maxScale: 10,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double scale = constraints.maxWidth < constraints.maxHeight
              ? constraints.maxWidth / _size!.width
              : constraints.maxHeight / _size!.height;
          return Center(
            child: RepaintBoundary(
              child: SizedBox(
                width: _size!.width * scale,
                height: _size!.height * scale,
                child: Stack(
                  children: [
                    for (int index = 0; index < _pathsList!.length; index++)
                      CustomPaint(
                        painter: PathPainter(_pathsList![index], scale, 0.5),
                      ),
                    for (int index = 0; index < _pointsList!.length; index++)
                      CustomPaint(
                        painter: PointPainter(_pointsList![index], scale),
                      ),
                    for (int index = 0; index < _namesList!.length; index++)
                      CustomPaint(
                        painter: NamePainter(_namesList![index], scale, 8),
                      ),
                    for (int index = 0; index < _pathsList!.length; index++)
                      CustomPaint(
                        painter: LinePainter(_pathsList![index], scale,
                            _centerOffset, _animation.value),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
