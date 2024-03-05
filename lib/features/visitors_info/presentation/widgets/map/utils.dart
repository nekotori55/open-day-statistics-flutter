import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';
import 'models.dart';

VectorImage getVectorImage(String svgData) {
  List<MapPath> pathsList = [];
  List<MapPoint> pointsList = [];
  List<MapString> stringsList = [];

  XmlDocument document = XmlDocument.parse(svgData);

  Size size;
  String? width = document.findAllElements('svg').first.getAttribute('width');
  String? height = document.findAllElements('svg').first.getAttribute('height');
  String? viewBox =
      document.findAllElements('svg').first.getAttribute('viewBox');

  if (width != null && height != null) {
    width = width.replaceAll(RegExp(r'[^0-9.]'), '');
    height = height.replaceAll(RegExp(r'[^0-9.]'), '');
    size = Size(double.parse(width), double.parse(height));
  } else if (viewBox != null) {
    List<String> viewBoxList = viewBox.split(' ');
    size = Size(double.parse(viewBoxList[2]), double.parse(viewBoxList[3]));
  } else {
    throw ArgumentError("No size?");
  }

// Paths
  final List<XmlElement> paths = document.findAllElements('path').toList();
  for (int i = 0; i < paths.length; i++) {
    final XmlElement element = paths[i];

    MapPath? path = _getMapPath(element);

    if (path != null) {
      pathsList.add(path);
    }
  }

//Points
  final List<XmlElement> points = document.findAllElements('circle').toList();
  for (int i = 0; i < points.length; i++) {
    final XmlElement element = points[i];

    MapPoint? point = _getMapPoint(element);

    if (point != null) {
      pointsList.add(point);
    }
  }

//Name
  final List<XmlElement> names = document.findAllElements('text').toList();
  for (int i = 0; i < names.length; i++) {
    final XmlElement element = names[i];

    MapString? name = _getMapString(element);

    if (name != null) {
      stringsList.add(name);
    }
  }

  return VectorImage(
      pathsList: pathsList,
      pointsList: pointsList,
      namesList: stringsList,
      size: size);
}

MapPath? _getMapPath(XmlElement element) {
  // get the path
  String? pathString = element.getAttribute('d');
  if (pathString == null) {
    return null;
  }
  Path path = parseSvgPathData(pathString);

  // get the fill color
  String? fill = element.getAttribute('fill');
  String? style = element.getAttribute('style');
  if (style != null) {
    fill = _getFillColor(style);
  }

  Color color;
  if (fill == null) {
    color = Colors.transparent;
  } else {
    color = Color(int.parse(fill.replaceAll("#", "0xFF")));
  }

  // get the id
  String? id = element.getAttribute('id');
  if (id == null) {
    return null;
  }

  return MapPath(
    fill: color,
    path: path,
    id: id,
  );
}

MapPoint? _getMapPoint(XmlElement element) {
  String? x = element.getAttribute('cx');
  String? y = element.getAttribute('cy');
  String? r = element.getAttribute('r');

  if (x == null || y == null || r == null) {
    return null;
  }

  Offset offset = Offset(double.parse(x), double.parse(y));
  double radius = double.parse(r);

  String? id = element.getAttribute('id');
  if (id == null) {
    return null;
  }

  return MapPoint(offset: offset, radius: radius, id: id);
}

MapString? _getMapString(XmlElement element) {
  String? x = element.getAttribute('x');
  String? y = element.getAttribute('y');
  String? transform = element.getAttribute('transform');
  XmlElement? tspanName = element.getElement('tspan');
  double scaleX = 1.0;
  double scaleY = 1.0;

  if (x == null || y == null || tspanName == null) {
    return null;
  }

  String name = tspanName.innerText;

  if (transform != null) {
    RegExp regExp = RegExp(r'scale\(([^,]+),([^)]+)\)');
    var match = regExp.firstMatch(transform);

    if (match != null) {
      scaleX = double.parse(match.group(1)!);
      scaleY = double.parse(match.group(2)!);
    }
  }

  Offset offset = Offset(double.parse(x) * scaleX, double.parse(y) * scaleY);

  String? id = element.getAttribute('id');
  if (id == null) {
    return null;
  }

  return MapString(
    offset: offset,
    name: name,
    id: id,
  );
}

String? _getFillColor(String data) {
  RegExp regExp = RegExp(r'fill:\s*(#[a-fA-F0-9]{6})');
  RegExpMatch? match = regExp.firstMatch(data);

  return match?.group(1);
}
