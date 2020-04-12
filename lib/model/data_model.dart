import 'package:coronatracker/model/districtwise_data.dart';
import 'package:flutter/cupertino.dart';

class DataModel with ChangeNotifier {
  String active;
  String confirmed;
  String deaths;
  String deltaconfirmed;
  String deltadeaths;
  String deltarecovered;
  String lastupdatedtime;
  String recovered;
  String statecode;
  String state;

  List<Map<String, List<dynamic>>> district;
  List<String> sub_state;
  int total_confirmed;

  //
  bool is_expanded = false;
  void toggle() {
    is_expanded = !is_expanded;
    notifyListeners();
  }

  DataModel(
      {this.state,
      this.district,
      this.total_confirmed,
      this.sub_state,
      this.active,
      this.confirmed,
      this.deaths,
      this.deltaconfirmed,
      this.deltadeaths,
      this.deltarecovered,
      this.lastupdatedtime,
      this.recovered,
      this.statecode});
}
