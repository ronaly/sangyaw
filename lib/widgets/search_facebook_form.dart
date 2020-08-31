import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/drawer_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';

class SearchFacebookForm extends StatelessWidget {
  //_formKey is needed to validate the form. The validate method will call the validator function of each textfield
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {

   return new Container (
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      TextFormField(
                        controller: _textController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Textfield is Empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Enter Facebook Name:'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blueAccent)),

                          onPressed: () {
                            //Validate() returns true if the form is valid or false otherwise
                            if(_formKey.currentState.validate()) {
                              //if the form is valid, display a snackbar.
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Searching ....',),
                                  duration: Duration(seconds: 2)));

                              performSearch();
                            }

                          },
                          child: Text('Search'),
                        ),
                      )
                    ],
                  )
              )
          )
        ],
      ),
    );
  } //widget build

    void performSearch() {
      String text = _textController.text;
      print('Value in the Textfield = $text');
    }


} //SearchFacebookForm