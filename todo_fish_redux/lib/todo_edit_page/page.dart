import 'package:fish_redux/fish_redux.dart';
import 'package:todo_fish_redux/todo_list_page/todo_component/state.dart' as ts;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///一个页面内都有且仅有一个 Store
///Page 继承于 Component，所以它能配置所有 Component 的要素
///Page 能配置 Middleware，用于对 Redux 做 AOP 管理
///Page 必须配置一个初始化页面数据的初化函数  initState

class TodoEditPage extends Page<TodoEditState, ts.TodoState> {
  TodoEditPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            // dependencies: Dependencies<TodoEditState>(
            //     adapter: null,
            //     slots: <String, Dependent<TodoEditState>>{
            //     }),
            // middleware: <Middleware<TodoEditState>>[
            // ],
      );

}
