import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';

class SearchedPersons extends AppLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return 'Found results in ${this.dc.currentDirectory}';
  }

  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = PersonList(list: this.dc.persons);

    // END/RETURN The body
    return body;
  }
}