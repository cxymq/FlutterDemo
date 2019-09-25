import 'package:fish_redux/fish_redux.dart';
import 'package:todo_fish_redux/todo_list_page/todo_component/state.dart';

import '../state.dart';
import 'action.dart';

import '../todo_component/action.dart' as todo_action;

Reducer<TodoListState> buildReducer() {
  return asReducer(
    <Object, Reducer<TodoListState>>{
      ListAction.add: _add,
      todo_action.TodoAction.remove: _remove
    },
  );
}

TodoListState _add(TodoListState state, Action action) {
  final TodoState todo = action.payload;
  final TodoListState newState = state.clone();
  newState.todos.add(todo);
  return newState;
}

TodoListState _remove(TodoListState state, Action action) {
  final String uniqueId = action.payload;
  final TodoListState newState = state.clone();
  newState.todos.removeWhere((TodoState state) => state.uniqueId == uniqueId);
  return newState;
}