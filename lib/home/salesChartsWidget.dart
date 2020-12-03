import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesChartsWidget extends StatefulWidget {
  SalesChartsWidget({Key key, this.data}) : super(key: key);

  final List data;
  @override
  _SaleChartsState createState() => _SaleChartsState();
}

class _SaleChartsState extends State<SalesChartsWidget> {
  static const double barWidth = 22;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 0.8,
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
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
                Text("本周销售额"),
                BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    maxY: 20,
                    // minY: -20,
                    groupsSpace: 12,
                    barTouchData: BarTouchData(
                      enabled: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 10),
                        margin: 10,
                        rotateAngle: 0,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return '一';
                            case 1:
                              return '二';
                            case 2:
                              return '三';
                            case 3:
                              return '四';
                            case 4:
                              return '五';
                            case 5:
                              return '六';
                            case 6:
                              return '日';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 10),
                        rotateAngle: 45,
                        getTitles: (double value) {
                          if (value == 0) {
                            return '0';
                          }
                          return '${value.toInt()}';
                        },
                        interval: 5,
                        margin: 8,
                        reservedSize: 30,
                      ),
                      rightTitles: SideTitles(
                        showTitles: true,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 10),
                        rotateAngle: 90,
                        getTitles: (double value) {
                          if (value == 0) {
                            return '0';
                          }
                          return '${value.toInt()}';
                        },
                        interval: 5,
                        margin: 8,
                        reservedSize: 30,
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      checkToShowHorizontalLine: (value) => value % 5 == 0,
                      getDrawingHorizontalLine: (value) {
                        if (value == 0) {
                          return FlLine(
                              color: const Color(0xff363753), strokeWidth: 3);
                        }
                        return FlLine(
                          color: const Color(0xff2a2747),
                          strokeWidth: 0.8,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            y: 15.1,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                            rodStackItems: [
                              BarChartRodStackItem(
                                  0, 2, const Color(0xff2bdb90)),
                              BarChartRodStackItem(
                                  2, 5, const Color(0xffffdd80)),
                              BarChartRodStackItem(
                                  5, 7.5, const Color(0xffff4d94)),
                              BarChartRodStackItem(
                                  7.5, 15.5, const Color(0xff19bfff)),
                            ],
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            y: 13,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                            rodStackItems: [
                              BarChartRodStackItem(
                                  0, 1.5, const Color(0xff2bdb90)),
                              BarChartRodStackItem(
                                  1.5, 3.5, const Color(0xffffdd80)),
                              BarChartRodStackItem(
                                  3.5, 7, const Color(0xffff4d94)),
                              BarChartRodStackItem(
                                  7, 13, const Color(0xff19bfff)),
                            ],
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            y: 13.5,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                            rodStackItems: [
                              BarChartRodStackItem(
                                  0, 1.5, const Color(0xff2bdb90)),
                              BarChartRodStackItem(
                                  1.5, 3, const Color(0xffffdd80)),
                              BarChartRodStackItem(
                                  3, 7, const Color(0xffff4d94)),
                              BarChartRodStackItem(
                                  7, 13.5, const Color(0xff19bfff)),
                            ],
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            y: 18,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6)),
                            rodStackItems: [
                              BarChartRodStackItem(
                                  0, -2, const Color(0xff2bdb90)),
                              BarChartRodStackItem(
                                  -2, -4, const Color(0xffffdd80)),
                              BarChartRodStackItem(
                                  -4, -9, const Color(0xffff4d94)),
                              BarChartRodStackItem(
                                  -9, -18, const Color(0xff19bfff)),
                            ],
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(
                            y: 17,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6)),
                            rodStackItems: [
                              BarChartRodStackItem(
                                  0, -1.2, const Color(0xff2bdb90)),
                              BarChartRodStackItem(
                                  -1.2, -2.7, const Color(0xffffdd80)),
                              BarChartRodStackItem(
                                  -2.7, -7, const Color(0xffff4d94)),
                              BarChartRodStackItem(
                                  -7, -17, const Color(0xff19bfff)),
                            ],
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(
                            y: 16,
                            width: barWidth,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6)),
                            rodStackItems: [
                              BarChartRodStackItem(
                                  0, 1.2, const Color(0xff2bdb90)),
                              BarChartRodStackItem(
                                  1.2, 6, const Color(0xffffdd80)),
                              BarChartRodStackItem(
                                  6, 11, const Color(0xffff4d94)),
                              BarChartRodStackItem(
                                  11, 17, const Color(0xff19bfff)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
