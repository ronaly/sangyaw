import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sangyaw_app/utils/app_script_utils.dart';
import 'app_stateful_widget.dart';

import 'package:image_picker/image_picker.dart';


class PhotoEditor extends StatefulWidget {
  @override
  _PhotoEditor createState() => _PhotoEditor();
}


class _PhotoEditor extends AppStatefulWidget<PhotoEditor>  {

  int _counter = 0;

  File _image;
  final picker = ImagePicker();

  getImageFromGallery() {

    picker.getImage(source: ImageSource.gallery).then((pickedFile){
      File f = File(pickedFile.path);
      this.dc.currentPerson.imageFile = f;

      setState(() {
        _image = f;
      });

    }).catchError((err){

      print('=========================');
      print('camera error:');
      print('err');
      print('=========================');

    });
  }

  getImageFromCamera() {
    picker.getImage(source: ImageSource.camera).then((pickedFile){
      File f = File(pickedFile.path);
      this.dc.currentPerson.imageFile = f;
      setState(() {
        _image = f;
      });

    }).catchError((err){

      print('=========================');
      print('camera error:');
      print('err');
      print('=========================');

    });

  }

  uploadImage() {
    print(dc.currentSettings);
    setState(() {
      this.dc.currentPerson.tempImageUploading = true;
    });
    String parentDirId = this.dc.currentSettings.folderId;
    String imageDirName = this.dc.currentSettings.imageFolderName;
    File file = this.dc.currentPerson.tempImageFile;
    String faceBookName = this.dc.currentPerson.facebookName;
    AppScriptUtils.imageUpload(parentDirId, imageDirName, file, faceBookName).then((res){
      print('===========================');
      print('ImageUpload Completed: ${res['completed']}');
      print('ImageUpload imageId: ${res['imageId']}');
      print('ImageUpload imageName: ${res['imageName']}');
      print('===========================');
      this.dc.currentPerson.googleDriveImageId = res['imageId'];
      print(dc.currentPerson);


    }).catchError((err) {
      print('=========================');
      print('upload error:');
      print('err');
      print('=========================');
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

    Widget photo = SizedBox(
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

    return Column(children: [photo, getButtonsArea()],);

  }

  Widget getProgressIndicator() {
    // TODO: Uploading
    return Row(
      textDirection: TextDirection.rtl,
      children: [],
    );

  }

  Widget getButtonsArea() {


    List<Widget> buttons = [];
    buttons.add(Divider(endIndent: 12.0,));

    if(this.dc.currentPerson.tempImageUploading) {
      return getProgressIndicator();
    }




    Widget galleryButton = FloatingActionButton(
      heroTag: null,
      onPressed: getImageFromGallery,
      tooltip: 'Get Image from photo gallery',
      child: Icon(Icons.photo_library ),
    );

    Widget cameraButton = FloatingActionButton(
      heroTag: null,
      onPressed: getImageFromCamera,
      tooltip: 'Get Image by taking a picture',
      child: Icon(Icons.camera_alt),
    );

    buttons.add(galleryButton);
    buttons.add(Divider(endIndent: 15.0,));
    buttons.add(cameraButton);
    buttons.add(Divider(endIndent: 15.0,));




    if(this.dc.currentPerson.needsUploading) {
      Widget uploadButton = FloatingActionButton(

        heroTag: null,
        onPressed: uploadImage,
        tooltip: 'Upload Image',
        child: Icon(Icons.cloud_upload),
      );

      buttons.add(uploadButton);
      buttons.add(Divider(endIndent: 15.0,));
    }


    Widget buttonsHolder = Row(
      textDirection: TextDirection.rtl,
      children: buttons,
    );

    return buttonsHolder;

  }


} //class