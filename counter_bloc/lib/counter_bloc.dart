import 'dart:async';
import 'package:bloc/bloc.dart';
import 'counter_event.dart';

///bloc类，继承自Bloc<事件， 状态>
class CounterBloc extends Bloc<CounterEvent, int> {
  //重写初始化，默认是0
  @override
  int get initialState => 0;

  //重写事件与状态的映射函数 mapEventToState
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
    }
  }
}
