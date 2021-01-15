import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:isoweek/isoweek.dart';

class SalesChartsWidget extends StatefulWidget {
  SalesChartsWidget({Key key}) : super(key: key);

  @override
  _SaleChartsState createState() => _SaleChartsState();
}

class _SaleChartsState extends State<SalesChartsWidget> {
  double barWidth = 10;
  DateTime now = new DateTime.now().toUtc();
  DateTime _firstDayOfTheweek = Week.current().day(0);
  String duration2Text(int duration) {
    if (duration < 7) {
      return "本周";
    } else if (duration < 31) {
      return "本月";
    } else {
      return "本年";
    }
  }

  Week thisWeek = Week.current();
  String query = """
          query{
              getSalesByDate(input:{start: "${Week.current().day(0).toUtc().toIso8601String()}", end: "${new DateTime.now().toUtc().toUtc().toIso8601String()}", range_by:"day"}){
                time_point
                total_amount
              }
            }
    """;
  String rangeby = "day";
  int duration = 0;
  var monthDays;
  void salesRangeQuery(DateTime start, DateTime end) {
    monthDays = new DateTime(now.year, now.month + 1, 0, 23, 59, 59).day;

    setState(() {
      if (end.difference(start).inDays > monthDays) {
        rangeby = "month";
        barWidth = 15;
      } else if (end.difference(start).inDays < 8) {
        rangeby = "day";
        barWidth = 20;
      } else {
        rangeby = "day";
        barWidth = 10;
      }
      duration = end.difference(start).inDays;
      query = """
          query{
              getSalesByDate(input:{start: "${start.toUtc().toIso8601String()}", end: "${end.toUtc().toIso8601String()}", range_by:"$rangeby"}){
                time_point
                total_amount
              }
            }
    """;
    });
    // return query;
  }

  FlTitlesData title(List<int> time_points) {
    return FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(color: Colors.black, fontSize: 10),
        margin: 10,
        rotateAngle: 0,
        getTitles: (double value) {
          int v = value.toInt();
          if (duration < 7) {
            switch (v) {
              case 0:
                return '周一';
              case 1:
                return '周二';
              case 2:
                return '周三';
              case 3:
                return '周四';
              case 4:
                return '周五';
              case 5:
                return '周六';
              case 6:
                return '周日';
              default:
                return '';
            }
          } else {
            return (v + 1).toString();
          }
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(color: Colors.black, fontSize: 10),
        // rotateAngle: 45,
        getTitles: (double value) {
          if (value == 0) {
            return '0';
          }
          return '${value.toInt()}';
        },
        interval: duration > 32 ? 1000 : 100,
        margin: 5,
        reservedSize: 30,
      ),
    );
  }

  OutlineButton dateRangeButton(String text, Function refetch) {
    return OutlineButton(
        child: Text(text),
        onPressed: () => {
              if (text == "本月")
                {
                  salesRangeQuery(new DateTime(now.year, now.month, 1), now),
                }
              else if (text == "本年")
                {
                  salesRangeQuery(new DateTime(now.year, 1, 1),
                      new DateTime(now.year, 12, 31, 23, 59))
                }
              else
                {salesRangeQuery(_firstDayOfTheweek, now)},
              refetch()
            },
        textColor: Colors.black);
  }

  List<BarChartGroupData> indvBar(List data) {
    List<BarChartGroupData> res = [];
    for (var i = 0; i < data.length; i++) {
      res.add(BarChartGroupData(
        x: i,
        showingTooltipIndicators: duration < 9 ? [0] : [],
        barRods: [
          BarChartRodData(
            y: data[i]["total_amount"],
            width: barWidth,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(
                  0, data[i]["total_amount"], const Color(0xff2bdb90)),
            ],
          ),
        ],
      ));
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(documentNode: gql(query)),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (newMethod(result)) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return Text('Loading');
          }

          Timer.periodic(const Duration(minutes: 1), (Timer t) => {refetch});

          var res = result.data.data["getSalesByDate"]
              .map((e) => {
                    "time_point": e["time_point"],
                    "total_amount": (e["total_amount"] * 100).round() / 100
                  })
              .toList();
          return Container(
              width: double.infinity,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7)
                  ]),
              child: Column(
                children: [
                  Text(
                    "${duration2Text(duration)}销售额",
                    style: TextStyle(
                        color: const Color(0xff0f4a3c),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      dateRangeButton("本周", refetch),
                      dateRangeButton("本月", refetch),
                      dateRangeButton("本年", refetch),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceEvenly,
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                  // getTooltipItem:
                                  ),
                            ),
                            titlesData: title(res
                                .map((e) => e['time_point'])
                                .cast<int>()
                                .toList()),
                            gridData: FlGridData(
                              show: true,
                              checkToShowHorizontalLine: (value) =>
                                  value % (duration > 31 ? 1000 : 100) == 0,
                              getDrawingHorizontalLine: (value) {
                                if (value == 0) {
                                  return FlLine(
                                      color: const Color(0xff363753),
                                      strokeWidth: 3);
                                }
                                return FlLine(
                                  color: const Color(0xff2a2747),
                                  strokeWidth: 0.3,
                                );
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: indvBar(res),
                          ),
                        ),
                      ))
                ],
              ));
        });
  }

  bool newMethod(QueryResult result) => result.hasException;
}
