import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';

import 'app_stateful_widget.dart';


class CustomDropDownButton extends StatefulWidget {
  _CustomDropDownButton createState() {
    return _CustomDropDownButton();
  }
}

class _CustomDropDownButton extends AppStatefulWidget<CustomDropDownButton> {
  int dropdownValue = 1;

    @override
    Widget buildBody(BuildContext context) {

      return DropdownButton(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 18,
          elevation: 16,
          style: TextStyle(color: Colors.blueAccent),
          items:[
            DropdownMenuItem(
              child: Text('Active'),
              value:1,
            ),
            DropdownMenuItem(
              child: Text('Inactive'),
              value:2,
            ),
          ],
           onChanged:
               (int newValue) {
             setState((){
                dropdownValue = newValue;
              });
           },

      ); //DropdownButton

    }  //widget build





} //class

