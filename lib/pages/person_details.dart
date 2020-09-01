import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_layout_container.dart';
import 'package:sangyaw_app/model/app_state.dart';

class PersonDetails extends AppLayoutContainer {

  @override
  String getTitle(context, AppState state) {
    return 'Person Details:';
  }

  Widget buildBody(context, AppState state) {

    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [

        SizedBox(
          height: 184.0,
          child: Stack (
            children: <Widget> [
              Positioned.fill(
                // In order to have the ink splash appear above the image, you
                //must use Ink.image. This allows the image to be painted as part
                // of the Material and display ink effects above it. Using a
                // standard image will obscure the ink splash.
                child: Ink.image(
                    image: AssetImage("assets/images/dog.jpeg"),
                    fit: BoxFit.cover,
                    child: Container() ),
              ),
              Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                        this.dc.currentPerson.facebookName
                    ),
                  )
              ),
            ],
          ),
        )
      ],
    ); //Column


  }

}
