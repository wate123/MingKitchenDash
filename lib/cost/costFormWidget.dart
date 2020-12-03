import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CostFormWidget extends StatefulWidget {
  @override
  _CostFormWidgetState createState() => _CostFormWidgetState();
}

class _CostFormWidgetState extends State<CostFormWidget> {
  List<String> items = ["超市", "批发", "水费", "电费", "网费", "煤气费", "房租"];
  String _selected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
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
            Wrap(
                children: items
                    .map(
                      (e) => Container(
                        padding: EdgeInsets.all(5),
                        child: ChoiceChip(
                          label: Text(e),
                          selected: _selected == e,
                          onSelected: (bool selected) {
                            setState(() {
                              _selected = e;
                            });
                          },
                        ),
                      ),
                    )
                    .toList()),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "支出金额"),
              onSubmitted: (value) => {print(value)},
            )
          ],
        ));
  }
}
