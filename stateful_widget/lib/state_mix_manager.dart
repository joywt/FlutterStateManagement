import 'package:flutter/material.dart';

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
