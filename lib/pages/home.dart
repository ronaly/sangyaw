import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class Home extends AppStatelessLayoutContainer {
  String theText = 'Manangyaw ta tanan atong sangyawan :)';

  @override
  String getTitle(context, AppState state) {
    return 'My Sangyawan App';
  }


  Widget buildBody(context, AppState state) {

    // START BODY HERE
    // Widget body = RichText(
    //   text: TextSpan(
    //     text: theText,
    //     style: TextStyle(
    //       fontSize: 20,
    //       color: Colors.lightBlue,
    //     ),
    //   ),
    // );

Widget body =    Container (
      alignment: Alignment.center,
      child: Text('Manangyaw Na Ta',
      style: TextStyle(
          fontSize: 40,
          foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.blue[700],
      ),),
    );



    //   Widget body = AnimatedDefaultTextStyle(
    //   duration: const Duration(milliseconds: 300),
    //   style: TextStyle(
    //     fontSize: 40,
    //     color: Colors.blueAccent,
    //     fontWeight: FontWeight.bold,
    //     fontFamily: "Canterbury",
    //   ),
    //   child: Text('Manangyaw  na  ta!'),
    // );



    // END/RETURN The body
    return body;
  }

}
