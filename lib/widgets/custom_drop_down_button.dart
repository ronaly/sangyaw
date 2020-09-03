import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:sangyaw_app/utils/custom_dropdown_items.dart';


import 'app_stateful_widget.dart';

//selected  // 0=gender, 1=ageGroup, 2=messengerstatus, 3=progresstatus



class CustomDropDownButton extends StatefulWidget {

    int selected;
    CustomDropDownButton(this.selected);

  _CustomDropDownButton createState() {
    return _CustomDropDownButton(selected);
  }
}

class _CustomDropDownButton extends AppStatefulWidget<CustomDropDownButton> {

    int selected;
    _CustomDropDownButton(this.selected);

    @override
    Widget buildBody(BuildContext context) {

     Widget customDropdown;


      switch (selected) {

        case 0:  //Gender
          int val = 1;
          if (this.dc.currentPerson.gender == "Male") {
            val = 2;
          }
          if (this.dc.currentPerson.gender == "Female") {
            val = 3;
          }
          customDropdown = genderDropdown(val);

          break;
        case 1:   //AgeGroup



          break;
        case 2:   //Messenger Status

          int val = 1;
          if (this.dc.currentPerson.messengerStatus == "Active") {
            val = 2;
          }
          if (this.dc.currentPerson.messengerStatus == "Inactive") {
              val = 3;
          }
           customDropdown = messengerDropdown(val);
            break;

        case 3:  //Progress Status

          int val = 1;
          if (this.dc.currentPerson.progressStatus == "RV") {
            val = 2;
          }
          if (this.dc.currentPerson.progressStatus == "BS") {
            val = 3;
          }
          customDropdown = progressDropdown(val);



          break;

        default:
          customDropdown = messengerDropdown(2);

      }


      return customDropdown;



    }  //widget build

  Widget messengerDropdown(int val) {
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
    } //messengerDropdown

    Widget genderDropdown(int val) {
      return DropdownButton(
        value: val,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        items:
        genderDropdownItems(),
        onChanged:
            (int newValue) {
          setState((){
            switch(newValue) {
              case 2 :
                this.dc.currentPerson.gender = "Male";
                break;
              case 3 :
                this.dc.currentPerson.gender = "Female";
                break;
              default :
                this.dc.currentPerson.gender = "";
            }
          });
        },
      );
    } //genderDropdown

    Widget progressDropdown(int val) {
      return DropdownButton(
        value: val,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        items:
        progressDropdownItems(),
        onChanged:
            (int newValue) {
          setState((){
            switch(newValue) {
              case 2 :
                this.dc.currentPerson.progressStatus = "RV";
                break;
              case 3 :
                this.dc.currentPerson.progressStatus = "BS";
                break;
              default :
                this.dc.currentPerson.gender = "";
            }
          });
        },
      );
    } //genderDropdown



} //class


