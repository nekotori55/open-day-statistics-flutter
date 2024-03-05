import 'package:flutter/material.dart';

import 'svg_painter.dart';
import 'models.dart';
import 'utils.dart';

class StatisticsMap extends StatefulWidget {
  const StatisticsMap({super.key, required this.mapSvg, required this.centerId, required this.fromPath, required this.getIdMap});

  final String mapSvg;
  final String centerId;
  final bool fromPath;

  final Future<Map<String, int>> Function() getIdMap;

  @override
  State<StatisticsMap> createState() => _StatisticsMapState();
}

class _StatisticsMapState extends State<StatisticsMap> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  Map<String, int> idmap = {};

  @override
  Future<void> initState() async {
    _init();
    
    idmap = await widget.getIdMap();

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

  late Size _size;
  late List<MapPath> _pathsList;
  late List<MapPoint> _pointsList;
  late List<MapString> _namesList;
  late Offset _centerOffset;

  void _init() {
    final value = getVectorImage(widget.mapSvg);
    Offset centerOffset;
    if (widget.fromPath) {
      var centerPath = value.pathsList
          .firstWhere((element) => element.id == widget.centerId)
          .path;
      centerOffset = centerPath
          .getBounds()
          .center;
    }
    else {
      centerOffset = value.pointsList.firstWhere((element) => element.id == widget.centerId).offset;
    }

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
              ? constraints.maxWidth / _size.width
              : constraints.maxHeight / _size.height;
          return Center(
            child: RepaintBoundary(
              child: SizedBox(
                width: _size.width * scale,
                height: _size.height * scale,
                child: Stack(
                  children: [
                    CustomPaint(painter: PathPainter(_pathsList, scale, 0.5)),
                    CustomPaint(painter: NamePainter(_namesList, scale, 8)),
                    Builder(
                        builder: (context) {
                          if (widget.fromPath) {
                              return Stack(
                                children: [
                                  CustomPaint(painter: PointPainter(_pointsList, scale)),
                                  CustomPaint(painter:
                                  LinePainter(
                                    startPathsList: _pathsList,
                                    scale: scale,
                                    endPos: _centerOffset,
                                    shift: _animation.value,
                                  )
                                  ),
                                  CustomPaint(painter: AmountPainter(_pathsList, scale, 100))
                                ],
                              );
                            }
                          else {
                            return Stack(
                              children: [
                                CustomPaint(painter:
                                LinePainter(
                                  startPointsList: _pointsList,
                                  scale: scale,
                                  endPos: _centerOffset,
                                  shift: _animation.value,
                                )
                                ),
                                CustomPaint(painter: PointPainter(_pointsList, scale)),
                              ],
                            );
                          }
                        }
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
