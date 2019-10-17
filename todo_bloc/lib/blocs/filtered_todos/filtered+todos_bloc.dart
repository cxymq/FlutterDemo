import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/Models/todo.dart';
import 'package:todo_bloc/Models/visibility_filter.dart';

import 'package:todo_bloc/blocs/filtered_todos/filtered_todos_event.dart';
import 'package:todo_bloc/blocs/filtered_todos/filtered_todos_state.dart';
import 'package:todo_bloc/blocs/todos/todos.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  //创建 StreamSubscription，监听 TodosBloc的状态变化。
  StreamSubscription todosSubscription;
  
  FilteredTodosBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.state.listen((state) {
      if(state is TodosLoaded) {
        dispatch(UpdateTodos((todosBloc.currentState as TodosLoaded).todos));
      }
    });
  }

  @override
  FilteredTodosState get initialState {
    return todosBloc.currentState is TodosLoaded ? 
    FilteredTodosLoaded(
      (todosBloc.currentState as TodosLoaded).todos,
      VisibilityFilter.all,
    ) : FilteredTodosLoading;
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if(event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if(event is UpdateTodos) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(UpdateFilter event) async* {
    if(todosBloc.currentState is TodosLoaded) {
      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos((todosBloc.currentState as TodosLoaded).todos, event.filter),
        event.filter
      );
    }
  }
      
  Stream<FilteredTodosState> _mapTodosUpdatedToState(UpdateTodos event) async* {
    final visibilityFilter = currentState is FilteredTodosLoaded ? 
      (currentState as FilteredTodosLoaded).activeFilter 
      : VisibilityFilter.all;

      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos((todosBloc.currentState as TodosLoaded).todos, visibilityFilter),
        visibilityFilter,      
      );
  }

  List<Todo> _mapTodosToFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if(filter == VisibilityFilter.all) {
        return true;
      } else if(filter == VisibilityFilter.active) {
        return !todo.complete;
      } else if(filter == VisibilityFilter.completed) {
        return todo.complete;
      }
    }).toList();
  }

//重写bloc的 dispose方法，并在其中取消订阅。
  @override
  void dispose() {
    todosSubscription.cancel();
    super.dispose();
  }
}