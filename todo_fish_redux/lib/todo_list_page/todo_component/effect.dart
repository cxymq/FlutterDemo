import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';


Effect<TodoState> buildEffect() {
  return combineEffects(<Object, Effect<TodoState>>{
    TodoAction.onEdit: _onEdit,
    TodoAction.onRemove: _onRemove,
  });
}

void _onEdit(Action action, Context<TodoState> ctx) {
  if(action.payload == ctx.state.uniqueId) {
    //跳转页面，并且等待返回
    Navigator.of(ctx.context)
    .pushNamed('todo_edit', arguments: ctx.state)
    .then((dynamic todo) {
          if (todo != null) {
            ctx.dispatch(TodoActionCreator.editAction(todo));
          }
        });
      }
}

void _onRemove(Action action, Context<TodoState> ctx) async {
  final String select = await showDialog(
    context: ctx.context,
    builder: (BuildContext buildContext){
      return AlertDialog(
        title: Text('确定想删除"${ctx.state.title}"?'),
        actions: <Widget>[
          GestureDetector(
            child: const Text(
              '取消',
              style: TextStyle(fontSize: 16.0)
            ),
            onTap: ()=> Navigator.of(buildContext).pop(),
          ),
          GestureDetector(
            child: const Text(
              '确定',
              style: TextStyle(fontSize: 16.0)
            ),
            onTap: ()=> Navigator.of(buildContext).pop('Yes'),
          )
        ],
      );
    }
  );
  if (select == 'Yes') {
    ctx.dispatch(TodoActionCreator.removeAction(ctx.state.uniqueId));
  }
}
