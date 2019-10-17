import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

///事项模型，有四个属性，使用 Equatable 包，可以直接比较 Todos实例，而不用重写 == 和 hashCode。
@immutable
class Todo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  //构造方法，task是必填项，由外部传入，id是随机生成，complete和note是可选项，所以给定默认值
  // Todo(this.task, {this.complete = false, String note = '', String id})
  //  : this.note = note ?? '',
  //    this.id = id ?? Uuid().generateV4(),
  //    super([complete, id, note, task]);

//note是可选的，默认填空
  Todo(this.task, {this.complete = false, this.note = '', String id})
   : this.id = id ?? Uuid().generateV4(),
     super([complete, id, note, task]);

  Todo copyWith({bool complete, String id, String note, String task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  } 

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id}';
  }

//Todo转Entity
  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

//Entity转Todo
  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4()
    );
  }
}