import 'package:flutter/material.dart';

class MapPath {
  const MapPath({
    required this.path,
    required this.fill,
    required this.id,
    required this.isDisplay,
  });

  final Path path;
  final Color fill;
  final String id;
  final bool isDisplay;
}

class MapPoint {
  const MapPoint({
    required this.offset,
    required this.radius,
    required this.id,
  });

  final Offset offset;
  final double radius;
  final String id;
}

class MapString {
  const MapString({
    required this.offset,
    required this.name,
    required this.id,
  });

  final Offset offset;
  final String name;
  final String id;
}


class VectorImage {
  const VectorImage({
    required this.pathsList,
    required this.pointsList,
    required this.namesList,
    required this.size,
  });

  final List<MapPath> pathsList;
  final List<MapPoint> pointsList;
  final List<MapString> namesList;
  final Size size;
}


