import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/bucawe_form.dart';



//Form Controller is a class, it does work of saving BucaweForm in Google Sheets

// HTTP GET request on Google App Script Web URL and parses response and sends result callback.


class FormController {


  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbwsKt8R9yIWp_vMpCxxDmZlhSBFMJp2T5MZmLp7vi_B760KfVM/exec";

  //Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";


  // Async function which loads feedback from endpoint URL and returns List

  Future<List<BucaweForm>> getDataFromBucaweForm() async {

    return await http.get(URL).then((response) {

       var jsonList = convert.jsonDecode(response.body) as List;
       return jsonList.map((json) => BucaweForm.fromJson(json)).toList();

    });

  } //getDataFromBucaweForm





} // FormController




















