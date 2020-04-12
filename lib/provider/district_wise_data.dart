import 'dart:convert';

import 'package:coronatracker/model/case_time_series.dart';
import 'package:coronatracker/model/data_model.dart';
import 'package:coronatracker/model/districtwise_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DistrictWiseData with ChangeNotifier {
  List<DataModel> _items = [];
  List<CaseTimeSeries> _items_time_serier = [];
  List<DataModel> get item {
    return List.from(_items);
  }

  List<CaseTimeSeries> get items_time_serier {
    return List.from(_items_time_serier);
  }

  int comp(DataModel a, DataModel b) {
    return b.total_confirmed.compareTo(a.total_confirmed);
  }

  bool already_in_list(List<DataModel> a, DataModel f) {
    for (int i = 0; i < a.length; i++) {
      if (a[i].state.toLowerCase() == f.state.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  List<DataModel> find_by_name(String name) {
    if (name == "") {
      return [..._items];
    }
    List<DataModel> l = _items
        .where((data) =>
            data.state.toLowerCase().toString().toLowerCase().contains(name))
        .toList();
    return l;
  }

  List<DataModel> clean(List<DataModel> a) {
    List<DataModel> newa = [];
    a.forEach((f) {
      if (already_in_list(newa, f) != true) {
        print(f.state);

        newa.add(f);
      }
    });
    return newa;
  }

  Future fetch_data() async {
    final String url = 'https://api.covid19india.org/data.json';
    try {
      final response = await http.get(url);
      final extractedData_StateWise = json.decode(response.body);
      if (extractedData_StateWise == null) {
        return;
      }

      final List<DataModel> loadedProducts = [];
      final List<CaseTimeSeries> loadedProducts_ = [];

      final String url2 =
          'https://api.covid19india.org/state_district_wise.json';
      try {
        final response_district_wise = await http.get(url2);
        final extractedData =
            json.decode(response_district_wise.body) as Map<String, dynamic>;
        if (extractedData == null) {
          return;
        }
        extractedData_StateWise['statewise'].forEach((state_data) {
          DataModel temp = DataModel(
            state: state_data['state'],
            active: state_data['active'],
            confirmed: state_data['confirmed'],
            deltaconfirmed: state_data['deltaconfirmed'],
            deltadeaths: state_data['deltadeaths'],
            deltarecovered: state_data['deltarecovered'],
            lastupdatedtime: state_data['lastupdatedtime'],
            recovered: state_data['recovered'],
            deaths: state_data['deaths'],
            statecode: state_data['statecode'],
            total_confirmed: 0,
            district: [],
            sub_state: [],
          );
          int tp;
          try {
            var t = (extractedData[state_data['state']]['districtData'])
                as Map<String, dynamic>;
            t.forEach((key, value) {
              temp.total_confirmed =
                  temp.total_confirmed + (value['confirmed']);
              Map<String, List<dynamic>> map_ = {
                key: [value['confirmed'], value["delta"]["confirmed"]]
              };
              temp.district.add(map_);
            });
          } catch (e) {}
          loadedProducts.add(temp);
        });
        _items.clear();
        _items = clean(loadedProducts);
        _items.sort(comp);
        extractedData_StateWise['cases_time_series'].forEach((state_data) {
          loadedProducts_.add(CaseTimeSeries(
            dailyconfirmed: state_data['dailyconfirmed'],
            dailydeceased: state_data['dailydeceased'],
            dailyrecovered: state_data['dailyrecovered'],
            totalconfirmed: state_data['dailyconfirmed'],
            totaldeceased: state_data['totaldeceased'],
            totalrecovered: state_data['totalrecovered'],
            date: state_data['date'],
          ));
        });
        _items_time_serier = loadedProducts_;
        print("len" + _items.length.toString());
      } catch (e) {}
    } catch (e) {
      print(e);
    }
  }
}
