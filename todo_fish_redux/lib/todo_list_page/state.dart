import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:todo_fish_redux/global_store/state.dart';
import 'package:todo_fish_redux/todo_list_page/report_component/state.dart';
import 'package:todo_fish_redux/todo_list_page/todo_component/state.dart';

class TodoListState implements GlobalBaseState, Cloneable<TodoListState> {
  List<TodoState> todos;

//下方的重写是必须的，否则会报错
  @override
  Color themeColor;

  @override
  int themeTextSize;

  @override
  TodoListState clone() {
    return TodoListState()
    ..todos = todos
    ..themeColor = themeColor
    ..themeTextSize = themeTextSize;
  } 
}

TodoListState initState(Map<String, dynamic> args) {
  return TodoListState();
}

///Connector
///它表达了如何从一个大数据中读取小数据，同时对小数据的修改如何同步给大数据，这样的数据连接关系。
///它是将一个集中式的 Reducer，可以由多层次多模块的小 Reducer 自动拼装的关键。
///它大大降低了我们使用 Redux 的复杂度。我们不再关心组装过程，我们关心的核心是什么动作促使数据怎么变化。
///它使用在配置 Dependencies 中，在配置中我们就固化了大组件和小组件之间的连接关系(数据管道)，所以在我们使用小组件的时候是不需要传入任何动态参数的。
//选择有两个整数的Reselect2，api还有其他多个参数的Reselect
class ReportConnector extends Reselect2<TodoListState, ReportState, int, int> {
  @override
  ReportState computed(int sub0, int sub1) {
    
    return ReportState()
    ..done = sub0
    ..total = sub1;
  }

  @override
  int getSub0(TodoListState state) {
    //使用where查询条件
    return state.todos.where((TodoState tds) => tds.isDone).toList().length;
  }

  @override
  int getSub1(TodoListState state) {
   
    return state.todos.length;
  }

  @override
  void set(TodoListState state, ReportState subState) {
    throw Exception('Unexpected to set PageState from ReportState');
  }

}
