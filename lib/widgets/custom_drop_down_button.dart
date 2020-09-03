import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:sangyaw_app/utils/custom_dropdown_items.dart';


import 'app_stateful_widget.dart';

//final int whichWidget = 0;   // 0=gender, 1=ageGroup, 2=messengerstatus, 3=progresstatus



class CustomDropDownButton extends StatefulWidget {
  _CustomDropDownButton createState() {
    return _CustomDropDownButton();
  }
}

class _CustomDropDownButton extends AppStatefulWidget<CustomDropDownButton> {


    @override
    Widget buildBody(BuildContext context) {

      int val = 1;
      if (this.dc.currentPerson.messengerStatus == "Active") {
        val = 2;
      }
      if (this.dc.currentPerson.messengerStatus == "Inactive") {
        val = 3;
      }



      return DropdownButton(
          value: val,
          icon: Icon(Icons.arrow_downward),
          iconSize: 18,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          items:
          messengerDropdownItems(),
          onChanged:
               (int newValue) {
             setState((){
               switch(newValue) {
                 case 2 :
                   this.dc.currentPerson.messengerStatus = "Active";
                   break;
                 case 3 :
                   this.dc.currentPerson.messengerStatus = "Inactive";
                   break;
                 default :
                   this.dc.currentPerson.messengerStatus = "";
               }
              });
            },
      ); //DropdownButton

    }  //widget build

   // List<DropdownMenuItem<int>> messengerDropdownItems() {
   //   return (
   //       [
   //         DropdownMenuItem(
   //           child: Text(""),
   //           value:1,
   //         ),
   //         DropdownMenuItem(
   //           child: Text('Active'),
   //           value:2,
   //         ),
   //         DropdownMenuItem(
   //           child: Text('Inactive'),
   //           value:3,
   //         ),
   //
   //       ]
   //   ).toList();
   // }


} //class


