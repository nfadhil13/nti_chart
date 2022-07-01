part of "../../nti_chart.dart";

enum StatsChartTitleTextPosition {
  top,
  bot,
}

enum StatsChartTextAlignment {
  start(CrossAxisAlignment.start),
  center(CrossAxisAlignment.center),
  end(CrossAxisAlignment.end);

  final CrossAxisAlignment alignment;

  const StatsChartTextAlignment(this.alignment);
}
