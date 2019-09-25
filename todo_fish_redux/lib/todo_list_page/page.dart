import 'package:fish_redux/fish_redux.dart';
import 'package:todo_fish_redux/todo_list_page/list_adapter/adapter.dart' as ListA;
import 'package:todo_fish_redux/todo_list_page/report_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///一个页面内都有且仅有一个 Store
///Page 继承于 Component，所以它能配置所有 Component 的要素
///Page 能配置 Middleware，用于对 Redux 做 AOP 管理
///Page 必须配置一个初始化页面数据的初化函数  initState

///Dependencies 是一个表达组件之间依赖关系的结构。它接收两个字段
/// *slots
///   *<String, Dependent>{}
/// *adapter
///它主要包含三方面的信息
/// *slots，组件依赖的插槽。
/// *adapter，组件依赖的具体适配器（用来构建高性能的 ListView）。
/// *Dependent 是 subComponent | subAdapter + connector 的组合。
/// *一个 组件的 Reducer 由 Component 自身配置的 Reducer 和它的 Dependencies 下的所有子 Reducers 自动复合而成。

//todo_list页面，page其实是Component的子类
class TodoListPage extends Page<TodoListState, Map<String, dynamic>> {
  TodoListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TodoListState>(
                adapter: NoneConn<TodoListState>() + ListA.ListAdapter(),
                slots: <String, Dependent<TodoListState>>{
                  'report': ReportConnector() + ReportComponent()
                }),
            // middleware: <Middleware<TodoListState>>[
            // ],
      );

}
