// import 'package:aptapp/colors.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:dart_date/dart_date.dart';
// import 'package:flutter/material.dart';
// import 'package:health/health.dart';
// import 'package:intl/intl.dart';

// class SensorStackedBarChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;

//   SensorStackedBarChart(this.seriesList, {this.animate});

//   factory SensorStackedBarChart.withSampleData(BuildContext context, List<HealthDataPoint> healthDataList) {
//     return new SensorStackedBarChart(
//       _createSampleData(context, healthDataList),
//       animate: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double cardHeight = height * 0.6;
//     return Expanded(
//       child: Container(
//         width: width * 0.95,
//         height: cardHeight,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.0),
//           ),
//         ),
//         child: Card(
//           elevation: 2,
//           child: Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SelectableText(
//                       "Heart rate",
//                       style: Theme.of(context).textTheme.bodyText2.copyWith(color: lightTextColor, letterSpacing: 1.1),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Sensor {
//   final DateTime date;
//   final int value;

//   Sensor(
//     this.date,
//     this.value,
//   );
// }
