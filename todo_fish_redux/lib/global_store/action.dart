import 'package:fish_redux/fish_redux.dart';

//Action类

///Action 包含两个字段
/// *type
/// *payload
///推荐的写法是
///为一个组件|适配器创建一个 action.dart 文件，包含两个类
/// *为 type 字段起一个枚举类
/// *为 Action 的创建起一个 ActionCreator 类，这样利于约束 payload 的类型。
///Effect 接受处理的 Action，以 on{Verb} 命名
///Reducer 接受处理的 Action，以{verb} 命名

//先枚举出可能要做出的动作
//如：改变主题色,改变字体大小
enum GlobalAction {
  changeThemeColor,
  changeTextSize,
}

//action生成器
class GlobalActionCreator {
  //如果发出 改变主题色动作，则调用此方法
  static Action changeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  //如果发出 改变字体大小，则调用此方法
  static Action changeTextSize() {
    return const Action(GlobalAction.changeTextSize);
  }
}