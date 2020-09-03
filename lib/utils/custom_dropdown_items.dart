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



