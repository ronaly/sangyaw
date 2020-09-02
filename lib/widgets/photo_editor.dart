import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'app_stateful_widget.dart';

import 'package:image_picker/image_picker.dart';


class PhotoEditor extends StatefulWidget {
  @override
  _PhotoEditor createState() => _PhotoEditor();
}


class _PhotoEditor extends AppStatefulWidget<PhotoEditor>  {

  final String netWorkImagePath = "https://drive.google.com/uc?export=view&id=1tuXRwIIBmPxJfv0ApLoptmdsZtzS9rpK";
  int _counter = 0;

  File _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }


  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget buildBody(BuildContext context) {

     ImageProvider img = NetworkImage(netWorkImagePath);
     if (_image != null) {
       img = new FileImage(_image);
     }

      Widget photo = SizedBox(
          height: 400.0,
          child: Card (
            elevation: 5,
            child: ClipRect (
              child: Align (
                heightFactor: 0.5,
                child: PhotoView(
                  imageProvider: img,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.contained * 5.8,
                  basePosition: Alignment.center,
                ),
              ),
            ),
          )
      );





      Widget buttons = Row(
                textDirection: TextDirection.rtl,
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: getImageFromGallery,
                    tooltip: 'Increment',
                    child: Icon(Icons.photo_library ),
                  ),
//                  Spacer(flex: 1,),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: getImageFromCamera,
                    tooltip: 'Increment',
                    child: Icon(Icons.camera_alt),
                  ),
                ],
              );

      return Column(children: [photo, buttons],);

  } //widget build


} //class