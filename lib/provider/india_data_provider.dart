import 'dart:convert';

import 'package:coronatracker/model/india_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class IndiaProvider with ChangeNotifier {
  India _a = India();
  India get a {
    return _a;
  }

  Future fetch() async {
    final String url = 'https://corona.lmao.ninja/countries/India';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      _a.updated = extractedData['updated'];
      _a.cases = extractedData['cases'];
      _a.today_death = extractedData['todayDeaths'];
      _a.recovered = extractedData['recovered'];
      _a.active = extractedData['active'];
      _a.tests = extractedData['tests'];
      _a.death = extractedData['deaths'];
      print(extractedData);
    } catch (e) {}
  }
}
