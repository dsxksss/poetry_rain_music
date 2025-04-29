import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/update_app/check_app_version.dart';
import '../../../routes/route_name.dart';
import '../../../config/app_env.dart' show appEnv;
import 'provider/counterStore.p.dart';
import 'provider/love_duration_store.p.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.params}) : super(key: key);
  final dynamic params;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late CounterStore _counter;
  FocusNode blankNode = FocusNode(); // 响应空白处的焦点的Node

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _counter = Provider.of<CounterStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('home页面'),
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: contextWidget(),
      ),
    );
  }

  Widget contextWidget() {
    return ListView(
      children: List.generate(1, (index) {
        return Column(
          children: <Widget>[
            _buildLoveDurationDemo(),
          ],
        );
      }),
    );
  }

  // 恋爱时长数据演示组件 - 仅作为数据获取示例
  Widget _buildLoveDurationDemo() {
    return Consumer<LoveDurationStore>(
      builder: (context, loveDurationStore, child) {
        final durationData = loveDurationStore.getDurationData();

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('恋爱时长数据示例 (使用Provider):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5.h),
              Text('天数: ${durationData['days']}'),
              Text('小时: ${durationData['hours']}'),
              Text('分钟: ${durationData['minutes']}'),
              Text('秒数: ${durationData['seconds']}'),
              SizedBox(height: 5.h),
              Text('总天数: ${durationData['totalDays']}'),
              Text('总小时: ${durationData['totalHours']}'),
              Text('总分钟: ${durationData['totalMinutes']}'),
              Text('总秒数: ${durationData['totalSeconds']}'),
              SizedBox(height: 5.h),
              Text(
                  '恋爱纪念日: ${_formatDate(loveDurationStore.getAnniversaryDate())}'),
              Text(
                  '数据状态: ${loveDurationStore.isBeforeLoveDate ? "倒计时" : "正计时"}'),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }

  Widget _button(String text, {VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 22.sp),
        ),
      ),
    );
  }
}
