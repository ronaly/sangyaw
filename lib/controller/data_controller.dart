import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/person.dart';



//Data Controller will get masterlist record from GoogleSheets

// HTTP GET request on Google App Script Web URL and parses response and sends result callback.

//ToDO: populate list of persons specific to assignee


class DataController {


  // Google App Script Web URL.
  static const String URL_Pamutan = "https://script.google.com/macros/s/AKfycbwsKt8R9yIWp_vMpCxxDmZlhSBFMJp2T5MZmLp7vi_B760KfVM/exec";

  static const String URL_Toong = "https://script.google.com/macros/s/AKfycbw2Xz2F_okd_ciCHavm57HalTdDrE3V1aiYg-6Zi6qegvZJioo/exec";

  //Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";


  // Async function which loads feedback from endpoint URL and returns List

  Future<List<Person>> getMasterListFromPamutan() async {
    return await http.get(URL_Pamutan).then((response) {

       var jsonList = convert.jsonDecode(response.body) as List;
       return jsonList.map((json) => Person.fromJson(json)).toList();
    });
  } //getMasterListFromPamutan

  Future<List<Person>> getMasterListFromToong() async {
    return await http.get(URL_Toong).then((response) {

      var jsonList = convert.jsonDecode(response.body) as List;
      return jsonList.map((json) => Person.fromJson(json)).toList();
    });
  } //getMasterListFromToong





} // DataController class




















