import 'dart:math';
import 'package:flutter/material.dart';

import "models.dart";

class PathPainter extends CustomPainter {
  const PathPainter(this._subjectPath, this._scale, this._strokeWidth);

  final SubjectPath _subjectPath;
  final double _scale;
  final double _strokeWidth;


  @override
  void paint(Canvas canvas, Size size) {
    Path path = _subjectPath.path;
    canvas.scale(_scale, _scale);

    final paint = Paint();
    paint.color = _subjectPath.fill;
    paint.style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = _strokeWidth;

    canvas.drawPath(path, paint);

    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => false;
}

class PointPainter extends CustomPainter {
  const PointPainter(this.capitalPoint, this.scale);

  final CapitalPoint capitalPoint;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;

    canvas.scale(scale, scale);
    canvas.drawCircle(capitalPoint.offset, capitalPoint.radius, paint);
  }

  @override
  bool shouldRepaint(PointPainter oldDelegate) => false;
}

class NamePainter extends CustomPainter {
  const NamePainter(this.capitalName, this.scale, this.fontSize);

  final CapitalName capitalName;
  final double scale;
  final double fontSize;

  @override
  void paint(Canvas canvas, Size size) {
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
    var textSpan = TextSpan(
      text: capitalName.name,
      style: textStyle,
    );
    var textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 1000,
    );
    canvas.scale(scale);
    textPainter.paint(canvas, capitalName.offset.translate(0, -fontSize));
  }

  @override
  bool shouldRepaint(NamePainter oldDelegate) => false;
}

class LinePainter extends CustomPainter {
  const LinePainter(this._subjectPath, this._scale, this._centerOffcet, this._shift);

  final SubjectPath _subjectPath;
  final double _scale;
  final Offset _centerOffcet;
  final double _shift;


  @override
  void paint(Canvas canvas, Size size) {
    Path path = _subjectPath.path;
    canvas.scale(_scale, _scale);

    final paint = Paint();
    Offset startPos = path.getBounds().center;
    Offset endPos = _centerOffcet;
    Offset curPos = startPos;
    Offset drawVector = _centerOffcet - startPos;
    Offset moveVector = drawVector / drawVector.distance;

    double lineLength = 8.0;
    double spaceLength = 5.0;
    double stepLength = lineLength + spaceLength;

    curPos = curPos + (moveVector * _shift);

    paint.strokeWidth = 1.5;
    paint.color = Color(0xFF3892f6);

    while ((curPos - startPos).distance < drawVector.distance) {
      var ll = min(lineLength, (curPos - endPos).distance);
      canvas.drawLine(curPos, curPos + (moveVector * ll), paint);
      curPos = curPos + (moveVector * stepLength);
    }

    canvas.drawCircle(startPos, 5, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}
