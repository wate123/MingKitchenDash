import 'package:flutter/material.dart';

class CostStatsWidget extends StatefulWidget {
  CostStatsWidget({Key key, this.data}) : super(key: key);

  final Map<String, double> data;
  @override
  _CostStatState createState() => _CostStatState();
}

class _CostStatState extends State<CostStatsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
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
        child: Stack(
          children: [
            Text(
              '月支出',
              style:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8)),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '\$${widget.data["todaySale"]}',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '比上月支出',
                            style: new TextStyle(
                              // fontSize: 14.0,
                              color: Colors.black,
                            )),
                        WidgetSpan(
                            child: Icon(
                          Icons.arrow_upward,
                          size: 40,
                          color: Colors.red,
                        )),
                      ]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: '比去年本月',
                            style: new TextStyle(
                              // fontSize: 14.0,
                              color: Colors.black,
                            )),
                        WidgetSpan(
                            child: Icon(
                          Icons.arrow_upward,
                          size: 40,
                          color: Colors.red,
                        )),
                      ]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: RichText(
                      text: TextSpan(
                          text: '今年总支出 \$61,693',
                          style: new TextStyle(
                            // fontSize: 14.0,
                            color: Colors.black,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
