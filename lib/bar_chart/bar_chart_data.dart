part of '../nti_chart.dart';

class BarChartData {
  final Color? color;
  final int value;

  const BarChartData(this.value , {this.color});
}

class GroupedBarChartData {
  final Color defaultColor;
  final Map<String, BarChartData> data;

  const GroupedBarChartData({required this.defaultColor, required this.data});
}
