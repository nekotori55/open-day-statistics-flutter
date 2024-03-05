import 'dart:math';
import 'package:flutter/material.dart';

import "models.dart";

class PathPainter extends CustomPainter {
  const PathPainter(this._subjectPaths, this._scale, this._strokeWidth);

  final List<MapPath> _subjectPaths;
  final double _scale;
  final double _strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(_scale, _scale);
    final paint = Paint();

    for (MapPath subjectPath in _subjectPaths) {
      Path path = subjectPath.path;

      paint.color = subjectPath.fill;
      paint.style = PaintingStyle.fill;

      canvas.drawPath(path, paint);

      paint.color = Colors.black;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = _strokeWidth;

      canvas.drawPath(path, paint);

      paint.color = Colors.blue;
      paint.style = PaintingStyle.fill;
    }
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => false;
}

class PointPainter extends CustomPainter {
  const PointPainter(this._capitalPoints, this._scale);

  final List<MapPoint> _capitalPoints;
  final double _scale;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(_scale, _scale);
    final paint = Paint();
    paint.color = Colors.black;

    for (MapPoint capitalPoint in _capitalPoints) {
      canvas.drawCircle(capitalPoint.offset, capitalPoint.radius, paint);
    }
  }

  @override
  bool shouldRepaint(PointPainter oldDelegate) => false;
}

class NamePainter extends CustomPainter {
  const NamePainter(this._capitalNames, this._scale, this._fontSize);

  final List<MapString> _capitalNames;
  final double _scale;
  final double _fontSize;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(_scale, _scale);
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: _fontSize,
      fontWeight: FontWeight.w600,
    );

    for (MapString capitalName in _capitalNames) {
      var textSpan = TextSpan(
        text: capitalName.name,
        style: textStyle,
      );
      var textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, capitalName.offset.translate(0, -_fontSize));
    }
  }

  @override
  bool shouldRepaint(NamePainter oldDelegate) => false;
}

class LinePainter extends CustomPainter {
  LinePainter({this.startPathsList, this.startPointsList, required this.scale, required this.endPos, required this.shift});

  final List<MapPath>? startPathsList;
  final List<MapPoint>? startPointsList;

  final double scale;
  final Offset endPos;
  final double shift;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale, scale);
    final paint = Paint();
    paint.strokeWidth = 1.5;
    paint.color = Color(0xFF3892f6);

    bool fromPaths = (startPathsList != null);
    int? iterationsNum = fromPaths ? startPathsList!.length : startPointsList!.length;


    for (int i = 0; i < iterationsNum; i++) {
      Offset startPos;
      if (fromPaths) {
        Path path = startPathsList![i].path;
        startPos = path.getBounds().center;
      }
      else {
        startPos = startPointsList![i].offset;
      }

      Offset curPos = startPos;
      Offset drawVector = endPos - startPos;
      Offset moveVector = drawVector / drawVector.distance;

      double lineLength = 8.0;
      double spaceLength = 5.0;
      double stepLength = lineLength + spaceLength;

      if (shift > spaceLength && (curPos - startPos).distance < drawVector.distance) {
        canvas.drawLine(curPos, curPos + (moveVector * (shift - spaceLength)), paint);
      }
      curPos = curPos + (moveVector * shift);

      while ((curPos - startPos).distance < drawVector.distance) {
        var ll = min(lineLength, (curPos - endPos).distance);
        canvas.drawLine(curPos, curPos + (moveVector * ll), paint);
        curPos = curPos + (moveVector * stepLength);
      }
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class AmountPainter extends CustomPainter {
  const AmountPainter(this._subjectPaths, this._scale, this._visitorsNum);

  final List<MapPath> _subjectPaths;
  final double _scale;
  final int _visitorsNum;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(_scale, _scale);
    final paint = Paint();
    paint.color = Color(0xFF3892f6);

    double fontSize = 15 + log(_visitorsNum * _visitorsNum);

    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );

    for (MapPath subjectPath in _subjectPaths) {
      Path path = subjectPath.path;
      Offset center = path.getBounds().center;

      canvas.drawCircle(center, 10 + log(_visitorsNum * _visitorsNum), paint);

      var textSpan = TextSpan(
        text: _visitorsNum.toString(),
        style: textStyle,
      );
      var textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(center.dx - textPainter.width * 0.5, center.dy - textPainter.height * 0.5));
    }
  }

  @override
  bool shouldRepaint(AmountPainter oldDelegate) => true;
}
