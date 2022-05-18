part of "../nti_chart.dart";

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  const GroupedBarChart(this.seriesList, {Key? key, this.animate})
      : super(key: key);

  factory GroupedBarChart.withSampleData() {
    return GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: charts.BarChart(
        seriesList,
        animate: animate,
        barGroupingType: charts.BarGroupingType.grouped,
        // behaviors: [charts.SlidingViewport(), charts.PanAndZoomBehavior()],
        // domainAxis:  charts.OrdinalAxisSpec(
        //     viewport: charts.OrdinalViewport('2014', 4)),
      ),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      OrdinalSales('2014', -5),
      OrdinalSales('2015', -25),
      OrdinalSales('2016', -100),
      OrdinalSales('2017', 75),
      OrdinalSales('2018', 5),
      OrdinalSales('2019', 25),
      OrdinalSales('2020', 100),
      OrdinalSales('2021', 75),
      OrdinalSales('2022', 5),
      OrdinalSales('2023', 25),
      OrdinalSales('2024', 100),
      OrdinalSales('2025', 75),
      OrdinalSales('2026', 5),
      OrdinalSales('2027', 25),
      OrdinalSales('2028', 100),
      OrdinalSales('2029', 75),
    ];

    final tableSalesData = [
      OrdinalSales('2014', 25),
      OrdinalSales('2015', 50),
      OrdinalSales('2016', 10),
      OrdinalSales('2017', 20),
      OrdinalSales('2018', 5),
      OrdinalSales('2019', 25),
      OrdinalSales('2020', 100),
      OrdinalSales('2021', 75),
      OrdinalSales('2022', 5),
      OrdinalSales('2023', 25),
      OrdinalSales('2024', 100),
      OrdinalSales('2025', 75),
      OrdinalSales('2026', 5),
      OrdinalSales('2027', 25),
      OrdinalSales('2028', 100),
      OrdinalSales('2029', 75),
    ];

    final mobileSalesData = [
      OrdinalSales('2014', 10),
      OrdinalSales('2015', 15),
      OrdinalSales('2016', 50),
      OrdinalSales('2017', 45),
      OrdinalSales('2018', 5),
      OrdinalSales('2019', 25),
      OrdinalSales('2020', 100),
      OrdinalSales('2021', 75),
      OrdinalSales('2022', 5),
      OrdinalSales('2023', 25),
      OrdinalSales('2024', 100),
      OrdinalSales('2025', 75),
      OrdinalSales('2026', 5),
      OrdinalSales('2027', 25),
      OrdinalSales('2028', 100),
      OrdinalSales('2029', 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      charts.Series<OrdinalSales, String>(
          id: 'Tablet',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: tableSalesData,
          colorFn: (sales, _) => charts.Color(
              r: Colors.amber.red,
              g: Colors.amber.green,
              b: Colors.amber.blue)),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
