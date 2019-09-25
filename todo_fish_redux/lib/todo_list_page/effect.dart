import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:todo_fish_redux/todo_list_page/todo_component/state.dart';

import 'list_adapter/action.dart' as list_action;

import 'action.dart';
import 'state.dart';

///在Fish-Redux中同样，我们通过 dispatch() 一些action实现状态修改，但是相对于状态来说，对外部的操作，
///类似于 SystemChrome.setSystemUIOverlayStyle()这样的操作，都是副作用。
///Effect用法跟Reducer差不太多，但是作用完全不同。
///除了上面介绍的场景之外，异步请求也是一个经常会有的情况，这时候Effect可以帮你方便的解决这些问题。
///你可以通过控制effect的返回值来达到某些目的，默认情况下，effect会在reducer之前被执行。
///当前effect返回 true 的时候，就会停止后续的effect和reducer的操作
///当前effect返回 false 的时候，后续effect和reducer继续执行
/// *Effect 是一个处理所有副作用的函数。它接收下面的参数
///     *Action action
///     *Context context
///        *BuildContext context
///        *T state
///        *dispatch
///        *isDisposed
///Effect会接收来自 View 的“意图”，包括对应的生命周期的回调，然后做出具体的执行。 
///- 它的处理可能是一个异步函数，数据可能在过程中被修改，所以我们应该通过 context.state 获取最新数据。 
///- 如果它要修改数据，应该发一个 Action 到 Reducer 里去处理。它对数据是只读的，不能直接去修改数据。 
///- 如果它的返回值是一个非空值，则代表自己优先处理，不再做下一步的动作；否则广播给其他组件的 Effect 部分，同时发送给 Reducer。

Effect<TodoListState> buildEffect() {
  return combineEffects(<Object, Effect<TodoListState>>{
    Lifecycle.initState: _init,
    TodoListAction.onAdd: _onAdd,
  });
}

//初始化三条数据，注意开头的描述，因此_init函数有这两个参数
void _init(Action action, Context<TodoListState> ctx) {
  final List<TodoState> initTodos = [
    TodoState(
      desc: 'Learn how to program',
      uniqueId: '0',
      title: 'Hello World',
      isDone: true
    ),
    TodoState(
      desc: 'Learn how to build a flutter application',
      uniqueId: '1',
      title: 'Hello Flutter',
      isDone: true
    ),
    TodoState(
      desc: 'Learn how to use fish redux',
      uniqueId: '2',
      title: 'Hello Fish redux',
      isDone: false
    ),
  ];
  //从effect 派发任务到 reducer，effect只负责读取数据，处理数据只能reducer
  ctx.dispatch(TodoListActionCreator.initTodosAction(initTodos));
}

void _onAdd(Action action, Context<TodoListState> ctx) {
  Navigator.of(ctx.context).pushNamed('todo_edit', arguments: null).then((dynamic todo) {
    //从编辑页面返回的 回调，判断下面条件，为true则向reducer派发add行为
    if(todo != null && (todo.title?.isNotEmpty == true || todo.desc?.isNotEmpty == true))  {
      ctx.dispatch(list_action.ListActionCreator.add(todo));
    }
  });
}
