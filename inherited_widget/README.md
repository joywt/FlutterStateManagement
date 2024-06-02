# inherited_widget

在 Flutter 中，InheritedWidget 是一个非常重要的基础类，用于有效地将数据传递给它的子widget树。这个机制主要用于实现 Flutter 中的依赖注入，允许在组件树中的任何位置共享数据。它是 Flutter 状态管理的核心，虽然直接使用 InheritedWidget 的场景比较少，但很多流行的状态管理解决方案（如 Provider）都是基于 InheritedWidget 构建的。这里将介绍 InheritedWidget 和 Provider 的使用方式。

### inheritedWidget的功能和用途

1. **数据共享**。InheritedWidget 最主要的功能是使得在组件树中较深层的部件可以访问在组件树中较高层设置的数据。这种方式比传统的通过构造函数逐层传递数据要高效得多。
2. **依赖管理**。它还管理着组件树中的依赖关系。当 InheritedWidget 更新时，只有那些依赖（使用了相应数据的）部件会被重建，其它部件不会受到影响。这提供了一种非常高效的方式来更新 UI

### 如何使用

​	•	**创建一个** **InheritedWidget**：你创建一个继承自 InheritedWidget 的新类，并在这个类中添加需要共享的数据。

​	•	**在组件树中使用**：将这个 InheritedWidget 放在你的组件树中，使其成为那些需要访问其数据的widget的祖先。

​	•	**数据访问**：其他部件可以通过调用 BuildContext.dependOnInheritedWidgetOfExactType() 来访问这个共享的数据。

```dart
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
```

