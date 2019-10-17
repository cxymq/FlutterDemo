import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_bloc/blocs/todos/todos_event.dart';
import 'package:todo_bloc/blocs/todos/todos_state.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todo_bloc/Models/todo.dart';
///业务逻辑类
///继承 Bloc，并重写 initialState 和 mapEventToState。
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepositoryFlutter todosRepository;

  TodosBloc({@required this.todosRepository});

  @override
  TodosState get initialState => TodosLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if(event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if(event is AddTodo) {
      yield* _mapAddTodoState(event);
    } else if(event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if(event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if(event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if(event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } 
  }

//初始化时 加载数据
  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await this.todosRepository.loadTodos();
      yield TodosLoaded(
        todos.map(Todo.fromEntity).toList()
      );
    } catch(_) {
      yield TodosNotLoaded();
    }
  }

//添加 待办事项
  Stream<TodosState> _mapAddTodoState(AddTodo event) async* {
    if(currentState is TodosLoaded) {
      final List<Todo> updatedTodos = List.from((currentState as TodosLoaded).todos)..add(event.todo);
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  //更新 待办事项
  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if(currentState is TodosLoaded) {
      final List<Todo> updatedTodos = (currentState as TodosLoaded).todos.map((todo) {
        return todo.id == event.updateTodo.id ? event.updateTodo : todo;
      }).toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  //删除 待办事项
  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if(currentState is TodosLoaded) {
      final List<Todo> deleteTodo = (currentState as TodosLoaded).todos.where((todo) => todo.id != event.todo.id).toList();
      yield TodosLoaded(deleteTodo);
      _saveTodos(deleteTodo);
    }
  }

  //改变 事项状态
  Stream<TodosState> _mapToggleAllToState() async* {
    if(currentState is TodosLoaded) {
      final allComplete = (currentState as TodosLoaded).todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = (currentState as TodosLoaded).todos.map((todo) => todo.copyWith(complete: !allComplete)).toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  //清空完成的事项
  Stream<TodosState> _mapClearCompletedToState() async* {
    if(currentState is TodosLoaded) {
      final List<Todo> updatedTodos = (currentState as TodosLoaded).todos.where((todo) => !todo.complete).toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

//将更改保存到本地存储
  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
