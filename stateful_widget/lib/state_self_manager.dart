import 'package:flutter/material.dart';

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
