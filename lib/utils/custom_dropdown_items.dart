import 'package:flutter/material.dart';

//List<DropdownMenuItem<int>>
//List<Widget>
List<DropdownMenuItem<int>> messengerDropdownItems() {
  return (
        [
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

        ]
   ).toList();
}

List<DropdownMenuItem<int>> genderDropdownItems() {
  return (
      [
        DropdownMenuItem(
          child: Text(""),
          value:1,
        ),
        DropdownMenuItem(
          child: Text('Male'),
          value:2,
        ),
        DropdownMenuItem(
          child: Text('Female'),
          value:3,
        ),

      ]
  ).toList();
}

List<DropdownMenuItem<int>> progressDropdownItems() {
  return (
      [
        DropdownMenuItem(
          child: Text(""),
          value:1,
        ),
        DropdownMenuItem(
          child: Text('RV'),
          value:2,
        ),
        DropdownMenuItem(
          child: Text('BS'),
          value:3,
        ),

      ]
  ).toList();
}
