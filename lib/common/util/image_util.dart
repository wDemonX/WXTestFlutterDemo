import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:viawallet_flutter/model/token_item.dart';
import 'coin_util.dart';


/// 币种圆形图片.
Widget getTokenImage(TokenItem? tokenItem, double w) {

  String type = tokenItem?.type ?? "";
  String logo = tokenItem?.logo ?? "";
  String symbol = tokenItem?.symbol ?? "";

  String firstChar = symbol.isEmpty ? "" : symbol[0];

  if(logo.isEmpty) {
    if(isToken(tokenItem)) {
      return Container(
        height: w,
        width: w,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: getTokenBgColor(tokenItem),
          borderRadius: BorderRadius.circular(w),
        ),
        child: Text(
          firstChar,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.white),
        ),
      );


    } else {

      return SvgPicture.asset(
        "images/svg/${type.toLowerCase()}.svg",
        width: w,
        height: w,
      );

    }

  } else {
    return ClipOval(
      child: Image.network(
        logo,
        width: w,
        height: w,
        fit: BoxFit.cover,
      ),
    );
  }
}

Color getTokenBgColor(TokenItem? tokenItem) {
  String coin = tokenItem?.type ?? "";
  switch (coin) {
    case 'ONT':
    case 'CET':
      return const Color(0XFF03D2C4);
    case 'ETH':
    case 'MATIC':
      return const Color(0XFF27293A);
    case 'ETC':
      return const Color(0XFF21D08E);
    case 'SLP':
      return const Color(0XFFFFAB1E);
    case 'TRX':
      return const Color(0XFFEB5943);
    case 'VET':
    case 'HT':
      return const Color(0XFF2A64FD);
    case 'BNB':
      return const Color(0XFFEECD0A);
    default:
      return Colors.white;
  }
}