import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<DropdownMenuItem<int>> ageGroupDropdownItems() {
  var value = {
    1: " ",
    2: "< 12",
    3: "12 to 16",
    4: "17 to 25",
    5: "26 to 35",
    6: "36 to 50",
    7: "> 50"
  };

  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(DropdownMenuItem(
      child: Text(value),
      value: key,
    ));
  });

  return listItem.toList();
}

List<DropdownMenuItem<int>> messengerDropdownItems() {
  var value = {1: " ", 2: "Active", 3: "Inactive"};
  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(DropdownMenuItem(
      child: Text(value),
      value: key,
    ));
  });

  return listItem.toList();
}

List<DropdownMenuItem<int>> genderDropdownItems() {
  var value = {1: " ", 2: "Male", 3: "Female"};

  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(DropdownMenuItem(
      child: Text(value),
      value: key,
    ));
  });

  return listItem.toList();
}

List<DropdownMenuItem<int>> progressDropdownItems() {
  var value = {1: " ", 2: "RV", 3: "BS"};

  List<DropdownMenuItem<int>> listItem = new List();

  value.forEach((key, value) {
    listItem.add(DropdownMenuItem(
      child: Text(value),
      value: key,
    ));
  });

  return listItem.toList();
}

formatDate(var strDate) {
  try {
    var formatter = new DateFormat('MM-dd-yyyy');
    var parDate;
    parDate = DateTime.parse(strDate);
    var newDate;
    if (strDate != null) newDate = formatter.format(parDate);
    return newDate;
  } catch (err) {
    print(err);
    return 'Invalid Date';
  }
} //formatDate

formatDateForDisplay(var strDate) {
  if (strDate == null || strDate == '') {
    return '--';
  }
  try {
    DateTime d = toDate(strDate);
    DateFormat formatter = DateFormat('MMMM d, yyyy');
    return formatter.format(d);
  } catch (err) {
    print(err);
    return 'Invalid Date';
  }
} //formatDate

DateTime toDate(var strDate) {
  try {
    var formatter = new DateFormat('MM/dd/yyyy');
    return formatter.parseUtc(strDate);
  } catch (err) {
    return null;
  }
} //forma

String dateToString(DateTime d) {
  if (d == null) {
    return null;
  }
  DateFormat formatter = DateFormat('MM/dd/yyyy');
  return formatter.format(d);
}
