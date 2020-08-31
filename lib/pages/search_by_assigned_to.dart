import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class SearchByAssignedTo extends AppLayoutContainer {
  String theText = 'Search by Assigned Name :)';

  @override
  String getTitle(context, AppState state) {
    return 'My Sangyawan App';
  }

  Widget buildBody(context, AppState state) {

    // START BODY HERE
    Widget body = new Container (
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                            return 'Enter Assigned Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Enter Assigned Name:'),
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
