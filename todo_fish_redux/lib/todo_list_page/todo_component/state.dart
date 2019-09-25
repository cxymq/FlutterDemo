import 'package:fish_redux/fish_redux.dart';

class TodoState implements Cloneable<TodoState> {

  String uniqueId;//标识，下述构造方法中以时间戳为标识
  String title;//标题
  String desc;//描述
  bool isDone;//是否完成

  TodoState({this.uniqueId, this.title, this.desc, this.isDone = false}) {
    uniqueId ??= DateTime.now().toIso8601String();
  }

  @override
  TodoState clone() {
    return TodoState()
    ..uniqueId = uniqueId
    ..title = title
    ..desc = desc
    ..isDone = isDone;
  }

  @override
  String toString() {
    return 'TodoState(uniqueId: $uniqueId, title: $title, desc: $desc, isDone: $isDone)';
  }
}

TodoState initState(Map<String, dynamic> args) {
  return TodoState();
}
