import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:viawallet_flutter/common/util/coin_util.dart';
import 'package:viawallet_flutter/common/util/image_util.dart';
import 'package:viawallet_flutter/common/util/time_util.dart';
import 'package:viawallet_flutter/http/dio_util.dart';
import 'package:viawallet_flutter/http/viawallet_api.dart';
import 'package:viawallet_flutter/http/viawallet_response.dart';
import 'package:viawallet_flutter/model/exchange_record.dart';
import 'package:viawallet_flutter/model/token_item.dart';
import 'package:viawallet_flutter/widget/via_back_button_widget.dart';
import 'package:viawallet_flutter/widget/via_empty_widget.dart';
import 'package:viawallet_flutter/widget/via_error_widget.dart';
import 'package:viawallet_flutter/widget/via_load_more_widget.dart';
import 'package:viawallet_flutter/widget/via_progress_widget.dart';

/// 闪兑记录页面
class ExchangeRecordPage extends StatefulWidget {
  const ExchangeRecordPage({Key? key}) : super(key: key);

  @override
  _ExchangeRecordPageState createState() => _ExchangeRecordPageState();

}

class _ExchangeRecordPageState extends State<ExchangeRecordPage> {
  final int pageSize = 30;
  int page = 1;

  bool disposed = false;

  bool _refreshing = true;

  bool _success = false;

  List<Record> dataList = [];

  final ScrollController _scrollController = ScrollController();

  final GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey();

  final CancelToken _cancelToken = CancelToken();

  Future<void> onRefresh() async {
    setState(() {
      _refreshing = true;
    });
    _fetchExchangeRecord(true);
  }

  Future<void> loadMore() async {
    _fetchExchangeRecord(false);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    Future.delayed(const Duration(seconds: 0), () {
      refreshKey.currentState!.show();
    });
  }

  @override
  void dispose() {
    disposed = true;
    DioUtil().cancelRequests(_cancelToken);
    super.dispose();
  }

