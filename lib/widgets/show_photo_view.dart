import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sangyaw_app/widgets/app_stateless_widget.dart';

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