import 'package:flutter/material.dart';

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
