
import 'package:flutter/material.dart';
///加载数据中时显示的组件
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(),
    );
  }

}