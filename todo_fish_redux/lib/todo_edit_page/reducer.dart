import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TodoEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<TodoEditState>>{
      TodoEditAction.update: _update,
    },
  );
}

TodoEditState _update(TodoEditState state, Action action) {
  final Map<String, String> update = action.payload ?? <String, String>{};
  final TodoEditState newState = state.clone();
  newState.todo.title = update['name'] ?? newState.todo.title;
  newState.todo.desc = update['desc'] ?? newState.todo.desc;
  return newState;
}
