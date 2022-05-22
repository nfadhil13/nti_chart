part of '../nti_chart.dart';

enum DescriptionAlignment {
  center(WrapAlignment.center),
  start(WrapAlignment.start),
  end(WrapAlignment.end),
  spaceAround(WrapAlignment.spaceAround),
  spaceBetween(WrapAlignment.spaceBetween),
  spaceEvenly(WrapAlignment.spaceEvenly);

  final WrapAlignment _wrapAlignment;
  const DescriptionAlignment(this._wrapAlignment);
}

class CardStyle {
  final Color? color;
  final double? elevation;
  final EdgeInsets? padding;
  final double? radius;
  final ShapeBorder? shape;

  const CardStyle(this.shape,
      {this.color, this.elevation, this.padding, this.radius});
}

class GroupedBarChart extends StatelessWidget {
  final Map<String, GroupedBarChartData> data;
  final bool? animate;
  final int? viewPortNumber;
  final bool isScrollable;

  const GroupedBarChart(this.data,
      {super.key,
      this.animate,
      this.viewPortNumber,
      this.isScrollable = false});

  factory GroupedBarChart.withCard(Map<String, GroupedBarChartData> data,
      {required Widget title,
      required TextStyle descriptionStyle,
      bool? animate,
      int? viewPortNumber,
      double textMargin = 8,
      Key? key,
      CardStyle? cardStyle,
      DescriptionAlignment descriptionAlignment = DescriptionAlignment.center,
      bool isScrollable = false}) {
    return _GroupedBarChartWithCard(data,
        title: title,
        descriptionStyle: descriptionStyle,
        textMargin: textMargin,
        animate: animate,
        cardStyle: cardStyle,
        viewPortNumber: viewPortNumber,
        isScrollable: isScrollable,
        descriptionAlignment: descriptionAlignment,
        key: key);
  }

  List<charts.Series<dynamic, String>> mapFromBarChartData(
      {required Iterable<MapEntry<String, GroupedBarChartData>> entries}) {
    return entries
        .map((e) => charts.Series<MapEntry<String, BarChartData>, String>(
            id: e.key,
            domainFn: (MapEntry<String, BarChartData> value, _) => value.key,
            measureFn: (MapEntry<String, BarChartData> value, _) =>
                value.value.value,
            data: e.value.data.entries.toList(),
            colorFn: (MapEntry<String, BarChartData> value, _) {
              final defaultColor = e.value.defaultColor.toChartsFlutterColor();
              final barColor = value.value.color?.toChartsFlutterColor();
              return barColor ?? defaultColor;
            }))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final entries = data.entries;
    return charts.BarChart(
      mapFromBarChartData(entries: entries),
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: isScrollable
          ? [charts.SlidingViewport(), charts.PanAndZoomBehavior()]
          : [],
      domainAxis: !isScrollable
          ? null
          : charts.OrdinalAxisSpec(
              viewport: charts.OrdinalViewport(
                  entries.first.key, viewPortNumber ?? entries.length)),
    );
  }
}

class _GroupedBarChartWithCard extends GroupedBarChart {
  final Widget title;
  final TextStyle descriptionStyle;
  final double textMargin;
  final DescriptionAlignment descriptionAlignment;
  final CardStyle? cardStyle;
  const _GroupedBarChartWithCard(super.data,
      {required this.title,
      this.cardStyle,
      required this.descriptionStyle,
      this.textMargin = 8,
      this.descriptionAlignment = DescriptionAlignment.center,
      super.animate,
      super.viewPortNumber,
      super.isScrollable,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: cardStyle?.shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: cardStyle?.color,
      elevation: cardStyle?.elevation,
      child: Padding(
        padding: cardStyle?.padding ?? const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: double.infinity, child: title),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: textMargin,
                alignment: descriptionAlignment._wrapAlignment,
                children: data.entries
                    .map((e) => _BarDescription(
                        description: e.key,
                        style: descriptionStyle,
                        circleColor: e.value.defaultColor))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(child: super.build(context))
          ],
        ),
      ),
    );
  }
}

class _BarDescription extends StatelessWidget {
  final TextStyle style;
  final String description;
  final Color circleColor;
  const _BarDescription(
      {Key? key,
      required this.style,
      required this.circleColor,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 90% Of Font Size
    final double circleSize =
        style.fontSize == null ? style.fontSize! * 5 / 10 : 12;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: circleSize,
            width: circleSize,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: circleColor)),
        const SizedBox(width: 5),
        Text(description, style: style)
      ],
    );
  }
}
