import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TodoState> buildReducer() {
  return asReducer(
    <Object, Reducer<TodoState>>{
      TodoAction.edit: _edit,
      TodoAction.done: _done,
    },
  );
}

TodoState _edit(TodoState state, Action action) {
  final TodoState todo = action.payload;
  if (state.uniqueId == todo.uniqueId) {
    return state.clone()
    ..title = todo.title
    ..desc = todo.desc;
  }
  return state;
}

TodoState _done(TodoState state, Action action) {
  final String uniqueId = action.payload;
  if (state.uniqueId == uniqueId) {
    return state.clone()
    ..isDone = !state.isDone;
  }
  return state;
}
