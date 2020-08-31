import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';

class About extends AppLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return 'This is an About Page';
  }

  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = RichText(
      text: TextSpan(
        text: 'The Current Workbook: ${state.viewCurrentWorkbook},  ${state.viewMasterList.length}',
        style: TextStyle(
          fontSize: 20,
          color: Colors.lightBlue,
        ),
      ),
    );

    // END/RETURN The body
    return body;
  }

}
