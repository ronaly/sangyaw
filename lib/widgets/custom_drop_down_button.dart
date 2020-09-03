import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:sangyaw_app/utils/ui_utils.dart';


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

   static var genderMap = {1:" ",2:"Male",3:"Female" };
   static var messengerStatusMap = {1:" ",2:"Active",3:"Inactive" };
   static var progressStatusMap = {1:" ",2:"RV",3:"BS" };
   static var ageGroupMap = {1:" ",2:"< 12",3:"12 to 16",4:"17 to 25",
     5:"26 to 35",6:"36 to 50",7:"> 50" };

    int selected;
    _CustomDropDownButton(this.selected);

    @override
    Widget buildBody(BuildContext context) {

     Widget customDropdown;


      switch (selected) {
        case 0:  //Gender
          int val;
          val = genderMap.keys.firstWhere((k) => genderMap[k] == this.dc.currentPerson.gender, orElse: () => 1);
          customDropdown = genderDropdown(val);
          break;
        case 1:   //AgeGroup
          int val;
          val = ageGroupMap.keys.firstWhere((k) => ageGroupMap[k] == this.dc.currentPerson.ageGroup, orElse: () => 1);
          customDropdown = ageGroupDropdown(val);
          break;
        case 2:   //Messenger Status
          int val;
          val = messengerStatusMap.keys.firstWhere((k) => messengerStatusMap[k] == this.dc.currentPerson.messengerStatus, orElse: () => 1);
          customDropdown = messengerDropdown(val);
            break;
        case 3:  //Progress Status
          int val;
          val = progressStatusMap.keys.firstWhere((k) => progressStatusMap[k] == this.dc.currentPerson.progressStatus, orElse: () => 1);
          customDropdown = progressDropdown(val);
          break;

        default:
          customDropdown = messengerDropdown(2);
      }

      return customDropdown;

    }  //widget build



   Widget ageGroupDropdown(int val) {
     return DropdownButton(
       value: val,
       icon: Icon(Icons.arrow_downward),
       iconSize: 18,
       elevation: 16,
       style: TextStyle(color: Colors.black),
       items:
       ageGroupDropdownItems(),
       onChanged:
           (int newValue) {
         setState((){
           this.dc.currentPerson.ageGroup = ageGroupMap[newValue];
         });
       },
     );
   } //genderDropdown



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
          this.dc.currentPerson.gender = genderMap[newValue];
        });
      },
    );
  } //genderDropdown




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
            this.dc.currentPerson.messengerStatus = messengerStatusMap[newValue];
          });
       },
     ); //DropdownButton
    } //messengerDropdown


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
            this.dc.currentPerson.progressStatus = progressStatusMap[newValue];
          });
        },
      );
    } //genderDropdown



} //class


