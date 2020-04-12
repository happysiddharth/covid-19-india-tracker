import 'package:auto_size_text/auto_size_text.dart';
import 'package:coronatracker/provider/district_wise_data.dart';
import 'package:coronatracker/provider/india_data_provider.dart';
import 'package:coronatracker/screen/screen.dart';
import 'package:coronatracker/screen/top_screen.dart';
import 'package:coronatracker/search/search_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  bool _loading = false;
  bool _init = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_init == false) {
      setState(() {
        _loading = true;
      });
      Provider.of<DistrictWiseData>(context).fetch_data().then((_) {
        setState(() {
          _loading = false;
        });
        _init = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            height: height / 4,
            width: width,
            child: TopScreen(),
          ),
          Container(
            height: 50,
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
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  child: AutoSizeText(
                    "ACTV",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  child: AutoSizeText(
                    "RECVR",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  child: AutoSizeText(
                    "DCSD",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          _loading == false
              ? Consumer<DistrictWiseData>(
                  builder: (_, item, __) {
                    return item
                                .find_by_name(Provider.of<SearchToggle>(context)
                                    .search_string)
                                .length >
                            0
                        ? Container(
                            height: height - (height / 4) - 136,
                            width: double.infinity,
                            child: ListView.builder(
                              itemBuilder: (_, i) {
                                return ChangeNotifierProvider.value(
                                  value: item.find_by_name(
                                      Provider.of<SearchToggle>(context)
                                          .search_string)[i],
                                  child: SingleData(),
                                );
                              },
                              itemCount: item
                                  .find_by_name(
                                      Provider.of<SearchToggle>(context)
                                          .search_string)
                                  .length,
                            ),
                          )
                        : Container(
                            child: Center(
                              child: Text("NO ITEM"),
                            ),
                          );
                  },
                )
              : Container(
                  height: height - height / 4,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
    );
  }
}
