import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';


class CustomDropDownButton extends StatelessWidget {


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





} //class

