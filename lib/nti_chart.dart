library nti_chart;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

// Stats Card
part './stats_chart/util/stats_chart_alignment.dart';
part './stats_chart/stats_chart.dart';

//Bar Chart
part './bar_chart/bar_chart_data.dart';
part './bar_chart/grouped_bar_chart.dart';

//Tile Chart
part './stats_chart/tile_chart/tile_chart.dart';
part './stats_chart/tile_chart/tile_chart_layouts.dart';

//KPI Chart
part 'stats_chart/kpi_chart/kpi_chart.dart';

//?*Util
part './util/text_attribute.dart';
part 'util/icon_data.dart';
part 'util/color_ext.dart';
part 'util/formatter.dart';
