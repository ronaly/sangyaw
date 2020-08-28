class BucaweForm {


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


  BucaweForm(

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
      this.progressStatus

      );


  String toParams() => "?Facebook Name=$facebookName&Gender=$gender&Address=$address&Age Group=$ageGroup&Messenger Status=$messengerStatus&"
      "Profile Image=$profileImage&Reference Details=$referenceDetails&Assigned To=$assignedTo&Preached By=$preachedBy&"
      "Date Contacted=$dateContacted&Remarks=$remarks&Progress Status=$progressStatus";


  factory BucaweForm.fromJson(dynamic json) {

    return BucaweForm(

        "${json["Facebook Name"]}",
        "${json["Gender"]}",
        "${json["Address"]}",
        "${json["Age Group"]}",
        "${json["Messenger Status"]}",
        "${json["Profile Image"]}",
        "${json["Reference Details"]}",
        "${json["Assigned To"]}",
        "${json["Preached By"]}",
        "${json["Date Contacted"]}",
        "${json["Remarks"]}",
        "${json["Progress Status"]}"

    );



  } //factory





} //BucaweForm


