import 'package:fish_redux/fish_redux.dart';
import 'package:todo_fish_redux/global_store/reducer.dart';
import 'package:todo_fish_redux/global_store/state.dart';

//功能
//切换主题颜色
//切换主题字体

//建立Store
class GlobalStore {
  static Store<GlobalState> _globalStore;

  //必须有获取store的方法，如果定义的_globalStore有值则返回，若无值（未初始化），则先初始化再返回
  static Store<GlobalState> get store => _globalStore ??= createStore(GlobalState(), buildReducer());
}