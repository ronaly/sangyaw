class Person {

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


  Person(

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

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(

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


    String toParams() => "?Facebook Name=$facebookName&Gender=$gender&Address=$address&Age Group=$ageGroup&Messenger Status=$messengerStatus&"
        "Profile Image=$profileImage&Reference Details=$referenceDetails&Assigned To=$assignedTo&Preached By=$preachedBy&"
        "Date Contacted=$dateContacted&Remarks=$remarks&Progress Status=$progressStatus";
    String toString() => "Facebook Name: $facebookName \n Gender: $gender\n Address: $address\n Age Group: $ageGroup\n Messenger Status: $messengerStatus\n "
        "Profile Image: $profileImage\n Reference Details: $referenceDetails\n Assigned To: $assignedTo\n Preached By: $preachedBy\n "
        "Date Contacted: $dateContacted\n Remarks: $remarks\n Progress Status: $progressStatus";

} //Person