part of '../nti_chart.dart';

abstract class StatsChart extends StatelessWidget {
  final Text title;
  final Text value;
  final StatsChartTitleTextPosition titlePosition;
  final Color? cardBackgroundColor;
  final double? cardElevation;
  final double borderRadius;
  final EdgeInsets? cardPadding;
  final double? textSpacing;
  final EdgeInsets? textPadding;
  final StatsChartTextAlignment textAlignment;

  const StatsChart(
      {Key? key,
      required this.title,
      required this.value,
      this.cardBackgroundColor,
      this.cardElevation,
      this.borderRadius = 6,
      this.textSpacing,
      this.cardPadding,
      this.titlePosition = StatsChartTitleTextPosition.bot,
      this.textAlignment = StatsChartTextAlignment.center,
      this.textPadding})
      : super(key: key);

  Widget _buildTextChart() {
    return _StatsChartText(
        value: value,
        title: title,
        titlePosition: titlePosition,
        textSpacing: textSpacing,
        textPadding: textPadding,
        statsChartTextAlignment: textAlignment);
  }

  Widget buildChart(Widget textWidget, BuildContext context);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          elevation: cardElevation,
          color: cardBackgroundColor ?? Colors.white,
          child: Padding(
              padding: cardPadding ?? const EdgeInsets.all(16),
              child: buildChart(_buildTextChart(), context)),
        ));
  }
}

class _StatsChartText extends StatelessWidget {
  final Text value;
  final Text title;
  final double? textSpacing;
  final StatsChartTitleTextPosition titlePosition;
  final StatsChartTextAlignment statsChartTextAlignment;
  final EdgeInsets? textPadding;

  const _StatsChartText(
      {Key? key,
      required this.value,
      required this.title,
      required this.titlePosition,
      this.textSpacing,
      required this.statsChartTextAlignment, this.textPadding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: textPadding ?? EdgeInsets.zero,
        child: Builder(builder: (ctx) {
          switch (titlePosition) {
            case StatsChartTitleTextPosition.bot:
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: statsChartTextAlignment.alignment,
                children: [value, SizedBox(width: textSpacing), title],
              );
            case StatsChartTitleTextPosition.top:
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: statsChartTextAlignment.alignment,
                children: [title, SizedBox(height: textSpacing), value],
              );
          }
        }));
  }
}
