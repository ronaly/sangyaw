import 'package:flutter/material.dart';

//List<DropdownMenuItem<int>>
//List<Widget>

List<DropdownMenuItem<int>> ageGroupDropdownItems() {
  var value = {1:" ",2:"< 12",3:"12 to 16",4:"17 to 25",
               5:"26 to 35",6:"36 to 50",7:"> 50" };

  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(
        DropdownMenuItem(
          child: Text(value),
          value:key,
        ));
  });

  return listItem.toList();

}



List<DropdownMenuItem<int>> messengerDropdownItems() {
  var value = {1:" ",2:"Active",3:"Inactive" };
  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(
        DropdownMenuItem(
          child: Text(value),
          value:key,
        ));
  });

  return listItem.toList();
}

List<DropdownMenuItem<int>> genderDropdownItems() {

  var value = {1:" ",2:"Male",3:"Female" };

  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(
        DropdownMenuItem(
          child: Text(value),
          value:key,
        ));
  });

  return listItem.toList();

}

List<DropdownMenuItem<int>> progressDropdownItems() {

  var value = {1:" ",2:"RV",3:"BS" };

  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(
        DropdownMenuItem(
          child: Text(value),
          value:key,
        ));
  });

  return listItem.toList();

}