import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';


class CustomDropDownButton extends StatelessWidget {

    int _value =1;
    List<DropdownMenuItem<ListItem>>  dropDownMenuItems;
    ListItem selectedItem;

    void initState(){
      super.initState();
      dropDownMenuItems = buildDropDownMenuItems(setupMessengerStatus);
      selectedItem = dropDownMenuItems[0].value;
    }

    @override
    Widget build(BuildContext context) {

      return DropdownButton(
          value: 1,
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
           // onChanged: (value),{
           //
           // }

      ); //DropdownButton

    }  //widget build


   List<DropDownMenuItem<ListItem>> buildDropDownMenuItems (List listItems) {
     List<DropDownMenuItem<ListItem>> items = List();
      for (ListItem listItem in listItems) {
        items.add(
          DropDownMenuItem(
            child: Text(listItem.name),
            value: listItem,
          ),
        );
      }
      return items;
  }  //buildDropDownMenuItems

  ListItem setupMessengerStatus() {
      ListItem items =[];
      return  items = [
        ListItem(1, "Active"),
        ListItem(2, "Inactive")
      ];
  }

  ListItem setupProgressStatus() {
      ListItem items =[];
      return  items = [
        ListItem(1, "RV"),
        ListItem(2, "BS")
      ];
  }


} //class

class ListItem {
   int value;
   String name;

   ListItem(this.value, this.name);
}