import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';

class SearchedPersons extends AppStatelessLayoutContainer {

  @override
  String getTitle() {
    return 'Search Results:';
  }


  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = PersonList(list: this.dc.findPersonsFBContains(this.dc.queryTerm));

    // END/RETURN The body
    return body;
  }
}