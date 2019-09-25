import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/painting.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  int get themeTextSize;

  set themeColor(Color color);
  set themeTextSize(int themeTextSize);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  //重写GlobalBaseState的属性
  @override
  Color themeColor;
  int themeTextSize;

  //重写Cloneable的方法，在reducer处理action之后，需要获取state对象，通过state对象获取其实例变量
  @override
  GlobalState clone() {
    return GlobalState();
  }
}