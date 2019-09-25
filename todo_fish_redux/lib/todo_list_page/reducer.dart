import 'package:fish_redux/fish_redux.dart';
import 'package:todo_fish_redux/todo_list_page/todo_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<TodoListState> buildReducer() {
  return asReducer(
    <Object, Reducer<TodoListState>>{
      TodoListAction.initTodos: _initTodosReducer,
    },
  );
}

TodoListState _initTodosReducer(TodoListState state, Action action) {
  final List<TodoState> todos = action.payload ?? <TodoState>[];
  final TodoListState newState = state.clone();
  newState.todos = todos;
  return newState;
}
