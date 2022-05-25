import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo/src/bloc/live_view/live_view_bloc.dart';
import 'package:neo/src/constants/hex_color.dart';
import 'package:neo/src/ui/high_speed/utils.dart';

class RoundSlider extends StatefulWidget {
  double radius;
  double maxvalue;
  String title;

  RoundSlider({this.radius, this.maxvalue, this.title});
  @override
  _RoundSliderState createState() => _RoundSliderState();
}

class _RoundSliderState extends State<RoundSlider> {
  double angle = pi - pi / 4;
  int limit = 50;
  RoundPainter _painter;

  double readingValue = Random().nextDouble();
  Timer _everySecond;
  bool once = true;
  @override
  void dispose() {
    // TODO: implement dispose
    if(_everySecond != null){
      _everySecond.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _calculatePaintData();
  }

  void _calculatePaintData() {
    _painter = RoundPainter(
        angle: angle,
        maxvalue: widget.maxvalue,
        limit: limit,
        readingValue: readingValue);
  }

  void _update(DragUpdateDetails u) {
    if (_painter.centerOffset == null) {
      return;
    }
    double testAngle = coordinatesToRadians(_painter.centerOffset,
            Offset(u.localPosition.dx, u.localPosition.dy)) -
        pi +
        pi / 4;

    double percentage = radiansToPercentage(testAngle);
    testAngle = percentageToRadians(percentage);
    // max == 88
    double currentLimit = percentage * 88 / 75;

    if (testAngle < pi + pi / 2 && testAngle > 0) {
      setState(() {
        angle = testAngle;
        limit = currentLimit.ceil();
        _calculatePaintData();
      });
    }
  }

  @override
  void didUpdateWidget(covariant RoundSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculatePaintData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragUpdate: (update) {
          _update(update);
        },
        onVerticalDragUpdate: (update) {
          _update(update);
        },
        child: Column(children: <Widget>[
          BlocBuilder<LiveViewBloc, bool>(builder: (context, isIt) {
            if (isIt && once) {
              once = false;
              // context.read<LiveViewBloc>().add(false);

              // defines a timer
              _everySecond =
                  Timer.periodic(Duration(milliseconds: 250), (Timer t) {
                setState(() {
                  readingValue = Random().nextDouble();
                  _calculatePaintData();
                });
              });
            }
            if (isIt == false && once == false) {
              _everySecond.cancel();
              once = true;
            }

            return Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(border: Border.all()),
                child: CustomPaint(
                  painter: _painter,
                ));
          }),
        ]));
  }
}

class RoundPainter extends CustomPainter {
  double angle;
  int limit;
  double maxvalue;
  double currentInputAngle = pi - pi / 4;
  Size size;
  Paint strokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..strokeCap = StrokeCap.round;

  Paint strokePaintBlue = Paint()
    ..style = PaintingStyle.stroke
    ..color = HexColor.neoBlue()
    ..strokeCap = StrokeCap.round;

  Paint fillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = HexColor.neoBlue();

  double strokeWidthOfBig;

  double readingValue;

  RoundPainter({this.maxvalue, this.angle, this.limit, this.readingValue});

  Offset centerOffset;

  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;
    this.centerOffset = Offset(size.width / 2, size.height / 2 + 20);
    this.strokeWidthOfBig = size.width / 20;
    strokePaint.strokeWidth =
        strokePaintBlue.strokeWidth = this.strokeWidthOfBig;

    _drawTriangle(canvas);
    _drawSoundLevelArc(canvas);

    _drawLimitArc(canvas);
    _drawTextValue(
        canvas,
        this.limit.toString(),
        'LIMIT',
        Offset(centerOffset.dx - 60, centerOffset.dy - 50),
        this.size.width / 150);
    _drawTextValue(
        canvas,
        88.toString(),
        'MAX',
        Offset(centerOffset.dx + 20, centerOffset.dy - 50),
        this.size.width / 150);
    _drawTextValue(
        canvas,
        radiansToPercentage(this.readingValue).toString().substring(0, 4),
        'READING',
        Offset(centerOffset.dx - 55, centerOffset.dy + 30),
        this.size.width / 80);

    _drawAgendaValue(canvas, 0.toString(),
        Offset(centerOffset.dx - 105, centerOffset.dy + 120));
    _drawAgendaValue(canvas, 100.toString(),
        Offset(centerOffset.dx + 70, centerOffset.dy + 120));
    // _drawValue(canvas, size, (maxvalue * angle / pi).round());
  }

  void _drawTriangle(canvas) {
    double height = 10;
    double width = 10;
    double xMiddle = this.centerOffset.dx;
    double yMiddle =
        this.centerOffset.dy - size.width / 2 - this.strokeWidthOfBig / 2;

    Path path = Path()
      ..moveTo(xMiddle, yMiddle)
      ..lineTo(xMiddle - width / 2, yMiddle - height)
      ..lineTo(xMiddle + width / 2, yMiddle - height)
      ..lineTo(xMiddle, yMiddle);

    canvas.drawPath(path, fillPaint);
  }

  void _drawSoundLevelArc(Canvas canvas) {
    double radius = this.size.width / 2;

    canvas.drawArc(Rect.fromCircle(center: this.centerOffset, radius: radius),
        pi - pi / 4, pi + pi / 2, false, strokePaint);

    canvas.drawArc(Rect.fromCircle(center: this.centerOffset, radius: radius),
        pi - pi / 4, this.readingValue * pi, false, strokePaintBlue);
  }

  void _drawLimitArc(Canvas canvas) {
    double radius = this.size.width / 3;
    strokePaint.strokeWidth = strokePaintBlue.strokeWidth = size.width / 60;

    canvas.drawArc(Rect.fromCircle(center: this.centerOffset, radius: radius),
        pi - pi / 4, pi + pi / 2, false, strokePaint);
    canvas.drawArc(Rect.fromCircle(center: this.centerOffset, radius: radius),
        pi - pi / 4, this.angle, false, strokePaintBlue);

    strokePaint.strokeWidth = 1;
    Offset circleOffset = radiansToCoordinates(
        this.centerOffset, this.angle + pi - pi / 4, radius);
    canvas.drawCircle(circleOffset, size.width / 30, fillPaint);
    canvas.drawCircle(circleOffset, size.height / 30, strokePaintBlue);
  }

  void _drawTextValue(
      Canvas canvas, String value, String text, Offset offset, double scale) {
    TextSpan span = new TextSpan(
        style: new TextStyle(color: HexColor.neoBlue()), text: value);
    TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        textScaleFactor: scale);
    tp.layout(minWidth: 0);
    Offset newOffset = offset;
    tp.paint(canvas, newOffset);

    TextSpan spanSmall =
        new TextSpan(style: new TextStyle(color: HexColor.white()), text: text);
    TextPainter tpSmall = TextPainter(
        text: spanSmall,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        strutStyle: StrutStyle(fontWeight: FontWeight.w700),
        textScaleFactor: scale / 2.4);
    tpSmall.layout(minWidth: 0);
    Offset newOffsetSmall =
        Offset(offset.dx + scale * 2, offset.dy + scale * 15);
    tpSmall.paint(canvas, newOffsetSmall);
  }

  void _drawAgendaValue(Canvas canvas, String text, Offset offset) {
    TextSpan spanSmall = new TextSpan(
        style: new TextStyle(color: HexColor.lightGray()), text: text);
    TextPainter tpSmall = TextPainter(
        text: spanSmall,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
        strutStyle: StrutStyle(fontWeight: FontWeight.w700),
        textScaleFactor: 1.4);
    tpSmall.layout(minWidth: 0);
    tpSmall.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