  void _finishPage() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 640),
        orientation: Orientation.portrait);

    return Scaffold(
      appBar: AppBar(
        title: Text('exchange_record'.tr,
            style: const TextStyle(
            fontSize: 17,
            color: Color(0xFF030303))),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: ViaBackButton(color: Colors.black, onPressed: _finishPage),
      ),
      backgroundColor: Colors.white,
      body: _buildRefreshIndicator(),
    );
  }

  RefreshIndicator _buildRefreshIndicator() {
    return RefreshIndicator(
      ///GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
      key: refreshKey,

      ///下拉刷新触发，返回的是一个Future
      onRefresh: onRefresh,
      child: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    if(_refreshing) {
      return const ViaProgressWidget();
    } else {
      if(_success) {
        if(dataList.isEmpty) {
          return const ViaEmptyWidget();
        } else {
          return _buildListView();
        }
      } else {
        if(dataList.isEmpty) {
          return ViaErrorWidget(onPressed: onRefresh);
        } else {
          --page;
          return _buildListView();
        }
      }
    }
  }

  ListView _buildListView() {
    return ListView.builder(
      ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
      physics: const AlwaysScrollableScrollPhysics(),

      ///根据状态返回
      itemBuilder: (context, index) {
        if (index == dataList.length) {
          return const ViaLoadMoreWidget();
        }
        return _buildListItem(index);
      },

      ///根据状态返回数量
      itemCount: (dataList.length >= pageSize)
          ? dataList.length + 1
          : dataList.length,

      ///滑动监听
      controller: _scrollController,
    );
  }

  void _fetchExchangeRecord(bool refresh) async {
    if(refresh) {
      dataList.clear();
      page = 1;
    } else {
      ++page;
    }
    ViaResponse result = await DioUtil().request(pathExchangeRecord, params: {'page': page, 'limit': pageSize}, cancelToken: _cancelToken);
    if(result.code == ViaResponseCode.success) {

      debugPrint("data: ${result.data}");
      ExchangeRecord record = ExchangeRecord.fromJson(result.data);
      dataList.addAll(record.data ?? []);

      if (disposed) {
        return;
      }
      setState(() {
        _refreshing = false;
        _success = true;
      });

    } else {

      final message = result.message ?? "";
      if(message.isEmpty) return;

      if (disposed) {
        return;
      }

      setState(() {
        _refreshing = false;
        _success = false;
      });
      Fluttertoast.showToast(msg: message);
    }
  }

  Widget _buildListItem(int index) {
    return Column(
      children: [
        const SizedBox(height: 13),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatTime(dataList[index].timeStamp),
                  style: const TextStyle(
                    color: Color(0xFF61616C),
                  )),
              _mapStatusWidget(dataList[index].statusCode ?? 0)
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            SizedBox(width: 20.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    getTokenImage(dataList[index].fromCoin, 25),
                    SizedBox(width: 11.5.w),
                    Text("${dataList[index].fromAmt}",
                        style: const TextStyle(
                          color: Color(0xFF27293A),
                          fontSize: 16,
                          fontFamily: 'Alternate',
                        )),
                    SizedBox(width: 10.w),
                    Text("${dataList[index].fromCoin?.symbol?.toUpperCase()}",
                        style: const TextStyle(
                          color: Color(0xFF27293A),
                        )),
                    SizedBox(width: 5.w),
                    _buildChainWidget(dataList[index].fromCoin),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      "images/svg/ic_exchange_record_arrow_down.svg",
                      width: 10.0.w,
                      height: 10.0.w,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    getTokenImage(dataList[index].toCoin, 25),
                    SizedBox(width: 11.5.w),
                    Text("${dataList[index].exchangeAmt}",
                        style: const TextStyle(
                          color: Color(0xFF27293A),
                          fontSize: 16,
                          fontFamily: 'Alternate',
                        )),
                    SizedBox(width: 10.w),
                    Text("${dataList[index].toCoin?.symbol?.toUpperCase()}",
                        style: const TextStyle(
                          color: Color(0xFF27293A),
                        )),
                    SizedBox(width: 5.w),
                    _buildChainWidget(dataList[index].toCoin),
                  ],
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 20.w),
            Text('order_id'.tr,
                style: TextStyle(
                  color: const Color(0xFF61616C),
                  fontSize: 12.sp,
                )),
            SizedBox(width: 2.w),
            Text("${dataList[index].orderId}",
                style: TextStyle(
                  color: const Color(0xFF27293A),
                  fontSize: 12.sp,
                )),
          ],
        ),
        const SizedBox(height: 14),
        const Divider(
          thickness: 1,
          color: Color(0xFFECEDF4),
        )
      ],
    );
  }

  Widget _buildChainWidget(TokenItem? tokenItem) {
    if(tokenItem != null && isToken(tokenItem)) {
      return Container(
        padding:
        EdgeInsets.symmetric(vertical: 1, horizontal: 6.5.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F7),
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Text(
          getChain(tokenItem),
          style: TextStyle(
            fontSize: 10.sp,
            color: const Color(0xFF61616C),
          ),
        ),
      );
    } else {
      return const SizedBox(width: 1);
    }
  }

  Widget _mapStatusWidget(int statusCode) {

    switch(statusCode) {
      case 20000:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15.w),
          decoration: BoxDecoration(
            color: const Color(0x3321D08E),
            borderRadius: BorderRadius.circular(12.5.w),
          ),
          child: Text(
            'exchange_status_success'.tr,
            style: const TextStyle(
                color: Color(0xFF11B979)/*, fontWeight: FontWeight.bold*/),
          ),
        );
      case 20001:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15.w),
          decoration: BoxDecoration(
            color: const Color(0xFFECEDF4),
            borderRadius: BorderRadius.circular(12.5.w),
          ),
          child:  Text(
            'exchange_status_failed'.tr,
          style: const TextStyle(
            color: Color(0xFF838492)),
          ),
        );
      case 20002:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15.w),
          decoration: BoxDecoration(
            color: const Color(0x33FFAB1E),
            borderRadius: BorderRadius.circular(12.5.w),
          ),
          child: Text(
            'exchange_status_confirming'.tr,
            style: const TextStyle(
                color: Color(0xFFFFAB1E)),
          ),
        );
      default:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15.w),
          decoration: BoxDecoration(
            color: const Color(0x33FFAB1E),
            borderRadius: BorderRadius.circular(12.5.w),
          ),
          child: const Text(
            '--',
            style: TextStyle(
            color: Color(0xFFFFAB1E)),
          ),
        );
    }
  }

}
