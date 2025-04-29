import 'package:flutter/material.dart';
import 'dart:async';

class LoveDurationStore extends ChangeNotifier {
  // 恋爱开始日期
  final DateTime _loveStartDate = DateTime(2025, 2, 16);
  
  // 时长数据
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  
  // 是否在恋爱前
  bool isBeforeLoveDate = true;
  
  Timer? _timer;
  
  LoveDurationStore() {
    _startTimer();
  }
  
  void _startTimer() {
    _updateDuration();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDuration();
    });
  }
  
  void _updateDuration() {
    final now = DateTime.now();
    if (now.isBefore(_loveStartDate)) {
      // 如果当前日期在恋爱开始日期之前
      isBeforeLoveDate = true;
      final duration = _loveStartDate.difference(now);
      days = duration.inDays;
      hours = duration.inHours % 24;
      minutes = duration.inMinutes % 60;
      seconds = duration.inSeconds % 60;
    } else {
      // 已经开始恋爱
      isBeforeLoveDate = false;
      final duration = now.difference(_loveStartDate);
      days = duration.inDays;
      hours = duration.inHours % 24;
      minutes = duration.inMinutes % 60;
      seconds = duration.inSeconds % 60;
    }
    notifyListeners();
  }
  
  // 获取完整的时长数据
  Map<String, int> getDurationData() {
    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
      'totalDays': isBeforeLoveDate ? -days : days,
      'totalHours': isBeforeLoveDate ? -(days * 24 + hours) : days * 24 + hours,
      'totalMinutes': isBeforeLoveDate ? -(days * 24 * 60 + hours * 60 + minutes) : days * 24 * 60 + hours * 60 + minutes,
      'totalSeconds': isBeforeLoveDate ? -(days * 24 * 60 * 60 + hours * 60 * 60 + minutes * 60 + seconds) : days * 24 * 60 * 60 + hours * 60 * 60 + minutes * 60 + seconds,
    };
  }
  
  // 获取纪念日日期
  DateTime getAnniversaryDate() {
    return _loveStartDate;
  }
  
  // 释放资源
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
} 