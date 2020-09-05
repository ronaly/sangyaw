import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sangyaw_app/utils/spinner.dart';

const GOOGLE_DRIVE_SHOW_IMAGE_PATH = 'https://drive.google.com/uc?export=view&id=';

class Person {

  int id;
  String facebookName;
  String gender;
  String address;
  String ageGroup;
  String messengerStatus;
  String profileImage;
  String referenceDetails;
  String assignedTo;
  String preachedBy;
  String dateContacted;
  String remarks;
  String progressStatus;
  File tempImageFile;
  bool tempImageUploading;


  Person(
      this.id,
      this.facebookName,
      this.gender,
      this.address,
      this.ageGroup,
      this.messengerStatus,
      this.profileImage,
      this.referenceDetails,
      this.assignedTo,
      this.preachedBy,
      this.dateContacted,
      this.remarks,
      this.progressStatus,

      ) {
    this.tempImageFile = null;
    this.tempImageUploading = false;
  }
  static Person createEmpty() {
    return new Person(
      null, '', '', '', '', '', '', '', '', '', '', '', ''
    );
  }
  clone() {
    return new Person(
      this.id,
      this.facebookName,
      this.gender,
      this.address,
      this.ageGroup,
      this.messengerStatus,
      this.profileImage,
      this.referenceDetails,
      this.assignedTo,
      this.preachedBy,
      this.dateContacted,
      this.remarks,
      this.progressStatus,

    );
  }

  mutate(Person p) {
    this.id = p.id;
    this.facebookName = p.facebookName;
    this.gender = p.gender;
    this.address = p.address;
    this.ageGroup = p.ageGroup;
    this.messengerStatus = p.messengerStatus;
    this.profileImage = p.profileImage;
    this.referenceDetails = p.referenceDetails;
    this.assignedTo = p.assignedTo;
    this.preachedBy = p.preachedBy;
    this.dateContacted = p.dateContacted;
    this.remarks = p.remarks;
    this.progressStatus = p.progressStatus;
  }

  Widget get image {

    if (tempImageFile != null) {
      if(tempImageUploading) {
        return getAppSpinner();
      }
      return PhotoView(
        imageProvider: new FileImage(tempImageFile),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.contained * 5.8,
        basePosition: Alignment.center,
      );
    }

    if(this.profileImage != null && this.profileImage.length > 0) {
      String url = '${GOOGLE_DRIVE_SHOW_IMAGE_PATH}${this.profileImage}';
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }

    return PhotoView(
      imageProvider: AssetImage('assets/images/notyetuploaded.png'),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.contained * 5.8,
      basePosition: Alignment.center,
    );

  }

  set imageFile(File file) {
    this.tempImageFile = file;
    this.tempImageUploading = false;
  }

  bool get needsUploading {
    if(this.tempImageFile != null && !this.tempImageUploading) {
      return true;
    }
    return false;
  }

  set googleDriveImageId(String id) {
    this.profileImage = id;
    this.tempImageUploading = false;
    this.tempImageFile = null;
  }


  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        int.parse('${json['id']}'),
        "${json["facebookName"]}",
        "${json["gender"]}",
        "${json["address"]}",
        "${json["ageGroup"]}",
        "${json["messengerStatus"]}",
        "${json["profileImage"]}",
        "${json["referenceDetails"]}",
        "${json["assignedTo"]}",
        "${json["preachedBy"]}",
        "${json["dateContacted"]}",
        "${json["remarks"]}",
        "${json["progressStatus"]}"

    );
  } //factory


    String toParams() => "?Facebook Name=$facebookName&Gender=$gender&Address=$address&Age Group=$ageGroup&Messenger Status=$messengerStatus&"
        "Profile Image=$profileImage&Reference Details=$referenceDetails&Assigned To=$assignedTo&Preached By=$preachedBy&"
        "Date Contacted=$dateContacted&Remarks=$remarks&Progress Status=$progressStatus";
    String toString() => "Id: ${id} \n Facebook Name: $facebookName \n Gender: $gender\n Address: $address\n Age Group: $ageGroup\n Messenger Status: $messengerStatus\n "
        "Profile Image: $profileImage\n Reference Details: $referenceDetails\n Assigned To: $assignedTo\n Preached By: $preachedBy\n "
        "Date Contacted: $dateContacted\n Remarks: $remarks\n Progress Status: $progressStatus";

} //Person