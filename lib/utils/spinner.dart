
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "dart:math";
typedef SpinFunc = Widget Function();
List<SpinFunc> getAppSpinnerList() {
  final _colors = Colors.blueAccent;
  final _size = 100.0;
  List<SpinFunc> arr = [];

  arr.add(() => SpinKitRotatingPlain( color: _colors, size: _size ));
  arr.add(() => SpinKitDoubleBounce( color: _colors, size: _size ));
  arr.add(() => SpinKitWave( color: _colors, size: _size ));
  arr.add(() => SpinKitWanderingCubes( color: _colors, size: _size ));
  arr.add(() => SpinKitFadingFour( color: _colors, size: _size ));
  arr.add(() => SpinKitFadingCube( color: _colors, size: _size ));
  arr.add(() => SpinKitPulse( color: _colors, size: _size ));
  arr.add(() => SpinKitChasingDots( color: _colors, size: _size ));
  arr.add(() => SpinKitThreeBounce( color: _colors, size: _size ));
  arr.add(() => SpinKitCircle( color: _colors, size: _size ));
  arr.add(() => SpinKitCubeGrid( color: _colors, size: _size ));
  arr.add(() => SpinKitFadingCircle( color: _colors, size: _size ));
  arr.add(() => SpinKitRotatingCircle( color: _colors, size: _size ));
  arr.add(() => SpinKitFoldingCube( color: _colors, size: _size ));
  arr.add(() => SpinKitPumpingHeart( color: _colors, size: _size ));
  arr.add(() => SpinKitDualRing( color: _colors, size: _size ));
  arr.add(() => SpinKitHourGlass( color: _colors, size: _size ));
  arr.add(() => SpinKitFadingGrid( color: _colors, size: _size ));
  arr.add(() => SpinKitRing( color: _colors, size: _size ));
  arr.add(() => SpinKitRipple( color: _colors, size: _size ));
  arr.add(() => SpinKitSpinningCircle( color: _colors, size: _size ));
  arr.add(() => SpinKitSquareCircle( color: _colors, size: _size ));

  return arr;
}

final List<SpinFunc> _spinners = getAppSpinnerList();

final _random = new Random();

Widget getAppSpinner() {
  return _spinners[_random.nextInt(_spinners.length)]();
}
