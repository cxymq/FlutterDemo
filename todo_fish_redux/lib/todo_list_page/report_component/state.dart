import 'package:fish_redux/fish_redux.dart';

class ReportState implements Cloneable<ReportState> {
  //总数，以及完成个数
  int total;
  int done;
  //构造方法，默认都为0
  ReportState({this.total = 0, this.done = 0});

  //继承自Cloneable必须重写clone()，（..）是级联操作，可以在一个对象上多次操作 
  @override
  ReportState clone() {
    return ReportState()
    ..total = total
    ..done = done;
  }

  @override
  String toString() {
    return 'ReportState{total: $total, done: $done}';
  }
}
