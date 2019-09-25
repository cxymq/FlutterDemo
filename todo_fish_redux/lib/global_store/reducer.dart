import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'state.dart';
import 'action.dart';

//定义Reducer，纯处理函数，如果要响应 Action，则返回一个新 state，否则还是旧 state
//通过dispatch触发
//Reducer 创建格式如下，只需要补充 相应的action以及对应的处理函数
Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>> {
      GlobalAction.changeThemeColor: _changeThemeColor,
      GlobalAction.changeTextSize: _changeTextSize,
    } 
  );
}

//定义主题颜色列表，每次从中选择一个显示
List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue,
];

//定义一个返回State的方法，action执行一次，颜色依次往下选择
//参数：给定 当前状态 和 action，返回新的状态
GlobalState _changeThemeColor(GlobalState state, Action action) {
  final Color next = _colors[(_colors.indexOf(state.themeColor) + 1) % _colors.length];
  //clone()返回的是state对象，通过级联操作 获取实例变量 themeColor
  return state.clone()..themeColor = next;
}

//定义主题字体大小
List<int> _textSize = [10, 15, 20];

//定义一个返回State的方法
GlobalState _changeTextSize(GlobalState state, Action action) {
  final textSize = _textSize[(_textSize.indexOf(state.themeTextSize) + 1) % _textSize.length];
  return state.clone()..themeTextSize = textSize;
}