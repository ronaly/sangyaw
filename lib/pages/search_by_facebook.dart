import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class SearchByFacebook extends AppLayoutContainer {
  String theText = 'Search by Facebook Name :)';

  @override
  String getTitle(context, AppState state) {
    return 'My Sangyawan App';
  }

  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = new Container (
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Form(
              child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      TextFormField(
                        // controller: facebookNameController.,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Facebook Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Enter Facebook Name:'),
                      )
                    ],
                  )
             )
          )
        ],
      ),
   );
    // END/RETURN The body
    return body;
  }
}
