import 'package:flutter/material.dart';
import 'package:stateful_widget/no_state_page.dart';
import 'package:stateful_widget/state_mix_manager.dart';
import 'package:stateful_widget/state_parent_manager.dart';
import 'package:stateful_widget/state_self_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const NoStatePage(text: "无状态管理变量");
                  }));
                },
                child: const Text('无状态')),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StateSelfManager();
                  }));
                },
                child: const Text('管理自身状态')),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const StateParentManager();
                  }));
                },
                child: const Text('父widget管理子widget状态')),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StateMixManager();
                  }));
                },
                child: const Text('混合状态管理')),
          ])),
    );
  }
}
