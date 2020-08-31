import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/widgets/person_list.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {

          return AppLayoutContainer(
              title: 'Found ${state.masterList.length} Persons  ${state.currentWorkbook}',
              child: this.getBody(context, state),
          );
        });
  }

  Widget getBody(context, state) {

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
