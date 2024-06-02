import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
// 使用 MyInheritedWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold (
        body: MyInheritedWidget(data: 100, child: ,),
      ),
    );
  }
}
// 创建一个继承自 InheritedWidget 的类
class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    required this.data,
    required super.child,
    super.key,
  });

  //需要在子树中共享的数据
  final int data;

  // 定义一个便捷方法，方便子树中的widget获取数据
  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  // 该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新 build
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) =>
      data != oldWidget.data;
}
// 在子widget中访问 MyInheritedWidget
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${MyInheritedWidget.of(context)?.data}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}