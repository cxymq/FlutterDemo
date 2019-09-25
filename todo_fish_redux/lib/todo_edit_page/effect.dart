import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:todo_fish_redux/global_store/action.dart';
import 'package:todo_fish_redux/global_store/store.dart';
import 'action.dart';
import 'state.dart';

///Lifecycle,默认的所有生命周期，本质上都来自于 flutter State 中的生命周期。
///*initState
///*didChangeDependencies
///*build
///*didUpdateWidget
///*deactivate
///*dispose
///在组件内，Reducer 的生命周期是和页面一致的，Effect 和 View 的生命周期是和组件的 Widget 一致的。
///在适配器中，Reducer 的生命周期是和页面一致的，Effect 的生命周期是和 ListView 的生命周期一致，View 的生命周期是短暂的(划入不可见区域即销毁)。
///同时增加了 appear 和 disappear 的生命周期， 代表这个 adapter 管理的视图数组，刚进入显示区和完全离开显示区的回调。
Effect<TodoEditState> buildEffect() {
  return combineEffects(<Object, Effect<TodoEditState>>{
    Lifecycle.initState: _init,
    TodoEditAction.onDone: _onDone,
    TodoEditAction.onChangeTheme: _onChangeTheme,
  });
}

void _init(Action action, Context<TodoEditState> ctx) {
  //对输入框增加监听，一旦值发生变化，进行广播
  ctx.state.nameEditController.addListener(() {
    ctx.dispatch(
      TodoEditActionCreator.update(ctx.state.nameEditController.text, null)
    );
  });

  ctx.state.descEditController.addListener(() {
    ctx.dispatch(
      TodoEditActionCreator.update(null, ctx.state.descEditController.text)
    );
  });
}

void _onDone(Action action, Context<TodoEditState> ctx) {
  Navigator.of(ctx.context).pop(ctx.state.todo);
}

void _onChangeTheme(Action action, Context<TodoEditState> ctx) {
  GlobalStore.store.dispatch(GlobalActionCreator.changeThemeColor());
}