import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class PersonDetails extends AppLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return 'Person Details:';
  }

  Widget buildBody(context, AppState state) {
    String str = this.dc.assignToList.join(', ');
    // START BODY HERE
    Widget body = RichText(
      text: TextSpan(
        text: 'CurrentPerson Details: ${this.dc.currentPerson != null ? this.dc.currentPerson.toString() : 'No Person Assigned'}',
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
