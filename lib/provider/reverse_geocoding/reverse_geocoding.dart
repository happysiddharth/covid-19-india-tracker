import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:geo/geo.dart' as geo;

class ReverseGeocoding with ChangeNotifier {
  String address = "";
  String country = "";
  String country_code = "";
  String county = "";
  String neighbourhood = "";
  String state = "";
  String state_code = "";
  String state_district = "";
  String town = "";
  String postcode = "";
  bool is_available = true;
  int is_door_delivery;
  String delivery_fees = "0";

  void set_is_door_delivery(int value) {
    is_door_delivery = value;
    notifyListeners();
  }

  void save_address(obj) {
    country = obj['country'];
    country_code = obj['country_code'];
    county = obj['county'];
    neighbourhood = obj['neighbourhood'];
    state = obj['state'];
    state_code = obj['state_code'];
    state_district = obj['state_district'];
    town = obj['town'];
    postcode = obj['postcode'];
    notifyListeners();
  }

  bool is_find = false;

  void delivery_fees_to_zero() {
    delivery_fees = "";
    notifyListeners();
  }

  bool cal_distance2(a, b, c, d) {
    if (geo
            .computeDistanceBetween(geo.LatLng(a, b), geo.LatLng(c, d))
            .toDouble() <
        11000.00) {
      print("true" +
          geo
              .computeDistanceBetween(geo.LatLng(a, b), geo.LatLng(c, d))
              .toDouble()
              .toString());
      return true;
    } else {
      print("false" +
          geo
              .computeDistanceBetween(geo.LatLng(a, b), geo.LatLng(c, d))
              .toDouble()
              .toString());
      return false;
    }
  }

  Future<String> getAddress(double lat, double lon, String station) async {
    print("asd");
    var url =
        "https://api.opencagedata.com/geocode/v1/json?key=e0b2815f0b1847fdbee971be08c80aa7&q=${lon}%2C+${lat}&pretty=1&no_annotations=1";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        print("as");
        return "";
      }
      print(extractedData['results'][0]['components']);
      save_address(extractedData['results'][0]['components']);
    } catch (error) {
      print(error);
    }
  }
}
