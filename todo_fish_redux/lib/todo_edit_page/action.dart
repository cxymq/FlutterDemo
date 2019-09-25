import 'package:fish_redux/fish_redux.dart';


///Action 包含两个字段
/// *type
/// *payload
///推荐的写法是
///为一个组件|适配器创建一个 action.dart 文件，包含两个类
/// *为 type 字段起一个枚举类
/// *为 Action 的创建起一个 ActionCreator 类，这样利于约束 payload 的类型。
///Effect 接受处理的 Action，以 on{Verb} 命名
///Reducer 接受处理的 Action，以{verb} 命名

enum TodoEditAction { 
  update,
  onDone,
  onChangeTheme,
 }

class TodoEditActionCreator {
  static Action update(String name, String desc) {
    return Action(
      TodoEditAction.update,
      payload: <String, String>{
        'name': name,
        'desc': desc,
      },);
  }

  static Action onDone() {
    return const Action(TodoEditAction.onDone);
  }

  static Action onChangeTheme() {
    return const Action(TodoEditAction.onChangeTheme);
  }
}
