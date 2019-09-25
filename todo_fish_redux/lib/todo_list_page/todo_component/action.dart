import 'package:fish_redux/fish_redux.dart';
import 'package:todo_fish_redux/todo_list_page/todo_component/state.dart';


///Action 包含两个字段
/// *type
/// *payload
///推荐的写法是
///为一个组件|适配器创建一个 action.dart 文件，包含两个类
/// *为 type 字段起一个枚举类
/// *为 Action 的创建起一个 ActionCreator 类，这样利于约束 payload 的类型。
///Effect 接受处理的 Action，以 on{Verb} 命名
///Reducer 接受处理的 Action，以{verb} 命名
enum TodoAction { 
  onEdit,//编辑
  edit,//编辑
  done,//完成
  onRemove,//删除
  remove//删除
 }

class TodoActionCreator {
  static Action onEditAction(String uniqueId) {
    return Action(TodoAction.onEdit, payload: uniqueId);
  }

  static Action editAction(TodoState state) {
    return Action(TodoAction.edit, payload: state);
  }

  static Action doneAction(String uniqueId) {
    return Action(TodoAction.done, payload: uniqueId);
  }

  static Action onRemoveAction(String uniqueId) {
    return Action(TodoAction.onRemove, payload: uniqueId);
  }

  static Action removeAction(String uniqueId) {
    return Action(TodoAction.remove, payload: uniqueId);
  }

}
