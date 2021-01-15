import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SalesStatsWidget extends StatefulWidget {
  SalesStatsWidget({Key key}) : super(key: key);

  TextSpan styledUpDownAmount(String prefix, double amount) {
    return amount >= 0.0
        ? TextSpan(children: [
            TextSpan(
                text: prefix,
                style: new TextStyle(
                  // fontSize: 14.0,
                  color: Colors.black,
                )),
            WidgetSpan(
                child: Icon(
              Icons.arrow_upward,
              color: Colors.green,
              size: 20,
            )),
            TextSpan(
              text: '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.green),
            ),
          ])
        : TextSpan(children: [
            TextSpan(
                text: prefix,
                style: new TextStyle(
                  // fontSize: 14.0,
                  color: Colors.black,
                )),
            WidgetSpan(
                child: Icon(
              Icons.arrow_downward,
              color: Colors.red,
              size: 20,
            )),
            TextSpan(
              text: '\$${(amount * -1).toStringAsFixed(2)}',
              style: TextStyle(color: Colors.red),
            ),
          ]);
  }

  @override
  _SaleStatState createState() => _SaleStatState();
}

class _SaleStatState extends State<SalesStatsWidget> {
  @override
  Widget build(BuildContext context) {
    String salesStatsQuery = """
      query{
        getAllSalesStats{
          today
          today_yesterday_diff
          this_year_today_last_year_today_diff
          total
        }
      }
    """;
    return Query(
      options: QueryOptions(documentNode: gql(salesStatsQuery)),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }
        Timer.periodic(const Duration(minutes: 1), (Timer t) => {refetch});
        var res = result.data.data["getAllSalesStats"];
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
                  '日销售额',
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.8)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '\$${res["today"].toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: widget.styledUpDownAmount(
                              '比昨日', res['today_yesterday_diff'].toDouble()),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: widget.styledUpDownAmount(
                              '比去年今日',
                              res['this_year_today_last_year_today_diff']
                                  .toDouble()),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          text: TextSpan(
                              text:
                                  '今年总销售额 \$${res['total'].toStringAsFixed(2)}',
                              style: new TextStyle(
                                // fontSize: 14.0,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RichText(
                          text: TextSpan(
                              text: '净利润 \$0',
                              style: new TextStyle(
                                // fontSize: 14.0,
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
