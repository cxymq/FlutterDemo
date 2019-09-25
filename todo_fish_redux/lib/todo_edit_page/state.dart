import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:todo_fish_redux/global_store/state.dart';
import 'package:todo_fish_redux/todo_list_page/todo_component/state.dart';

class TodoEditState implements GlobalBaseState, Cloneable<TodoEditState> {
  //编辑的事项
  TodoState todo;

  //可编辑文本框的控制器
  TextEditingController nameEditController;
  TextEditingController descEditController;

  //获得键盘焦点以及处理监听事件
  FocusNode focusNodeName;
  FocusNode focusNodeDesc;

  @override
  TodoEditState clone() {
    return TodoEditState()
    ..todo = todo
    ..nameEditController = nameEditController
    ..descEditController = descEditController
    ..focusNodeName = focusNodeName
    ..focusNodeDesc = focusNodeDesc
    ..themeColor = themeColor
    ..themeTextSize = themeTextSize;
  }

  @override
  Color themeColor;

  @override
  int themeTextSize;
}

TodoEditState initState(TodoState arg) {
  final TodoEditState state = TodoEditState();
  state.todo = arg?.clone() ?? TodoState();
  state.nameEditController = TextEditingController(text: arg?.title);
  state.descEditController = TextEditingController(text: arg?.desc);
  state.focusNodeName = FocusNode();
  state.focusNodeDesc = FocusNode();
  return state;
}
