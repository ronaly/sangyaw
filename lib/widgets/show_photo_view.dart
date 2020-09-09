
import 'package:flutter/material.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

// ignore: must_be_immutable
class ShowPhotoView extends AppStatelessWidget {

  @override
  Widget buildBody(BuildContext context) {
      return SizedBox(
        height: 400.0,
        child: Card (
          elevation: 5,
          child: ClipRect (
            child: Align (
              heightFactor: 0.5,
              child: this.dc.currentPerson.image,
            ),
          ),
        )
    );
  } //widget build
} //class