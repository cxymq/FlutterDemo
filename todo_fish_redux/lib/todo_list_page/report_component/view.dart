import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'state.dart';

//纯UI搭建和布局
Widget buildView(ReportState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(8.0),
    color: Colors.blue,
    child: Row(
      children: <Widget>[
        Container(
          child: const Icon(Icons.report),
          margin: const EdgeInsets.only(right: 8.0),
        ),
        Text(
          '总共 ${state.total} 个任务, ${state.done} 完成.',
          style: const TextStyle(fontSize: 18.0, color: Colors.white),
        )
      ],
    )
  );
}
