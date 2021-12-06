import 'package:intl/intl.dart';


/// 格式化时间.
String formatTime(int? timestamp) {
  if(timestamp == null) return '--';
  final f = DateFormat('yyyy-MM-dd HH:mm');
  return f.format(DateTime.fromMillisecondsSinceEpoch(timestamp*1000));
}