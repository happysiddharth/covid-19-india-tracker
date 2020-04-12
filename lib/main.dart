import 'package:auto_size_text/auto_size_text.dart';
import 'package:coronatracker/provider/district_wise_data.dart';
import 'package:coronatracker/screen/bottom_screen.dart';
import 'package:coronatracker/screen/screen.dart';
import 'package:coronatracker/search/search_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/india_data_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DistrictWiseData(),
        ),
        ChangeNotifierProvider.value(
          value: SearchToggle(),
        ),
        ChangeNotifierProvider.value(
          value: IndiaProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Corona Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _init = false;
  bool _is_expand = false;

  @override
  Widget build(BuildContext context) {
    final search_toggle = Provider.of<SearchToggle>(context);
    void searchResult(String name) {
      search_toggle.add_string(name.toLowerCase());
    }

    Future<bool> _refresh() async {
      Provider.of<IndiaProvider>(context, listen: false).fetch().then((_) {});
      Provider.of<DistrictWiseData>(context, listen: false)
          .fetch_data()
          .then((_) {});
    }

    return Scaffold(
      appBar: search_toggle.search == false
          ? AppBar(
              elevation: 0,
              title: Text(
                "COVID-19 Tracker",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                  onPressed: search_toggle.toggle,
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 170,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 170,
                        child: TextField(
                          onChanged: (data) => searchResult(data),
                          autofocus: true,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: 'Search By State',
                            border: InputBorder.none,
                            hintStyle: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: FlatButton.icon(
                    onPressed: () => search_toggle.toggle(),
                    label: Text(
                      'cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: BottomMenu(),
        ),
      ),
    );
  }
}
