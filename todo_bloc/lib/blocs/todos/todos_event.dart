import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/Models/todo.dart';

@immutable
abstract class TodosEvent extends Equatable {
  TodosEvent([List props = const[]]) : super(props);
}

///所有的事件都需要在 TodosBloc中处理：
// 1.LoadTodos：通知bloc加载存储库中的事项
// 2.AddTodo：通知bloc添加新事项
// 3.UpdateTodo：通知bloc更新事项
// 4.DeleteTodo：通知bloc删除事项
// 5.ClearCompleted：通知bloc移除所有已完成的事项
// 6.ToggleAll：通知bloc切换所有事项的状态为已完成

class LoadTodos extends TodosEvent {
  @override
  String toString() => 'LoadTodos';
}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo) : super([todo]);

  @override
  String toString() {
    return 'AddTodo {todo : $todo}';
  }
}

class UpdateTodo extends TodosEvent {
  final Todo updateTodo;

  UpdateTodo(this.updateTodo) : super([updateTodo]);

  @override
  String toString() {
    return 'UpdateTodo {todo : $updateTodo}';
  }
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  DeleteTodo(this.todo) :super([todo]);

  @override
  String toString() {
    return 'DeleteTodo {todo : $todo}';
  }
}

class ClearCompleted extends TodosEvent {
  @override
  String toString() {
    return 'ClearCompleted';
  }
}

class ToggleAll extends TodosEvent {
  @override
  String toString() {
    return 'ToggleAll';
  }
}