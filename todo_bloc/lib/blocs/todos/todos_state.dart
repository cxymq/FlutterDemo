import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/Models/todo.dart';

//为表明所有的 TodosState及其子类 不可变，使用 immutable 注解,需要引入meta库
@immutable
///状态类
///使用 Equatable 包，可以直接比较 Todos实例，而不用重写 == 和 hashCode。
abstract class TodosState extends Equatable {
  //构造器，：调用父类的构造器
  TodosState([List props = const[]]) : super(props);
}

///以下有三种状态
///TodosLoading:正在加载数据
///TodosLoaded:数据加载完毕，自然实现类时声明变量 事项列表 todos
///TodosNotLoaded:数据加载失败

class TodosLoading extends TodosState {
  @override
  String toString() {
    return 'TodosLoading';
  }
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;
  TodosLoaded([this.todos = const[]]) : super([todos]);

  @override
  String toString() {
  return 'TodosLoaded {todos: $todos}';
  }
}

class TodosNotLoaded extends TodosState {
  @override
  String toString() {
    return 'TodosNotLoaded';
  }
}