import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';


class About extends StatefulWidget {
  @override
  _About createState() => new _About();
}


class _About extends AppStatefulLayoutContainer<About> {

  @override
  String getTitle() {
    return 'This is an About Page';
  }


  Widget buildBody(context, AppState state) {
    String str = this.dc.assignToList.join(', ');
    // START BODY HERE
    Widget body = RichText(
      text: TextSpan(
        text: 'Assigned To List: ${str}',
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
