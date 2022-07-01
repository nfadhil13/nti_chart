part of '../../nti_chart.dart';

class TileChart extends StatsChart {
  final TileChartLayout layoutType;
  final ImageData icon;
  final EdgeInsets? cardContainerPadding;
  TileChart({
    required this.layoutType,
    required this.icon,
    this.cardContainerPadding,
    required super.title,
    required super.value,
    super.cardBackgroundColor,
    super.cardElevation,
    super.borderRadius,
    super.textSpacing,
    super.textPadding,
    super.key,
  }) : super(
            textAlignment: layoutType.textAlignment,
            titlePosition: layoutType.titlePosition,
            cardPadding: layoutType.when(
                onDefault: () => cardContainerPadding,
                on2: (color) => EdgeInsets.zero));

  @override
  Widget buildChart(Widget textWidget, BuildContext context) {
    return layoutType.when(
        on1: () => _TileChartType1(image: icon, textWidget: textWidget),
        on2: (color) => _TileChartType2(
              radius: borderRadius,
              textWidget: textWidget,
              image: icon,
              imageBackgroundColor: color,
              padding: cardContainerPadding,
            ),
        on3: () => _TileChartType3(textWidget: textWidget, image: icon),
        on4: () => _TileChartType3(textWidget: textWidget, image: icon),
        on5: () => _TileChartType5(textWidget: textWidget, image: icon),
        on6: () => _TileChartType6(textWidget: textWidget, image: icon),
        onDefault: () => const SizedBox());
  }
}

class _TileChartType1 extends StatelessWidget {
  final Widget textWidget;
  final ImageData image;
  const _TileChartType1(
      {Key? key, required this.textWidget, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(flex: 1, child: image.getImageWidget()),
        Expanded(
          flex: 2,
          child: textWidget,
        )
      ],
    );
  }
}

class _TileChartType3 extends StatelessWidget {
  final Widget textWidget;
  final ImageData image;
  const _TileChartType3(
      {Key? key, required this.textWidget, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [image.getImageWidget(), textWidget],
    );
  }
}

class _TileChartType2 extends StatelessWidget {
  final Widget textWidget;
  final ImageData image;
  final Color? imageBackgroundColor;
  final EdgeInsets? padding;
  final double radius;
  const _TileChartType2(
      {Key? key,
      required this.textWidget,
      required this.image,
      this.imageBackgroundColor,
      required this.padding,
      this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(
                    color: imageBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        bottomLeft: Radius.circular(radius))),
                padding: padding,
                height: double.infinity,
                child: image.getImageWidget())),
        Expanded(
          flex: 2,
          child: textWidget,
        )
      ],
    );
  }
}

class _TileChartType5 extends StatelessWidget {
  final Widget textWidget;
  final ImageData image;
  const _TileChartType5(
      {Key? key, required this.textWidget, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(child: image.getImageWidget()),
        Positioned.fill(
            child: Container(alignment: Alignment.center, child: textWidget))
      ],
    );
  }
}

class _TileChartType6 extends StatelessWidget {
  final Widget textWidget;
  final ImageData image;
  const _TileChartType6(
      {Key? key, required this.textWidget, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: textWidget, flex: 3),
        Expanded(child: image.getImageWidget(), flex: 1)
      ],
    );
  }
}
