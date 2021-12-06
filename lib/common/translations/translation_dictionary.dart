import 'package:get/get.dart';

class Dictionary extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      'network_error': '网络错误',
      'no_data': '暂无内容',
      'reload': '重新加载',
      'exchange_record': '兑换记录',
      'order_id': '订单ID：',
      'exchange_status_success': '兑换成功',
      'exchange_status_failed': '兑换失败',
      'exchange_status_confirming': '兑换中',
    },
    'en_US': {
      'network_error': 'Network Error',
      'no_data': 'No Content',
      'reload': 'Reload',
      'exchange_record': 'Exchange Record',
      'order_id': 'Order ID:',
      'exchange_status_success': 'Swapped successfully',
      'exchange_status_failed': 'Swap Failed',
      'exchange_status_confirming': 'Swapping',
    },
    'zh_HK': {
      'network_error': '網絡不佳',
      'no_data': '暫無內容',
      'reload': '重新加載',
      'exchange_record': '兌換記錄',
      'order_id': '訂單ID：',
      'exchange_status_success': '兌換成功',
      'exchange_status_failed': '兌換失敗',
      'exchange_status_confirming': '兌換中',
    }
  };
}


