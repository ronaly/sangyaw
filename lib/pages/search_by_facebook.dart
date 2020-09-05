import 'package:flutter/material.dart';

import 'package:sangyaw_app/widgets/app_stateful_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/model/person.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';


class SearchByFacebook extends AppStatelessLayoutContainer {
  String theText = 'Search by Facebook Name :)';
  //_formKey is needed to validate the form. The validate method will call the validator function of each textfield
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<String>> facebookGlobalKey = new GlobalKey();

  @override
  String getTitle(context, AppState state) {
    return 'My Sangyawan App';
  }



  Widget buildBody(context, AppState state) {
    return new Container (
      alignment: Alignment.center,
    //  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                      textForm(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: buttonWidget(context),
                      ),
                    ],
                  )
              )
          ),
        ],
      ),
    );
  } //widget build

  Widget textForm() {

    return SimpleAutoCompleteTextField(
      key: facebookGlobalKey,
      decoration: InputDecoration(labelText: 'Enter Facebook Name:',),
      controller: _textController,
      suggestions: this.dc.fbNameList,
      clearOnSubmit: true,
    );

  }


  Widget buttonWidget(BuildContext context) {
    return Builder (
         builder: (context) =>
         Center(
           child: FloatingActionButton.extended(
             tooltip: 'Search',
             icon: Icon(Icons.search),
             label: Text("Search"),
             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),
                 side: BorderSide(color: Colors.blueAccent)),
             onPressed: () {
               //Validate() returns true if the form is valid or false otherwise
               if(_formKey.currentState.validate()) {
                 //if the form is valid, display a snackbar.
                 // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Searching ....',),
                 //     duration: Duration(seconds: 2)));
                 performSearch(_textController.text, context);
               }
             },
           ),
         ),
    ); //Builder
  } //widget button



  void performSearch(String searchString, BuildContext context ) {

    print('Entering performSearch');
    //List<Person> _personList = this.dc.findPersonsFBStartsWith(searchString);
   // this.dc.findPersonsFBContains(searchString);
    this.dc.queryTerm = searchString;
    Navigator.pushNamed(context, '/searched_persons');

  }

} //class
