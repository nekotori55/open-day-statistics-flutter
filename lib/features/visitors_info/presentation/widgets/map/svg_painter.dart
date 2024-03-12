import 'dart:math';
import 'package:flutter/cupertino.dart';
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
    paint.strokeWidth = _strokeWidth;

    for (MapPath subjectPath in _subjectPaths) {
      Path path = subjectPath.path;

      if (subjectPath.isDisplay == false) {
        paint.color = Colors.grey;
        paint.style = PaintingStyle.stroke;

        canvas.drawPath(path, paint);
      } else {
        paint.color = subjectPath.fill;
        paint.style = PaintingStyle.fill;

        canvas.drawPath(path, paint);

        paint.color = Colors.grey;
        paint.style = PaintingStyle.stroke;

        canvas.drawPath(path, paint);
      }
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
    paint.color = Color(0xFF777777);

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
      color: Color(0xFF777777),
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
  LinePainter({
    this.startPathsList,
    this.startPointsList,
    required this.scale,
    required this.endPos,
    required this.shift,
    required this.visitorsNums,
  });

  final List<MapPath>? startPathsList;
  final List<MapPoint>? startPointsList;

  final double scale;
  final Offset endPos;
  final double shift;
  final Map<String, int> visitorsNums;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale, scale);
    final paint = Paint();
    paint.strokeWidth = 1.5;
    paint.color = Color(0xFF3892f6);

    bool fromPaths = (startPathsList != null);
    int? iterationsNum =
        fromPaths ? startPathsList!.length : startPointsList!.length;

    for (int i = 0; i < iterationsNum; i++) {
      Offset startPos;
      if (fromPaths) {
        if (visitorsNums[startPathsList![i].id] == null) {
          continue;
        }
        Path path = startPathsList![i].path;
        startPos = path.getBounds().center;
      } else {
        if (visitorsNums[startPointsList![i].id] == null) {
          continue;
        }
        startPos = startPointsList![i].offset;
      }

      Offset curPos = startPos;
      Offset drawVector = endPos - startPos;
      Offset moveVector = drawVector / drawVector.distance;

      double lineLength = 8.0;
      double spaceLength = 5.0;
      double stepLength = lineLength + spaceLength;

      if (shift > spaceLength &&
          (curPos - startPos).distance < drawVector.distance) {
        canvas.drawLine(
            curPos, curPos + (moveVector * (shift - spaceLength)), paint);
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
  const AmountPainter(this._subjectPaths, this._scale, this._visitorsNums);

  final List<MapPath> _subjectPaths;
  final double _scale;
  final Map<String, int> _visitorsNums;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(_scale, _scale);
    final paint = Paint();
    paint.color = Color(0xFF3892f6);

    for (MapPath subjectPath in _subjectPaths) {
      var visitorsNum = _visitorsNums[subjectPath.id];
      if (visitorsNum == null) {
        continue;
      }
      Path path = subjectPath.path;
      Offset center = path.getBounds().center;

      canvas.drawCircle(center, 10 + log(visitorsNum * visitorsNum), paint);

      var textStyle = TextStyle(
        color: Colors.white,
        fontSize: 15 + log(visitorsNum * visitorsNum),
        fontWeight: FontWeight.w600,
      );
      var textSpan = TextSpan(
        text: _visitorsNums[subjectPath.id].toString(),
        style: textStyle,
      );
      var textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(center.dx - textPainter.width * 0.5,
              center.dy - textPainter.height * 0.55));
    }
  }

  @override
  bool shouldRepaint(AmountPainter oldDelegate) => true;
}

class SchoolPainter extends CustomPainter {
  const SchoolPainter(
    this._capitalPoints,
    this._scale,
    this._visitorsNums,
  );

  final List<MapPoint> _capitalPoints;
  final double _scale;
  final Map<String, int> _visitorsNums;

  @override
  void paint(Canvas canvas, Size size) {
    double fontSize = 8;
    canvas.scale(_scale, _scale);
    final paint = Paint();
    paint.color = Colors.blueGrey;

    for (var capitalPoint in _capitalPoints) {
      var visitorsNum = _visitorsNums[capitalPoint.id];
      if (visitorsNum == null) {
        continue;
      }

      canvas.drawCircle(capitalPoint.offset, fontSize + 2, paint);

      var textSpan = TextSpan(
        children: [
          TextSpan(
            text: '№',
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize / 1.5,
              fontWeight: FontWeight.w600,
              fontFamily: "Arial",
            ),
          ),
          TextSpan(
            text: capitalPoint.id,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              fontFamily: "Arial",
            ),
          ),
          TextSpan(
            text: '№',
            style: TextStyle(
              color: Colors.transparent,
              fontSize: fontSize / 4,
              fontWeight: FontWeight.w600,
              fontFamily: "Arial",
            ),
          ),
        ],
      );
      var textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(capitalPoint.offset.dx - textPainter.width * 0.5,
              capitalPoint.offset.dy - textPainter.height * 0.5));
    }
  }

  @override
  bool shouldRepaint(SchoolPainter oldDelegate) => false;
}
