part of '../nti_chart.dart';

class StatsChart extends StatelessWidget {
  final Text titleText;
  final Text? detailText;
  final ImageData? icon;
  final StatsChartAlignment alignment;
  final Color? cardBackgroundColor;
  final double? cardElevation;
  final ShapeBorder? shapeBorder;
  final EdgeInsetsGeometry? cardPadding;
  final double? textSpacing;

  const StatsChart(
      {Key? key,
      required this.titleText,
      this.detailText,
      this.icon,
      this.alignment = StatsChartAlignment.center,
      this.cardBackgroundColor,
      this.cardElevation,
      this.shapeBorder,
      this.textSpacing,
      this.cardPadding})
      : super(key: key);

  Widget renderWhenCenter(Widget textWidget, Widget? imageWidget) {
    return Stack(
      children: [
        if (imageWidget != null) Positioned(child: imageWidget),
        Positioned.fill(child: textWidget)
      ],
    );
  }

  Widget renderWhenSpaceAround(Widget textWidget, Widget? imageWidget) {
    return Row(
      mainAxisAlignment: imageWidget != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [if (imageWidget != null) imageWidget, textWidget],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = _TextWidget(
        titleText: titleText, detailText: detailText, textSpacing: textSpacing);
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: shapeBorder ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: cardElevation,
        color: cardBackgroundColor ?? Colors.white,
        child: Padding(
            padding: cardPadding ?? const EdgeInsets.all(16),
            child: alignment.isCenter()
                ? renderWhenCenter(textWidget, icon?.getImageWidget())
                : renderWhenSpaceAround(textWidget, icon?.getImageWidget())),
      ),
    );
  }
}

class _TextWidget extends StatelessWidget {
  final Text titleText;
  final Text? detailText;
  final double? textSpacing;
  const _TextWidget(
      {Key? key, required this.titleText, this.detailText, this.textSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleText,
          if (detailText != null && textSpacing != null)
            SizedBox(height: textSpacing),
          detailText ?? const SizedBox.shrink(),
        ],
      );
}
