import 'package:auto_size_text/auto_size_text.dart';
import 'package:coronatracker/provider/india_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_formatter/time_formatter.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  bool _init = false;
  bool _is_load = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_init == false) {
      setState(() {
        _is_load = true;
      });
      Provider.of<IndiaProvider>(context).fetch().then((_) {
        _showNotificationWithDefaultSound(
            Provider.of<IndiaProvider>(context, listen: false)
                .a
                .cases
                .toString());
        setState(() {
          _is_load = false;
          _init = true;
        });
      });
    }
    super.didChangeDependencies();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Total Case In India"),
          content: Text("Case : $payload"),
        );
      },
    );
  }

  Future _showNotificationWithDefaultSound(String cases) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Total Cases',
      cases,
      platformChannelSpecifics,
      payload: cases,
    );
  }

// Me
  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<IndiaProvider>(context).a;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return _is_load == false
        ? Card(
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: width - 50,
                  child: Center(
                    child: AutoSizeText(
                      "LAST UPDATE " +
                          formatTime(
                            item.updated == null
                                ? DateTime.now().millisecondsSinceEpoch
                                : item.updated,
                          ).toString(),
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: height / 8,
                      width: width / 4 - 10,
                      decoration: new BoxDecoration(
                        color: Colors.purple,
                        borderRadius: new BorderRadius.all(
                          Radius.elliptical(10.0, 10.0),
                        ),
                        gradient: new LinearGradient(
                          colors: [Colors.red, Colors.redAccent],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "CNFMD",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.cases.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height / 8,
                      width: width / 4 - 10,
                      decoration: new BoxDecoration(
                        color: Colors.purple,
                        borderRadius: new BorderRadius.all(
                          Radius.elliptical(10.0, 10.0),
                        ),
                        gradient: new LinearGradient(
                          colors: [Colors.blue, Colors.cyan],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "ACTV",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.active.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height / 8,
                      width: width / 4 - 10,
                      decoration: new BoxDecoration(
                        color: Colors.purple,
                        borderRadius: new BorderRadius.all(
                          Radius.elliptical(10.0, 10.0),
                        ),
                        gradient: new LinearGradient(
                          colors: [Colors.green, Colors.greenAccent],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "RCVRD",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.recovered.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height / 8,
                      width: width / 4 - 10,
                      decoration: new BoxDecoration(
                        color: Colors.purple,
                        borderRadius: new BorderRadius.all(
                          Radius.elliptical(10.0, 10.0),
                        ),
                        gradient: new LinearGradient(
                          colors: [Colors.grey, Colors.grey[600]],
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "DCSD",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.death.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
