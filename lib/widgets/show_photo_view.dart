import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sangyaw_app/model/app_state.dart';
import 'package:sangyaw_app/redux/actions.dart';
import 'package:photo_view/photo_view.dart';

class ShowPhotoView extends StatelessWidget {
  final String netWorkImagePath = "https://drive.google.com/uc?export=view&id=1tuXRwIIBmPxJfv0ApLoptmdsZtzS9rpK";

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 400.0,
        child: Card (
          elevation: 5,
          child: ClipRect (
            child: Align (
              heightFactor: 0.5,
              child: PhotoView(
                imageProvider: NetworkImage(netWorkImagePath),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.contained * 5.8,
                basePosition: Alignment.center,
              ),
            ),
          ),
        )
    );
  } //widget build
} //class