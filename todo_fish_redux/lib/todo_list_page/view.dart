import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

///View 是一个输出 Widget 的上下文无关的函数。它接收下面的参数
/// *T state
/// *Dispatch
/// *ViewService
///它主要包含三方面的信息
/// *视图完全由数据驱动。
/// *视图产生的事件／回调，通过 Dispatch 发出“意图”，但绝不做具体的实现。
/// *使用依赖的组件／适配器，通过在组件上显示配置，再通过 ViewService 标准化调用。
///     *其中 ViewService 提供了三个能力
///         *BuildContext context，获取 flutter Build-Context 的能力
///         *Widget buildView(String name), 直接创建子组件的能力
///             *这里传入的 name 即在 Dependencies 上配置的名称。
///             *创建子组件不需要传入任何其他的参数，因为子组件需要的参数，已经通过 Dependencies 配置中，将它们的数据关系，通过 connector 确立。
///         *ListAdapter buildAdapter()， 直接创建适配器的能力

Widget buildView(TodoListState state, Dispatch dispatch, ViewService viewService) {
  ///创建在page的 Dependencies 中配置的 adapter
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: const Text('待办事项'),
    ),
    body: Container(
      child: Column(
        children: <Widget>[
          ///公告栏
          viewService.buildComponent('report'),
          ///事项列表，通过adapter展示
          Expanded(
            child: ListView.builder(
              itemBuilder: adapter.itemBuilder,
              itemCount: adapter.itemCount,
            ),
          )
        ],
      ),
    ),
    ///悬浮的增加事项按钮
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      tooltip: 'Add',
      onPressed: () => dispatch(TodoListActionCreator.onAddAction()),
      ),
  );
}
