import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/Models/todo.dart';
import 'package:todo_bloc/Models/visibility_filter.dart';

///为FilteredTodosBloc实现两个事件：
///1.UpdateFilter：通知bloc过滤器已更改
///2.UpdateTodos：通知bloc列表已更改
@immutable
abstract class FilteredTodosEvent extends Equatable {
  FilteredTodosEvent([List prop = const[]]) : super(prop);
}

class UpdateFilter extends FilteredTodosEvent {
  final VisibilityFilter filter;
  
  UpdateFilter(this.filter) : super([filter]);

  @override
  String toString() {
    return 'UpdateFilter {filter: $filter}';
  }
}

class UpdateTodos extends FilteredTodosEvent {
  final List<Todo> todos;

  UpdateTodos(this.todos) : super([todos]);

  @override
  String toString() {
    return 'updateTodos {todos: $todos}';
  }
}