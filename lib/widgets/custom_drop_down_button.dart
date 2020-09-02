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


    @override
    Widget buildBody(BuildContext context) {
    int dropdownValue = 1;

    if (this.dc.currentPerson.messengerStatus == "Active") { dropdownValue = 2;}
    if (this.dc.currentPerson.messengerStatus == "Inactive") { dropdownValue = 3;}

      return DropdownButton(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 18,
          elevation: 16,
          style: TextStyle(color: Colors.blueAccent),
          items:[
            DropdownMenuItem(
              child: Text(""),
              value:1,
            ),
            DropdownMenuItem(
              child: Text('Active'),
              value:2,
            ),

            DropdownMenuItem(
              child: Text('Inactive'),
              value:3,
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

