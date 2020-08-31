import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class Home extends AppLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';

  @override
  String getTitle(context, AppState state) {
    return 'My Sangyawan App';
  }

  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = RichText(
      text: TextSpan(
        text: theText,
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
