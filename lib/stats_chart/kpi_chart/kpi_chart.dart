part of '../../nti_chart.dart';

class KPICurrentTargetData {
  final double value;
  final TextAttribute? valueTextAtt;
  final Text desc;
  final int? fractionDigits;

  const KPICurrentTargetData(
      {required this.value,
      this.valueTextAtt,
      required this.desc,
      this.fractionDigits});

  Widget _getWidget(double totalValue) {
    final percentage =
        (value / totalValue * 100).toStringAsFixed(fractionDigits ?? 0);
    final percentageString = "$percentage%";
    final percentageTextWidget =
        valueTextAtt?.createText(percentageString) ?? Text(percentageString);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [desc, percentageTextWidget],
    );
  }
}

class KPIChartPercentageStyle {
  final Color? activeColor;
  final Color? notActiveColor;
  final TextAttribute? percentageTextAtt;
  final double? barWidth;
  final double? barHeight;
  final double? spacing;
  final double? barRadius;
  final int? fractionDigits;

  KPIChartPercentageStyle(
      {this.activeColor,
      this.fractionDigits,
      this.notActiveColor,
      this.percentageTextAtt,
      this.spacing,
      this.barRadius,
      this.barHeight,
      this.barWidth});
}

class KPIChart extends StatsChart {
  final double currentValue;
  final Formatter<double>? valueFormatter;
  final ImageData icon;
  final String? splitter;
  final double? targetValue;
  final KPICurrentTargetData? currentTargetData;
  final KPIChartPercentageStyle? percentageStyle;
  final TextAttribute? valueTextAtt;
  KPIChart(
      {Key? key,
      required this.currentValue,
      required this.icon,
      required super.title,
      super.borderRadius,
      super.cardBackgroundColor,
      super.cardElevation,
      super.cardPadding,
      super.textSpacing,
      this.valueTextAtt,
      this.currentTargetData,
      this.valueFormatter,
      this.percentageStyle,
      this.targetValue,
      this.splitter})
      : super(
            key: key,
            textAlignment: StatsChartTextAlignment.center,
            titlePosition: StatsChartTitleTextPosition.top,
            value: _getValue(
                current: currentValue,
                textAttribute: valueTextAtt ?? const TextAttribute(),
                formatter: valueFormatter,
                splitter: splitter,
                target: targetValue));

  static const _defaultSplitter = "/";

  static Text _getValue(
      {required double current,
      double? target,
      String? splitter,
      required TextAttribute textAttribute,
      Formatter<double>? formatter}) {
    final currentInString = formatter?.call(current) ?? current.toString();
    if (target == null) return textAttribute.createText(currentInString);
    final targetInString = formatter?.call(target) ?? target.toString();
    final finalSplitter = splitter ?? _defaultSplitter;
    return textAttribute
        .createText("$currentInString$finalSplitter$targetInString");
  }

  @override
  Widget buildChart(Widget textWidget, BuildContext context) {
    return Stack(
      children: [
        Positioned(child: icon.getImageWidget()),
        Positioned.fill(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (targetValue != null && currentTargetData != null)
                      currentTargetData!._getWidget(targetValue!),
                    textWidget,
                    if (targetValue != null)
                      _KPIPercentage(
                          currentValue: currentValue,
                          totalValue: targetValue!,
                          style: percentageStyle)
                  ],
                )))
      ],
    );
  }
}

class _KPIPercentage extends StatelessWidget {
  final double currentValue;
  final double totalValue;
  final KPIChartPercentageStyle? style;
  const _KPIPercentage(
      {Key? key,
      required this.currentValue,
      required this.totalValue,
      this.style})
      : super(key: key);

  static const _defaultRadius = 6.0;
  static const _defaultSpacing = 6.0;

  @override
  Widget build(BuildContext context) {
    final totalValue = this.totalValue.abs();
    final double percentage = currentValue / totalValue;
    final percentageString =
        "${(percentage * 100).toStringAsFixed(style?.fractionDigits ?? 0)}%";
    final radius = style?.barRadius ?? _defaultRadius;
    final spacing = style?.spacing ?? _defaultSpacing;
    return Column(
      children: [
        Container(
          width: style?.barWidth ?? double.infinity,
          height: style?.barHeight ?? 10,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: style?.notActiveColor ?? Colors.black,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: LayoutBuilder(builder: (ctx, constraint) {
            final width = percentage >= 1 ? constraint.maxWidth : percentage * constraint.maxWidth;
            return Container(
                width: width < 0 ? 0 : width,
                height: constraint.maxHeight,
                decoration: BoxDecoration(
                  color: style?.activeColor ?? Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      bottomLeft: Radius.circular(radius)),
                ));
          }),
        ),
        SizedBox(height: spacing),
        style?.percentageTextAtt?.createText(percentageString) ??
            Text(percentageString)
      ],
    );
  }
}
