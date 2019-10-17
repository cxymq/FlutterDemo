import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/Models/todo.dart';
import 'package:todo_bloc/Models/visibility_filter.dart';


@immutable
abstract class FilteredTodosState extends Equatable {
  FilteredTodosState([List props = const[]]) : super(props);
}
//过滤器包含两个状态：
//1.FilteredTodosLoading：正在获取数据的状态
//2.FilteredTodosLoaded：不在获取数据的状态
 class FilteredTodosLoading extends FilteredTodosState {
   @override
  String toString() {
    return 'FilteredTodosLoading';
  }
 }

 class FilteredTodosLoaded extends FilteredTodosState {
   final List<Todo> filterTodos;
   final VisibilityFilter activeFilter;

   FilteredTodosLoaded(this.filterTodos, this.activeFilter) : super([filterTodos, activeFilter]);

   @override
  String toString() {
    return 'FilteredTodosLoaded {filteredTodos: $filterTodos, activeFilter: $activeFilter}';
  }
   
 }
