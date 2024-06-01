# StatefulWidget的状态管理

Flutter 开发中 Widget 状态管理包含以下的几种方式：

1. StatelessWidget 无状态管理
2. StatefulWidget 管理自身的状态
3. 父 widget 管理 子 widget 的状态
4. 混合管理

### 无状态管理

创建 widget 时继承 StatelessWidget，用 final 声明widget 中的变量，初始化widget 时需要给变量赋值并用 const 修饰，那么在整个 widget 的生命周期内，它都是无状态的，也就是不会变化的 widget。

```dart
class NoStatePage extends StatelessWidget {
  const NoStatePage(
      {Key? key,
      required this.text,
      this.backgroundColor = const Color(0xFF42A5F5)})
      : super(key: key);

  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No State Page'),
      ),
      body: Center(
          child: Container(
        color: backgroundColor,
        child: Text(text),
      )),
    );
  }
}
// const 修饰
const NoStatePage(text: "无状态管理变量");
```

### 管理自身的状态

创建 widget 时继承 StatefulWidget，和StatelessWidget不同的是 StatefulWidget类中添加了一个新的接口createState()。createState() 用于创建和 StatefulWidget 相关的状态，它在StatefulWidget 的生命周期中可能会被多次调用。比如，如果 widget 添加在 widget 树中的多个位置，框架会为每一个位置创建一个 State 实例。同样的，如果 widget 从树中移除，稍后又添加到树中，框架会调用 createState() 创建一个新的 State 实例。

```dart
class StateSelfManager extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _StateSelfManagerState createState() => _StateSelfManagerState();
}

class _StateSelfManagerState extends State<StateSelfManager> {
  bool _active = false;
  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('State Parent Manager'),
        ),
        body: Center(
            child: FloatingActionButton(
                onPressed: () {
                  _handleTap();
                },
                child: _active
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow))));
  }
}
```

状态实例中声明了 bool _active 变量，当点击按钮时调用 setState 方法，此时 _active 值变化从而调用 widget 的build 方法，更新视图展示。

### 父 widget 管理子 widget 的状态

在父widget 中声明的变量，透传到子 widget 中去管理子 widget 的视图展示状态。如果变量的状态发生了变化，此时父 widget 和 子 widget 的build 函数都会被调用，从而更新视图展示。

```dart
class StateParentManager extends StatefulWidget {
  const StateParentManager({Key? key}) : super(key: key);

  @override
  _StateParentManagerState createState() => _StateParentManagerState();
}

class _StateParentManagerState extends State<StateParentManager> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("父树 build");
    return Scaffold(
      appBar: AppBar(
        title: Text('State Parent Manager'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tapbox(active: _active, onTap: _handleTapBoxChanged),
        ],
      )),
    );
  }
}

class Tapbox extends StatelessWidget {
  const Tapbox({Key? key, this.active = false, required this.onTap})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onTap;

  void _handleTap() {
    onTap(!active);
  }

  Widget build(BuildContext context) {
    print("子树 build");
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
```

### 混合管理

混合管理即子 widget 管理自己的状态，父 widget 可管理子widget 的状态。这样的方式可以减少状态变更时视图的更新范围。比如子widget 中有一个 highlight 变量，用于管理视图的高亮状态。如果用户触发到视图高亮的状态变化，此时只更新子widget 的build 方法可减少性能的消耗。

```dart
class StateMixManager extends StatefulWidget {
  @override
  _StateMixManagerState createState() => _StateMixManagerState();
}

class _StateMixManagerState extends State<StateMixManager> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("父树 build");
    return Scaffold(
      appBar: AppBar(
        title: Text('State Parent Manager'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("按住不松开观察边框的颜色变化以及日志的输出"),
          SizedBox(height: 20),
          TapboxA(active: _active, onTap: _handleTapBoxChanged),
        ],
      )),
    );
  }
}

class TapboxA extends StatefulWidget {
  TapboxA({Key? key, this.active = false, required this.onTap})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onTap;

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _highlight = false;
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onTap(!widget.active);
  }

  Widget build(BuildContext context) {
    print("子树 build");
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.teal[700]!,
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}
```

