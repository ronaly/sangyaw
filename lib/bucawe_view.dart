import 'package:flutter/material.dart';
import 'package:sangyaw_app/controller/form_controller.dart';
import 'package:sangyaw_app/model/bucawe_form.dart';


class BucaweView extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Bucawe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: BucaweViewPage(title: "Responses")


    );

  } //Widget build

} //BucaweView

class BucaweViewPage extends StatefulWidget {

  BucaweViewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override

  _BucaweViewPageState createState()  =>  _BucaweViewPageState();


} //BucaweViewPage


class _BucaweViewPageState extends State<BucaweViewPage> {

    List<BucaweForm> bucaweItems = List<BucaweForm>();


    @override
    void initState() {
      super.initState();

      FormController().getDataFromBucaweForm().then((bucaweItems) {

        setState(() {
          this.bucaweItems = bucaweItems;

        });

      });

    } //initState

    @override
    Widget build(BuildContext context) {

      return Scaffold(

        appBar: AppBar(title: Text(widget.title)),
        body: ListView.builder(
          itemCount: bucaweItems.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Row(
                children: <Widget> [
                  Icon(Icons.person),
                  Expanded(
                    child: Text(bucaweItems[index].facebookName),
                  )
                ],
              ),
              subtitle: Row(
                children: <Widget> [
                  Icon(Icons.beach_access),
                  Expanded(
                    child: Text(bucaweItems[index].address),
                  )
                ],
              ),

            );
          }  //itemBuilder
        ),


      );   //Scaffold
  }  // Widget build
} // _BucaweViewPageState