import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';
import 'models.dart';

VectorImage getVectorImageFromStringXml(String svgData) {
  List<SubjectPath> pathsList = [];
  List<CapitalPoint> pointsList = [];
  List<CapitalName> namesList = [];

  XmlDocument document = XmlDocument.parse(svgData);


  Size? size;
  String? width = document
      .findAllElements('svg')
      .first
      .getAttribute('width');
  String? height = document
      .findAllElements('svg')
      .first
      .getAttribute('height');
  String? viewBox =
  document
      .findAllElements('svg')
      .first
      .getAttribute('viewBox');

  if (width != null && height != null) {
    width = width.replaceAll(RegExp(r'[^0-9.]'), '');
    height = height.replaceAll(RegExp(r'[^0-9.]'), '');
    size = Size(double.parse(width), double.parse(height));
  } else if (viewBox != null) {
    List<String> viewBoxList = viewBox.split(' ');
    size = Size(double.parse(viewBoxList[2]), double.parse(viewBoxList[3]));
  }


// Paths
  final List<XmlElement> paths = document.findAllElements('path').toList();
  for (int i = 0; i < paths.length; i++) {
    final XmlElement element = paths[i];

    SubjectPath? path = _getSubjectPath(element);

    if (path != null) {
      pathsList.add(path);
    }
  }

//Points
  final List<XmlElement> points = document.findAllElements('circle').toList();
  for (int i = 0; i < points.length; i++) {
    final XmlElement element = points[i];

    CapitalPoint? point = _getCapitalPoint(element);

    if (point != null) {
      pointsList.add(point);
    }
  }

//Name
  final List<XmlElement> names = document.findAllElements('text').toList();
  for (int i = 0; i < names.length; i++) {
    final XmlElement element = names[i];

    CapitalName? name = _getCapitalName(element);

    if (name != null) {
      namesList.add(name);
    }
  }

  return VectorImage(
      pathsList: pathsList,
      pointsList: pointsList,
      namesList: namesList,
      size: size
  );
}

SubjectPath? _getSubjectPath(XmlElement element) {
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
  }
  else {
    color = Color(int.parse(fill.replaceAll("#", "0xFF")));
  }

  // get the id
  String? id = element.getAttribute('id');
  if (id == null) {
    return null;
  }

  return SubjectPath(
    fill: color,
    path: path,
    id: id,
  );
}

CapitalPoint? _getCapitalPoint(XmlElement element) {
  String? x = element.getAttribute('cx');
  String? y = element.getAttribute('cy');
  String? r = element.getAttribute('r');

  if (x == null || y == null || r == null) {
    return null;
  }

  Offset offset = Offset(double.parse(x), double.parse(y));
  double radius = double.parse(r);

  return CapitalPoint(
      offset: offset,
      radius: radius
  );
}

CapitalName? _getCapitalName(XmlElement element) {
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

    return CapitalName(
        offset: offset,
        name: name,
    );
  }

  String? _getFillColor(String data) {
    RegExp regExp = RegExp(r'fill:\s*(#[a-fA-F0-9]{6})');
    RegExpMatch? match = regExp.firstMatch(data);

    return match?.group(1);
  }
