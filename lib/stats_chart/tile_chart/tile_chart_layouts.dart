part of '../../nti_chart.dart';

abstract class TileChartLayout {
  final int layoutId;
  final StatsChartTitleTextPosition titlePosition;
  final StatsChartTextAlignment textAlignment;

  TileChartLayout(
      {required this.textAlignment,
      required this.layoutId,
      required this.titlePosition});

  factory TileChartLayout.layout1() => _Layout1._();
  factory TileChartLayout.layout2(Color? imageBackgroundColor) =>
      _Layout2._(imageBackgroundColor);
  factory TileChartLayout.layout3() => _Layout3._();
  factory TileChartLayout.layout4() => _Layout4._();
  factory TileChartLayout.layout5() => _Layout5._();
  factory TileChartLayout.layout6() => _Layout6._();

  T when<T>({
    T Function()? on1,
    T Function(Color? color)? on2,
    T Function()? on3,
    T Function()? on4,
    T Function()? on5,
    T Function()? on6,
    required T Function() onDefault,
  }) {
    final current = this;
    if (current is _Layout1) return on1?.call() ?? onDefault();
    if (current is _Layout2) return on2?.call(current.color) ?? onDefault();
    if (current is _Layout3) return on3?.call() ?? onDefault();
    if (current is _Layout4) return on4?.call() ?? onDefault();
    if (current is _Layout5) return on5?.call() ?? onDefault();
    if (current is _Layout6) return on6?.call() ?? onDefault();
    throw Exception("Unknown TileChartLayout");
  }
}

class _Layout1 extends TileChartLayout {
  _Layout1._()
      : super(
            layoutId: 1,
            titlePosition: StatsChartTitleTextPosition.top,
            textAlignment: StatsChartTextAlignment.start);
}

class _Layout2 extends TileChartLayout {
  final Color? color;
  _Layout2._(this.color)
      : super(
            layoutId: 2,
            titlePosition: StatsChartTitleTextPosition.bot,
            textAlignment: StatsChartTextAlignment.start);
}

class _Layout3 extends TileChartLayout {
  _Layout3._()
      : super(
            layoutId: 3,
            titlePosition: StatsChartTitleTextPosition.bot,
            textAlignment: StatsChartTextAlignment.end);
}

class _Layout4 extends TileChartLayout {
  _Layout4._()
      : super(
            layoutId: 4,
            titlePosition: StatsChartTitleTextPosition.bot,
            textAlignment: StatsChartTextAlignment.start);
}

class _Layout5 extends TileChartLayout {
  _Layout5._()
      : super(
            layoutId: 5,
            titlePosition: StatsChartTitleTextPosition.bot,
            textAlignment: StatsChartTextAlignment.center);
}

class _Layout6 extends TileChartLayout {
  _Layout6._()
      : super(
            layoutId: 6,
            titlePosition: StatsChartTitleTextPosition.bot,
            textAlignment: StatsChartTextAlignment.start);
}
