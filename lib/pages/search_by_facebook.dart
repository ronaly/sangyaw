import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/search_facebook_form.dart';

class SearchByFacebook extends AppLayoutContainer {
  String theText = 'Search by Facebook Name :)';

  @override
  String getTitle(context, AppState state) {
    return 'My Sangyawan App';
  }

  Widget buildBody(context, AppState state) {


    // START BODY HERE
    Widget body = SearchFacebookForm();


    // END/RETURN The body
    return body;
  }
}
