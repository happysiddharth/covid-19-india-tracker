import 'package:auto_size_text/auto_size_text.dart';
import 'package:coronatracker/model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SingleData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final item = Provider.of<DataModel>(context);
    return Container(
      width: width,
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    width: width / 6,
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                      child: item.is_expanded
                          ? Icon(Icons.arrow_left)
                          : Icon(Icons.arrow_right),
                      onTap: () {
                        item.toggle();
                      },
                    ),
                  ),
                  Container(
                    width: width / 6,
                    child: AutoSizeText(
                      item.state,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: width / 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          item.total_confirmed.toString(),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                              size: 15,
                            ),
                            Text(
                              (int.parse(item.deltaconfirmed)).toString(),
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width / 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          item.active,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.blue,
                              size: 15,
                            ),
                            Text(
                              "0",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width / 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          item.recovered,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                              size: 15,
                            ),
                            Text(
                              item.deltarecovered,
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width / 6 - 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          item.deaths,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.yellow,
                              size: 15,
                            ),
                            Text(
                              item.deltadeaths,
                              style: TextStyle(color: Colors.yellow),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          item.is_expanded == true
              ? Container(
                  child: Text(
                    "LAST UPDATED ABOUT: " + (item.lastupdatedtime).toString(),
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          item.is_expanded == true
              ? Container(
                  margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: AutoSizeText(
                          "STATE/UT",
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: AutoSizeText(
                          "CNFM",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          item.is_expanded == true
              ? Container(
                  margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                  height: 200,
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              AutoSizeText(
                                item.district[index].keys
                                    .toString()
                                    .replaceAll('(', "")
                                    .replaceAll(')', ""),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  AutoSizeText(
                                    item.district[index].values
                                        .toString()
                                        .replaceAll('(', "")
                                        .replaceAll(')', "")
                                        .replaceAll('[', "")
                                        .replaceAll(']', "")
                                        .split(",")[0],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                      AutoSizeText(
                                        item.district[index].values
                                            .toString()
                                            .replaceAll('(', "")
                                            .replaceAll(')', "")
                                            .replaceAll('[', "")
                                            .replaceAll(']', "")
                                            .split(",")[1],
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Divider()
                        ],
                      );
                    },
                    itemCount: item.district.length,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
