import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {
  int _counter = 0;

  //get方法，获取_counter值
  int get counter => _counter;

  //每次调用，_counter 加1
  void increment() {
    _counter ++;

    //通知所有的监听类，数据改变
    notifyListeners();
  }
}