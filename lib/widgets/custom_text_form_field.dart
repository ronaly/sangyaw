
import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {

    final String hintText;
    final String initialValue;
    final Function validator;
    final Function onSaved;
    final Function onTap;
    final Function onChanged;


  CustomTextFormField( {
    this.hintText,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.onTap,
    this.onChanged,
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
          onTap: onTap,
          onChanged: onChanged,
        ),
      );
  } //widget build
} // end class