import 'package:flutter/material.dart';
import 'dart:async';
import '../../../routes/route_name.dart';

/// APP入口全屏广告页面
class AdPage extends StatefulWidget {
  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  String _info = '';
  late Timer? _timer;
  int timeCount = 3;

  @override
  void initState() {
    _initSplash();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// App广告页逻辑。
  void _initSplash() {
    const timeDur = Duration(seconds: 1); // 1秒

    _timer = Timer.periodic(timeDur, (Timer t) {
      setState(() {
        _info = "欢迎来到我们(gsy,zxk)的APP, $timeCount 秒后跳转到主页";
      });
      if (timeCount <= 0) {
        _timer?.cancel();
        Navigator.pushReplacementNamed(context, RouteName.appMain);
        return;
      }
      timeCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(_info),
          ),
        ],
      ),
    );
  }
}