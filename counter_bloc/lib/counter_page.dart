import 'package:counter_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';

///主页面
class CounterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //获取CounterBloc实例
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Counter"),
      ),
      body: BlocBuilder<CounterBloc, int> (
        builder: (context, count) {
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      //悬浮按钮
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                //发送递增事件
                counterBloc.dispatch(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                //发送递减事件
                counterBloc.dispatch(CounterEvent.decrement);
              },
            ),
          )
        ],
      ),
    );
  }
}
