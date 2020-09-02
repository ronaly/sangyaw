import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:sangyaw_app/widgets/show_photo_view.dart';
import 'package:sangyaw_app/widgets/custom_text_form_field.dart';
import 'package:sangyaw_app/model/person.dart';


class EditPerson extends AppLayoutContainer {
  final _formKey = GlobalKey<FormState>();

  @override
  String getTitle(context, AppState state) {
    return 'Edit Person:';
  }


  Widget buildBody (context, AppState appState) {
    return Container (
      child: editForm(context),

   );

  } //widget build

  Widget editForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView (
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ShowPhotoView(),
              ListTile (
                title: CustomTextFormField(
                      hintText: 'Facebook Name:',
                      initialValue: this.dc.currentPerson.facebookName,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Facebook name cannot be empty.';}
                        return null; },
                      onSaved: (String value) { this.dc.currentPerson.facebookName = value;},
                  ),
                ),
              ListTile (
                title: CustomTextFormField(
                  hintText: 'Address:',
                  initialValue: this.dc.currentPerson.address ,
                  onSaved: (String value) { this.dc.currentPerson.address = value;},
                ),
              ) ,
              // ListTile (
              //   title: CustomTextFormField(
              //     hintText: 'Address:',
              //     initialValue: this.dc.currentPerson.address ,
              //     onSaved: (String value) { this.dc.currentPerson.address = value;},
              //   ),
              // ) ,
              // ListTile (
              // ) ,
              // ListTile (
              // ) ,
              // ListTile (
              // ) ,
              // ListTile (
              // ) ,
              // ListTile (
              // ) ,
              // ListTile (
              // ) ,
              // ListTile (
              // ) ,
              // ListTile (
              // ) ,
            ], //tiles []
          ).toList(), //ListTiles
        ), //ListView


    ); // Form

  } //listView




} // class