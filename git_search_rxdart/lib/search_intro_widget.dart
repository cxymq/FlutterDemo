import 'package:flutter/material.dart';

///输入关键词时显示的组件
class SearchIntro extends StatelessWidget {
  const SearchIntro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Colors.green[200], size: 80.0,),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              '输入搜索词',
              style: TextStyle(color: Colors.green[100])
            ),
          )
        ],
      ),
    );
  }
  
  
}