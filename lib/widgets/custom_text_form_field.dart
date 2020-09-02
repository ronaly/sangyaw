import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';


class CustomTextFormField extends StatelessWidget {

    final String hintText;
    final String initialValue;
    final Function validator;
    final Function onSaved;


  CustomTextFormField( {
    this.hintText,
    this.initialValue,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
      return Padding(

        padding: EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(15.0),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
          ),
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
        ),
      );
  } //widget build
} // end class