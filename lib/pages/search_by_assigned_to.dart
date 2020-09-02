import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/search_assigned_form.dart';

class SearchByAssignedTo extends AppStatelessLayoutContainer {
  String theText = 'Search by Assigned Name :)';

  @override
  String getTitle(context, AppState state) {
    return 'My Sangyawan App';
  }



  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body =  SearchAssignedForm();


    // END/RETURN The body
    return body;
  }
}
