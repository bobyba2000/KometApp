import 'dart:math';
import 'dart:ui';

double percentageToRadians(double percentage) => ((2 * pi * percentage) / 100);

double radiansToPercentage(double radians) {
  var normalized = radians < 0 ? -radians : 2 * pi - radians;
  var percentage = ((100 * normalized) / (2 * pi));
  // TODO we have an inconsistency of pi/2 in terms of percentage and radians
  return (percentage + 25) % 100;
}

double coordinatesToRadians(Offset center, Offset coords) {
  var a = coords.dx - center.dx;
  var b = center.dy - coords.dy;
  return atan2(b, a);
}

Offset radiansToCoordinates(Offset center, double radians, double radius) {
  var dx = center.dx + radius * cos(radians);
  var dy = center.dy + radius * sin(radians);
  return Offset(dx, dy);
}

double valueToPercentage(int time, int intervals) => (time / intervals) * 100;

int percentageToValue(double percentage, int intervals) =>
    ((percentage * intervals) / 100).round();
