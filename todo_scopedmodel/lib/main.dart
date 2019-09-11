import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_scopedmodel/Model/counter_model.dart';

//此时，我们需要把 CounterModel 放入顶层Widget中，这样所有的子组件都可以访问 model
// void main() => runApp(MyApp());
void main() {
  runApp(MyApp(
    model: CounterModel(),
  ));
}

class MyApp extends StatelessWidget {
  //定义model变量
  final CounterModel model;

  //自定义构造方法，@required 表明调用时必须有参数
  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //此时，最外层返回的则是ScopedModel组件，这样在应用中所有的子组件都可以获取model
    //与下面注释代码进行对比，发现区别
    return ScopedModel<CounterModel> (
      model: model, 
      child: MaterialApp(
        title: 'Scoped Model Demo',
        home: MyHomePage(title: 'Scoped Model Demo'),
      ),
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   home: MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   //获取CounterModel的一种方法，下面可以直接使用
    final counterModel = ScopedModel.of<CounterModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点击了多少次'),
            //获取CounterModel的另一种方法
            ScopedModelDescendant<CounterModel> (
              //当model更新时调用
              builder: (context, child, model){
                return Text(
                  model.counter.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      //onPressed 定义是回调函数，类型是Function，所以需要包装成箭头函数，类似于匿名函数
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterModel.increment(),
        tooltip: '可爱🐶',
        child: Icon(Icons.favorite),
      ),
    );
  }
}

