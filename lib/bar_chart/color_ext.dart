part of '../nti_chart.dart';

extension ColorExt on Color {
  charts.Color toChartsFlutterColor() =>
      charts.Color(r: red, g: green, b: blue);
}
