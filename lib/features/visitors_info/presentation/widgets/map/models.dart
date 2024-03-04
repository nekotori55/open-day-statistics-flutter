import 'package:flutter/material.dart';

class SubjectPath {
  const SubjectPath({
    required this.path,
    required this.fill,
    required this.id,
  });

  final Path path;
  final Color fill;
  final String id;
}

class CapitalPoint {
  const CapitalPoint({
    required this.offset,
    required this.radius,
  });

  final Offset offset;
  final double radius;
}

class CapitalName {
  const CapitalName({
    required this.offset,
    required this.name,
  });

  final Offset offset;
  final String name;
}

class VectorImage {
  const VectorImage({
    required this.pathsList,
    required this.pointsList,
    required this.namesList,
    this.size,
  });

  final List<SubjectPath> pathsList;
  final List<CapitalPoint> pointsList;
  final List<CapitalName> namesList;
  final Size? size;
}


