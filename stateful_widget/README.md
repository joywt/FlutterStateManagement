# stateful_widget

A new Flutter project.

1. const Widget。 Dart 语言中 const 声明的变量是编译时常量，在编译时直接替换为常量的值。const 声明的 Widget 是不可变的，不能改变。所以当 widget 为 statefulWidget 如果用 const 修饰符，编译期会报错。
2. 一个 StatefulWidget 同时插入到 widget 树的多个位置时，Flutter 框架就会调用该方法为每一个位置生成一个独立的State实例，createState 会被调用多次。
3. StatefulWidget 的 State 是可变的，所以 StatefulWidget 可以改变。